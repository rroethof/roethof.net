#!/usr/bin/env python3
"""
add_series.py — Voegt series toe aan Hugo front matter voor roethof.net

Gebruik:
    python3 add_series.py --dir ./content --dry-run
    python3 add_series.py --dir ./content

Vereisten:
    pip install pyyaml
"""

import argparse
import sys
from pathlib import Path

import yaml


# ─────────────────────────────────────────────────────────────
# SERIES MAPPING: slug-fragment → serie naam
# Elk fragment wordt vergeleken met het pad van de post.
# ─────────────────────────────────────────────────────────────
SERIES_MAP = {
    # arch-linux-setup — feb 2025, chronologisch opbouwend
    "from-freebsd-and-debian-to-arch":                                  "arch-linux-setup",
    "taming-the-beast-my-arch-linux-install":                           "arch-linux-setup",
    "my-minimal-desktop-hyprland-installation-on-a-fresh-archlinux":    "arch-linux-setup",
    "taming-virtual-machines-on-arch-linux":                            "arch-linux-setup",

    # ansible-mastery — apr-jul 2025
    "ansible-role-linux-hardening":                                     "ansible-mastery",
    "top-ansible-modules-sysadmin":                                     "ansible-mastery",
    "building-proper-cicd-pipeline-ansible-roles":                      "ansible-mastery",
    "ansible-dokuwiki-poor-mans-cmdb":                                  "ansible-mastery",
    "ansible-automation-ecosystem-comparison":                          "ansible-mastery",

    # ergonomic-keyboard-journey — mrt-jul 2025
    "my-quest-for-ergonomic-bliss":                                     "ergonomic-keyboard-journey",
    "ergonomic-keyboard-research":                                      "ergonomic-keyboard-journey",
    "zsa-voyager-initial-review":                                       "ergonomic-keyboard-journey",

    # burnout-sysadmin — mrt-apr 2025
    "the-sleep-deprived-sysadmin":                                      "burnout-sysadmin",
    "burnout-cybersecurity-crisis":                                     "burnout-sysadmin",

    # digital-sovereignty-nl — 2025
    "dutch-gov-sovereign-cloud-paper-tiger":                            "digital-sovereignty-nl",
    "voc-mentaliteit-digital-sovereignty":                              "digital-sovereignty-nl",
    "ms-exit-strategy":                                                 "digital-sovereignty-nl",
    "kyndryl-solvinity-sovereignty-kill-switch":                        "digital-sovereignty-nl",
    "digital-vassals-europe-suicide-note":                              "digital-sovereignty-nl",
    "digital-autonomy-dependency-debate":                               "digital-sovereignty-nl",
    "switzerlands-first-domino-digital-sovereignty":                    "digital-sovereignty-nl",
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
# Series logic
# ─────────────────────────────────────────────────────────────

def detect_series(path: Path) -> str | None:
    """Detecteert de serie op basis van het pad van de post."""
    path_str = str(path).lower()
    for fragment, series in SERIES_MAP.items():
        if fragment.lower() in path_str:
            return series
    return None


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

    series = detect_series(path)
    if not series:
        if verbose:
            print(f"  OK    {path.relative_to(content_dir)} (geen serie)")
        return False

    existing = list(fm.get("series") or [])
    if series in existing:
        if verbose:
            print(f"  OK    {path.relative_to(content_dir)} (serie al aanwezig: {series})")
        return False

    print(f"  ADD   {path.relative_to(content_dir)}")
    print(f"    series: {series}")

    if not dry_run:
        fm["series"] = existing + [series]
        path.write_text(dump_frontmatter(fm, body), encoding="utf-8")

    return True


# ─────────────────────────────────────────────────────────────
# Main
# ─────────────────────────────────────────────────────────────

def main():
    parser = argparse.ArgumentParser(description="Hugo series toevoeger voor roethof.net")
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

    print(f"\n{'Zou toevoegen' if args.dry_run else 'Toegevoegd'}: {changed}/{len(md_files)} bestanden")

    if changed > 0:
        print("\nVergeet niet je hugo.toml bij te werken:")
        print("  [taxonomies]")
        print("    category = \"categories\"")
        print("    tag = \"tags\"")
        print("    series = \"series\"")

    if args.dry_run and changed > 0:
        print("\nVoer opnieuw uit zonder --dry-run om te schrijven.")


if __name__ == "__main__":
    main()