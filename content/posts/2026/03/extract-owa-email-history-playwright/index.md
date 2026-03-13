---
title: "If You Can Read It in OWA, You Can Archive It: A Playwright Approach"
slug: "extract-owa-email-history-playwright"
date: 2026-03-11T12:00:00+01:00
draft: false

categories:
- security

tags:
- python
- playwright
- owa
- data-ownership
- gdpr
- compliance
- workplace
- docker

author: "Ronny Roethof"

description: "Extract and archive Outlook Web Access email using Python and Playwright for compliance, GDPR data ownership and personal archiving."
---


### The Policy of Silence

I’ve seen it time and again. High-pressure workplaces. A decade of burnout cycles. A management layer that loves “transparency” until it concerns your own record.

The latest corporate trick? **Outlook Web Access (OWA) only.** By disabling PST exports and local storage they are not just “securing the perimeter.” They are gatekeeping access to your own evidence. If your account is decommissioned tomorrow every broken promise every after-hours escalation every gaslighting “Time Management” email vanishes.

**I don’t ask for permission to own my history. I script it.**

----------

## Pipeline Overview

1.  **Harvester** – `1_Harvester.py` → extracts raw HTML from OWA and saves JSON.
    
2.  **Fixer** – `2_Fixer.py` → normalizes timestamps, metadata, and cleans the body.
    
3.  **Auditor** – `3_Auditor.py` → deduplicates, flags contract breaches and critical terms, generates CSV.
    
4.  **Visualizer** – `4_Visualizer.py` → shows trends in terminal or CSV.
    
5.  **Orchestrator** – `full_run.sh` → runs the full pipeline.
    

----------

Please do note that I use **Dutch date formatting (`DD-MM-YYYY HH:MM`)**, weekday names, and localized CSV delimiters (`;`). This ensures consistency with the environment I operate in and avoids ambiguity when auditing emails or generating trend reports. All code, CSVs, and outputs reflect this format.

----------

**Security Note**

Credentials should always be provided through **environment variables** or a **secrets manager**. Authentication data should **never be committed to version control**. This keeps your OWA account safe and avoids accidental exposure in repos.

----------

## 1. Harvester: 1_Harvester.py

```python
#!/usr/bin/env python3
import os, json, time, asyncio
from uuid import uuid4
from datetime import datetime
from playwright.async_api import async_playwright

# ALGEMENE UITLEG:
# Script simulates clicking through OWA
# Saves each email as raw JSON with sender, subject, body, and scan timestamp

async def heartbeat_task(page, data_root):
    while True:
        try:
            await page.screenshot(path=f"{data_root}/heartbeat.png")
        except:
            pass
        await asyncio.sleep(10)

async def brute_harvest():
    user = os.getenv("OWA_USER", "user@example.com")
    password = os.getenv("OWA_PASS", "password123")
    data_root = "./data"
    raw_dump_dir = os.path.join(data_root, "raw_dump")
    os.makedirs(raw_dump_dir, exist_ok=True)

    async with async_playwright() as p:
        context = await p.chromium.launch_persistent_context(
            "./owa_session",
            headless=True,
            args=["--no-sandbox", "--disable-dev-shm-usage"]
        )
        
        page = context.pages[0] if context.pages else await context.new_page()
        await page.set_viewport_size({"width": 1280, "height": 1024})
        asyncio.create_task(heartbeat_task(page, data_root))
        
        print(f"[*] Navigating to OWA for {user}...")
        await page.goto("https://outlook.office.com/mail/inbox", wait_until="networkidle")
        await asyncio.sleep(8)

        # --- LOGIN FLOW (placeholder safe) ---
        # Simulate login without storing any real credentials in the repo
        print("[*] Simulated login complete")

        count = 0
        last_height = 0
        stuck_patience = 0
        processed_labels = set()
        
        while True:
            items = await page.query_selector_all('div[role="option"]')
            for item in items:
                try:
                    label = await item.get_attribute('aria-label') or "Sender <email@example.com>"
                    if label in processed_labels:
                        continue
                    
                    await item.click()
                    await asyncio.sleep(2)
                    
                    subject_el = await page.query_selector('div[role="heading"][aria-level="2"]')
                    subject = await subject_el.inner_text() if subject_el else "No Subject"
                    
                    content_el = await page.query_selector('div.allowTextSelection')
                    content_html = await content_el.inner_html() if content_el else "No content"
                    
                    uid = f"{int(time.time() * 1000)}_{uuid4().hex[:4]}"
                    with open(f"{raw_dump_dir}/mail_{uid}.json", 'w', encoding='utf-8') as f:
                        json.dump({
                            "subject": subject,
                            "sender_info": label,
                            "content": content_html,
                            "date_scanned": datetime.now().strftime("%d-%m-%Y %H:%M")
                        }, f)
                    
                    processed_labels.add(label)
                    count += 1
                    if count % 10 == 0:
                        print(f"[+] {count} mails harvested...")
                except:
                    continue

            await page.evaluate('document.querySelector("div[role=\'listbox\']").scrollBy(0, 1200)')
            await asyncio.sleep(4) 

            new_height = await page.evaluate('document.querySelector("div[role=\'listbox\']").scrollTop')
            if new_height == last_height:
                stuck_patience += 1
                if stuck_patience >= 5:
                    print("[*] End of mailbox reached")
                    break
            else:
                stuck_patience = 0
                last_height = new_height

if __name__ == "__main__":
    asyncio.run(brute_harvest())
    print("[V] Raw dump ready in ./data/raw_dump")

```

----------

## 2. Fixer: 2_Fixer.py

```python
#!/usr/bin/env python3
import os, json, re
from datetime import datetime, timedelta
from bs4 import BeautifulSoup

RAW_DIR = "./data/raw_dump"
PROC_DIR = "./data/processed"

def calculate_real_date(date_str, scan_timestamp_ms):
    try:
        scan_dt = datetime.fromtimestamp(int(scan_timestamp_ms)/1000)
    except:
        scan_dt = datetime.now()
    
    day_map = {'ma':0,'di':1,'wo':2,'do':3,'vr':4,'za':5,'zo':6}
    match = re.match(r'(ma|di|wo|do|vr|za|zo)\s+(\d{2}:\d{2})', date_str.lower())
    if match:
        target_day = day_map[match.group(1)]
        time_part = match.group(2)
        days_back = (scan_dt.weekday() - target_day) % 7
        real_date = scan_dt - timedelta(days=days_back)
        return f"{real_date.strftime('%d-%m-%Y')} {time_part}"
    return scan_dt.strftime('%d-%m-%Y')

def extract_metadata_and_body_recovery(raw_data):
    label = raw_data.get("sender_info") or ""
    raw_body = raw_data.get("content") or ""
    clean_body_text = re.sub(r'[\ue000-\uf8ff]', '', raw_body)
    soup = BeautifulSoup(clean_body_text, "html.parser")
    final_body = soup.get_text(separator=' ').strip()
    subject = raw_data.get("subject","No Subject")
    sender = label
    return sender.strip(), subject.strip(), "Onbekend", final_body

def run_fixer():
    os.makedirs(PROC_DIR, exist_ok=True)
    count = 0
    for filename in sorted(os.listdir(RAW_DIR)):
        if not filename.endswith(".json"): continue
        scan_ts = filename.split('_')[1]
        with open(os.path.join(RAW_DIR, filename), 'r', encoding='utf-8') as f:
            raw_data = json.load(f)
            sender, subject, temp_date, body = extract_metadata_and_body_recovery(raw_data)
            final_date = calculate_real_date(temp_date, scan_ts)
            processed_data = {
                "origin": filename,
                "date": final_date,
                "sender": sender,
                "subject": subject,
                "body": body
            }
            with open(os.path.join(PROC_DIR, f"proc_{filename}"), 'w', encoding='utf-8') as out:
                json.dump(processed_data, out, indent=4)
            count += 1
    print(f"[V] Fixer complete: {count} files processed")

if __name__ == "__main__":
    run_fixer()

```

----------

## 3. Auditor: 3_Auditor.py

```python
#!/usr/bin/env python3
import os, json, csv, holidays, re
from datetime import datetime
from collections import defaultdict

VRIJE_MIDDAG = 3
START_AVOND = 18
NL_HOLIDAYS = holidays.Netherlands()

PRIO_TERMS = ["overtime","audit","contract","urgent","performance","pip"]

PROC_DIR = "./data/processed"

def audit():
    results = []
    seen_hashes = set()
    monthly_stats = defaultdict(lambda: {"totaal":0,"breuk":0,"prio_count":0})
    files = [f for f in os.listdir(PROC_DIR) if f.endswith(".json")]
    for f_name in files:
        with open(os.path.join(PROC_DIR, f_name), 'r', encoding='utf-8') as f:
            d = json.load(f)
            content_hash = hash(re.sub(r'\W+','',d['body'][:300].lower()))
            if content_hash in seen_hashes: continue
            seen_hashes.add(content_hash)
            try:
                dt = datetime.strptime(d['date'], "%d-%m-%Y %H:%M")
            except:
                dt = datetime.strptime(d['date'].split()[0], "%d-%m-%Y")
            month_key = dt.strftime("%Y-%m")
            is_holiday = dt.date() in NL_HOLIDAYS
            is_after_hours = dt.hour >= START_AVOND
            is_weekend = dt.weekday()>=5
            is_vrije_middag = dt.weekday()==VRIJE_MIDDAG and dt.hour>=12
            status = "OK"
            if is_holiday: status = f"BREUK (FEESTDAG: {NL_HOLIDAYS.get(dt.date())})"
            elif is_weekend: status="BREUK (WEEKEND)"
            elif is_vrije_middag: status="BREUK (VRIJE MIDDAG)"
            elif is_after_hours: status="BREUK (OVERWERK)"
            search_text = f"{d['subject']} {d['body']}".lower()
            found_terms = [term for term in PRIO_TERMS if re.search(r'\b'+re.escape(term)+r'\b',search_text)]
            is_prio = len(found_terms)>0
            monthly_stats[month_key]["totaal"] += 1
            if "BREUK" in status: monthly_stats[month_key]["breuk"] += 1
            if is_prio: monthly_stats[month_key]["prio_count"] += 1
            results.append({
                "dt_obj": dt,
                "Datum": d['date'],
                "Dag": dt.strftime("%A"),
                "Status": status,
                "Van": d['sender'],
                "Onderwerp": d['subject'],
                "Prioriteit": "KRITIEK" if is_prio else "Normaal",
                "Gevonden_Termen": ", ".join(found_terms) if found_terms else "",
                "Body": d['body']
            })
    results.sort(key=lambda x: x["dt_obj"])
    fields = ["Datum","Dag","Status","Van","Onderwerp","Prioriteit","Gevonden_Termen"]
    with open("CRITISCH_DOSSIER.csv","w",newline='',encoding='utf-8-sig') as f:
        writer = csv.DictWriter(f, fieldnames=fields,delimiter=';',extrasaction='ignore')
        writer.writeheader()
        writer.writerows([r for r in results if r["Prioriteit"]=="KRITIEK" or "BREUK" in r["Status"]])
    print("[V] Auditor complete")
    
if __name__ == "__main__":
    audit()

```

----------

## 4. Visualizer: 4_Visualizer.py

```python
#!/usr/bin/env python3
import csv, os

def visualize():
    bestandsnaam = "PIEK_ANALYSE_MAAND.csv"
    if not os.path.exists(bestandsnaam):
        print(f"[!] {bestandsnaam} not found. Run Auditor first")
        return
    with open(bestandsnaam,"r",encoding='utf-8') as f:
        reader = csv.reader(f,delimiter=',')
        data = list(reader)
        print("\nMONTHLY CONTRACT BREACH TREND")
        print("="*70)
        for row in data[1:]:
            if not row or len(row)<3: continue
            maand = row[0]
            try: perc = float(row[2])
            except: continue
            bar = "█"*int(perc/2)
            status=""
            if perc>30: status=" [SYSTEM FAILURE]"
            elif perc>15: status=" [OVERLOAD]"
            elif perc>5: status=" [INCIDENT]"
            print(f"{maand:<10} | {bar:<50} {perc:>5.1f}%{status}")
        print("="*70+"\n")

if __name__=="__main__":
    visualize()

```

----------

## 5. Full Run: full_run.sh

```bash
#!/bin/bash
echo "[*] Starting full OWA dossier pipeline"
python3 2_Fixer.py
python3 3_Auditor.py
python3 4_Visualizer.py
echo "[V] Pipeline complete"
echo "[>] Check 'CRITISCH_DOSSIER.csv' for key insights"

```

----------

## Docker Setup

**docker-compose.yml**

```yaml
services:
  harvester:
    build: .
    container_name: owa_bot_instance
    shm_size: '2gb'
    environment:
      - OWA_USER=$USER
      - OWA_PASS=$PASSWORD
      - PYTHONUNBUFFERED=1
    volumes:
      - ./owa_session:/app/owa_session
      - ./data:/app/data
    restart: unless-stopped

```

**Dockerfile**

```dockerfile
FROM mcr.microsoft.com/playwright:v1.58.0-noble
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1
RUN apt-get update && apt-get install -y python3-pip && rm -rf /var/lib/apt/lists/*
WORKDIR /app
RUN pip3 install --no-cache-dir playwright==1.58.0 holidays --break-system-packages
RUN mkdir -p /app/data /app/owa_session && chown -R 1000:1000 /app
COPY --chown=1000:1000 . .
USER 1000
ENTRYPOINT ["python3","1_Harvester.py"]

```


### Why You Should Do The Same

Corporate memory is selective. Management "forgets" the overtime you put in. They "misplace" the minutes of that one meeting where you flagged the lack of resources.

Technological audit is the only defense against operational neglect. If you can see it in your browser, you can own it in a CSV.

*Stay critical. Stay automated. Own your data.*