import os
from datetime import datetime

BRIEF_FILE = "evidence/tech_context.txt"
JOURNAL_FILE = "evidence/research_journal.md"

def journal_intel():
    if not os.path.exists(BRIEF_FILE):
        print("ℹ️ No tech_context.txt found to archive.")
        return

    with open(BRIEF_FILE, 'r') as f:
        new_brief = f.read().strip()

    # If journal exists, check for exact duplicate to prevent bloat
    if os.path.exists(JOURNAL_FILE) and os.path.getsize(JOURNAL_FILE) > 0:
        with open(JOURNAL_FILE, 'r') as f:
            if new_brief in f.read():
                print("📋 Discovery already in archive.")
                return

    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M")
    with open(JOURNAL_FILE, 'a') as f:
        f.write(f"\n### 📡 Entry: {timestamp}\n")
        f.write(new_brief + "\n")
        f.write("---\n")
    
    print(f"🏺 Intel archived in {JOURNAL_FILE}")

if __name__ == "__main__":
    journal_intel()
