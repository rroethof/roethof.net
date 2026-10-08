#!/usr/bin/env python3
"""
fix_taxonomy.py — Hugo front matter taxonomy cleaner voor roethof.net

Gebruik:
    python3 fix_taxonomy.py --dir ./content --dry-run
    python3 fix_taxonomy.py --dir ./content

Opties:
    --dir       Root van je Hugo content directory (default: ./content)
    --dry-run   Toont wat er zou veranderen, schrijft niets weg
    --verbose   Toont ook posts die niet gewijzigd worden

Vereisten:
    pip install pyyaml
"""

import argparse
import sys
from pathlib import Path

import yaml


# ─────────────────────────────────────────────────────────────
# MAPPING: oude categorie (lowercase) → nieuwe categorie
# ─────────────────────────────────────────────────────────────
CATEGORY_MAP = {
    # security-privacy
    "security":                                         "security-privacy",
    "security & privacy":                               "security-privacy",
    "cybersecurity":                                    "security-privacy",
    "security best practices":                          "security-privacy",
    "security policy & management":                     "security-privacy",
    "system hardening":                                 "security-privacy",
    "human factors in security":                        "security-privacy",
    "risk management":                                  "security-privacy",
    "usability in security":                            "security-privacy",
    "ciso concerns":                                    "security-privacy",
    "privacy":                                          "security-privacy",
    "privacy-focused software":                         "security-privacy",

    # linux-open-source
    "linux":                                            "linux-open-source",
    "linux & open source":                              "linux-open-source",
    "opensource":                                       "linux-open-source",
    "open source":                                      "linux-open-source",
    "freebsd":                                          "linux-open-source",
    "arch linux":                                       "linux-open-source",
    "operatingsystems":                                 "linux-open-source",
    "operating systems":                                "linux-open-source",
    "desktop customization":                            "linux-open-source",

    # devops-infrastructure
    "devops":                                           "devops-infrastructure",
    "devops & infrastructure":                          "devops-infrastructure",
    "infrastructure":                                   "devops-infrastructure",
    "infrastructure & servers":                         "devops-infrastructure",
    "it infrastructure":                                "devops-infrastructure",
    "automation":                                       "devops-infrastructure",
    "automation & scripting":                           "devops-infrastructure",
    "automatisering":                                   "devops-infrastructure",
    "configuration management":                         "devops-infrastructure",
    "monitoring & observability":                       "devops-infrastructure",
    "ansible":                                          "devops-infrastructure",
    "docker":                                           "devops-infrastructure",
    "virtualization":                                   "devops-infrastructure",
    "virtualization & cloud":                           "devops-infrastructure",
    "hybrid cloud":                                     "devops-infrastructure",
    "cloud computing":                                  "devops-infrastructure",
    "networking":                                       "devops-infrastructure",
    "system management":                                "devops-infrastructure",
    "storage management":                               "devops-infrastructure",
    "local development":                                "devops-infrastructure",
    "web interfaces":                                   "devops-infrastructure",

    # digital-sovereignty
    "digital sovereignty":                              "digital-sovereignty",
    "sovereignty":                                      "digital-sovereignty",
    "geopolitics":                                      "digital-sovereignty",
    "politics":                                         "digital-sovereignty",
    "politics & government":                            "digital-sovereignty",
    "eu":                                               "digital-sovereignty",
    "europe":                                           "digital-sovereignty",
    "netherlands":                                      "digital-sovereignty",
    "government":                                       "digital-sovereignty",
    "tech policy":                                      "digital-sovereignty",
    "it strategy":                                      "digital-sovereignty",
    "industry trends":                                  "ai-tech-insights",
    "technology & society":                             "digital-sovereignty",
    "technical deep dive":                              "devops-infrastructure",

    # career-sysadmin
    "career":                                           "career-sysadmin",
    "career & professional development":                "career-sysadmin",
    "sysadmin":                                         "career-sysadmin",
    "sysadmin life":                                    "career-sysadmin",
    "leadership":                                       "career-sysadmin",
    "professionalism":                                  "career-sysadmin",
    "future of work":                                   "career-sysadmin",
    "learning & growth":                                "career-sysadmin",
    "it failure":                                       "career-sysadmin",
    "ethics":                                           "career-sysadmin",
    "online communication":                             "career-sysadmin",
    "communication & collaboration":                    "career-sysadmin",

    # health-ergonomics
    "health":                                           "health-ergonomics",
    "ergonomics":                                       "health-ergonomics",
    "ergonomics & health":                              "health-ergonomics",
    "it health & well-being":                           "health-ergonomics",
    "burnout prevention & recovery":                    "health-ergonomics",
    "well-being":                                       "health-ergonomics",
    "work-life balance":                                "health-ergonomics",
    "sleep science & hygiene":                          "health-ergonomics",
    "assistive technology":                             "health-ergonomics",
    "health conditions & technology":                   "health-ergonomics",
    "personal health journeys":                         "health-ergonomics",

    # personal-computing
    "personal computing & productivity":                "personal-computing",
    "productivity":                                     "personal-computing",
    "productivity strategies for tech professionals":   "personal-computing",
    "keyboards & input devices":                        "personal-computing",
    "split keyboards":                                  "personal-computing",
    "tools":                                            "personal-computing",
    "blogging & content management":                    "personal-computing",
    "content":                                          "personal-computing",

    # ai-tech-insights
    "ai":                                               "ai-tech-insights",
    "ai & machine learning":                            "ai-tech-insights",
    "large language models":                            "ai-tech-insights",
    "prompt engineering":                               "ai-tech-insights",
    "tech & industry insights":                         "ai-tech-insights",
    "technology":                                       "ai-tech-insights",
    "tech":                                             "ai-tech-insights",
    "techreview":                                       "ai-tech-insights",

    # opinion-reflections
    "opinion":                                          "opinion-reflections",
    "opinions":                                         "opinion-reflections",
    "rant":                                             "opinion-reflections",
    "my perspective":                                   "opinion-reflections",
    "personal reflections":                             "opinion-reflections",
    "personal story":                                   "opinion-reflections",
    "community & culture":                              "opinion-reflections",

    # hardware-maker
    "hardware reviews":                                 "hardware-maker",
    "product reviews":                                  "hardware-maker",
    "product research":                                 "hardware-maker",
    "3d printing":                                      "hardware-maker",
    "diy tech":                                         "hardware-maker",
    "maker culture":                                    "hardware-maker",
}

# Tags die altijd verwijderd worden — puur ruis, nooit specifiek genoeg
TAGS_ALWAYS_REMOVE = {
    "technology", "opinion", "tech", "general", "system administration",
}

# Tags die verwijderd worden ALS de post al in de bijbehorende categorie zit
TAGS_REDUNDANT_WITH_CATEGORY = {
    "security":     "security-privacy",
    "sysadmin":     "career-sysadmin",
    "devops":       "devops-infrastructure",
}

# Tag → categorie hint voor posts zonder categorieën
TAG_CATEGORY_HINT = {
    "kvm":          "devops-infrastructure",
    "qemu":         "devops-infrastructure",
    "qcow2":        "devops-infrastructure",
    "lvm":          "devops-infrastructure",
    "docker":       "devops-infrastructure",
    "ansible":      "devops-infrastructure",
    "terraform":    "devops-infrastructure",
    "kubernetes":   "devops-infrastructure",
    "nginx":        "devops-infrastructure",
    "monitoring":   "devops-infrastructure",
    "ssh":          "security-privacy",
    "vpn":          "security-privacy",
    "cve":          "security-privacy",
    "iso27001":     "security-privacy",
    "hardening":    "security-privacy",
    "firewall":     "security-privacy",
    "encryption":   "security-privacy",
    "llm":          "ai-tech-insights",
    "ai":           "ai-tech-insights",
    "burnout":      "health-ergonomics",
    "ergonomics":   "health-ergonomics",
    "sovereignty":  "digital-sovereignty",
    "eu":           "digital-sovereignty",
    "cloudflare":   "devops-infrastructure",
    "vmware":       "devops-infrastructure",
    "hugo":         "personal-computing",
    "playwright":   "devops-infrastructure",
    "fortinet":     "security-privacy",
}


# ─────────────────────────────────────────────────────────────
# YAML helpers
# ─────────────────────────────────────────────────────────────

def parse_frontmatter(content: str):
    """Splits content in (frontmatter_dict, body_str) via PyYAML."""
    if not content.startswith("---"):
        return None, content
    parts = content.split("---", 2)
    if len(parts) < 3:
        return None, content
    try:
        fm = yaml.safe_load(parts[1]) or {}
    except yaml.YAMLError as e:
        print(f"  YAML parse error: {e}", file=sys.stderr)
        return None, content
    return fm, parts[2]


def dump_frontmatter(fm: dict, body: str) -> str:
    """Schrijft front matter terug als YAML string."""
    return "---\n" + yaml.dump(fm, allow_unicode=True, sort_keys=False) + "---" + body


# ─────────────────────────────────────────────────────────────
# Taxonomy logic
# ─────────────────────────────────────────────────────────────

# Generieke categorieën die verdrongen worden door tag-hints
GENERIC_CATEGORIES = {"ai-tech-insights", "opinion-reflections", "digital-sovereignty"}


def remap_categories(old: list, tags: list = None) -> list[str]:
    """Mapt oude categorieën naar nieuwe. Onbekende categorieën blijven behouden.
    Als tags een specifiekere categorie aanwijzen, vervangt die een generieke."""
    new = []
    for cat in old:
        key = str(cat).lower().strip()
        mapped = CATEGORY_MAP.get(key, key)
        if mapped not in new:
            new.append(mapped)
    result = new[:2]

    # Tag-gebaseerde verfijning: vervang generieke categorie door specifiekere hint
    if tags and len(result) > 0:
        tag_hints = []
        for tag in tags:
            hint = TAG_CATEGORY_HINT.get(str(tag).lower().strip())
            if hint and hint not in result and hint not in tag_hints:
                tag_hints.append(hint)

        for hint in tag_hints:
            if hint in GENERIC_CATEGORIES:
                continue  # hint is ook generiek, niet zinvol
            # Vervang de meest generieke categorie in result
            for i, cat in enumerate(result):
                if cat in GENERIC_CATEGORIES:
                    result[i] = hint
                    break
            else:
                break  # geen generieke meer te vervangen

    return result[:2]


def suggest_categories_from_tags(tags: list, existing: list[str]) -> list[str]:
    """Suggereert categorieën op basis van tags voor posts zonder categorieën."""
    suggested = list(existing)
    for tag in tags:
        hint = TAG_CATEGORY_HINT.get(tag.lower().strip())
        if hint and hint not in suggested:
            suggested.append(hint)
        if len(suggested) >= 2:
            break
    return suggested[:2]


def clean_tags(tags: list, new_categories: list[str]) -> list[str]:
    """Verwijdert overbodige tags, normaliseert naar lowercase, max 5."""
    cleaned = []
    seen = set()
    for tag in tags:
        normalized = str(tag).strip().lower()

        if normalized in TAGS_ALWAYS_REMOVE:
            continue

        if normalized in TAGS_REDUNDANT_WITH_CATEGORY:
            if TAGS_REDUNDANT_WITH_CATEGORY[normalized] in new_categories:
                continue  # categorie dekt het al

        if normalized in seen:
            continue
        seen.add(normalized)
        cleaned.append(normalized)  # altijd lowercase opslaan

    return cleaned[:5]  # max 5 per post


# ─────────────────────────────────────────────────────────────
# File processing
# ─────────────────────────────────────────────────────────────

def process_file(path: Path, content_dir: Path, dry_run: bool, verbose: bool) -> bool:
    """Verwerkt één Markdown-bestand. Geeft True terug als het gewijzigd is."""
    raw = path.read_text(encoding="utf-8")
    fm, body = parse_frontmatter(raw)

    if fm is None:
        if verbose:
            print(f"  SKIP  {path.relative_to(content_dir)} (geen front matter)")
        return False

    old_cats = list(fm.get("categories") or [])
    old_tags = list(fm.get("tags") or [])

    new_cats = remap_categories(old_cats, old_tags)

    # Suggereer categorieën voor posts die na remapping leeg zijn
    if not new_cats and old_tags:
        new_cats = suggest_categories_from_tags(old_tags, [])
        if new_cats:
            print(f"  HINT  {path.relative_to(content_dir)}: geen categorie gevonden, gesuggereerd op basis van tags: {new_cats}")

    new_tags = clean_tags(old_tags, new_cats)

    cats_changed = new_cats != [CATEGORY_MAP.get(str(c).lower().strip(), str(c).lower().strip()) for c in old_cats][:2]
    tags_changed = new_tags != [str(t).strip().lower() for t in old_tags][:5]

    # Vergelijk genormaliseerd
    old_cats_norm = [str(c).lower().strip() for c in old_cats]
    old_tags_norm = [str(t).strip().lower() for t in old_tags]

    changed = (new_cats != old_cats_norm) or (new_tags != old_tags_norm)

    if not changed:
        if verbose:
            print(f"  OK    {path.relative_to(content_dir)}")
        return False

    print(f"  CHANGE {path.relative_to(content_dir)}")
    if new_cats != old_cats_norm:
        print(f"    categories: {old_cats_norm} → {new_cats}")
    if new_tags != old_tags_norm:
        removed = [t for t in old_tags_norm if t not in new_tags]
        if removed:
            print(f"    tags removed: {removed}")
        print(f"    tags kept ({len(new_tags)}): {new_tags}")

    if not dry_run:
        fm["categories"] = new_cats
        fm["tags"] = new_tags
        path.write_text(dump_frontmatter(fm, body), encoding="utf-8")

    return True


# ─────────────────────────────────────────────────────────────
# Main
# ─────────────────────────────────────────────────────────────

def main():
    parser = argparse.ArgumentParser(description="Hugo taxonomy cleaner voor roethof.net")
    parser.add_argument("--dir", default="./content", help="Hugo content directory")
    parser.add_argument("--dry-run", action="store_true", help="Geen bestanden schrijven")
    parser.add_argument("--verbose", action="store_true", help="Toon ook ongewijzigde bestanden")
    args = parser.parse_args()

    content_dir = Path(args.dir).resolve()
    if not content_dir.exists():
        print(f"ERROR: Directory '{content_dir}' bestaat niet.", file=sys.stderr)
        sys.exit(1)

    md_files = list(content_dir.rglob("*.md"))
    if not md_files:
        print(f"Geen .md bestanden gevonden in {content_dir}")
        sys.exit(0)

    print(f"{'DRY RUN — ' if args.dry_run else ''}Verwerken: {len(md_files)} bestanden in {content_dir}\n")

    changed = 0
    for f in md_files:
        if process_file(f, content_dir, dry_run=args.dry_run, verbose=args.verbose):
            changed += 1

    print(f"\n{'Zou wijzigen' if args.dry_run else 'Gewijzigd'}: {changed}/{len(md_files)} bestanden")
    if args.dry_run:
        print("Voer opnieuw uit zonder --dry-run om te schrijven.")


if __name__ == "__main__":
    main()