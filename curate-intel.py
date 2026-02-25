import json
import os
from datetime import datetime

BRIEF_FILE = "evidence/tech_context.txt"
JOURNAL_FILE = "evidence/research_journal.md"

def journal_intel():
    if not os.path.exists(BRIEF_FILE): return
    
    with open(BRIEF_FILE, 'r') as f:
        brief_data = f.read()

    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M")
    
    with open(JOURNAL_FILE, 'a') as f:
        f.write(f"\n### 📡 Entry: {timestamp}\n")
        f.write(brief_data + "\n")
        f.write("---\n")
    
    print(f"🏺 Intel archived in {JOURNAL_FILE}")

if __name__ == "__main__":
    journal_intel()
