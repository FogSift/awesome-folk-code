import os

def sync():
    journal_path = "evidence/research_journal.md"
    readme_path = "README.md"
    
    if not os.path.exists(journal_path): return

    with open(journal_path, "r") as f:
        # Get the last 3 entries (approx 18 lines)
        recent_intel = f.readlines()[-20:]
        intel_block = "".join(recent_intel).strip()

    with open(readme_path, "r") as f:
        content = f.read()

    # Find the markers in your README
    start_marker = "📡 Latest Intelligence"
    end_marker = "📡 Node Intelligence"
    
    if start_marker in content and end_marker in content:
        prefix = content.split(start_marker)[0] + start_marker + "\n\n"
        suffix = "\n\n" + end_marker + content.split(end_marker)[1]
        new_content = prefix + intel_block + suffix
        
        with open(readme_path, "w") as f:
            f.write(new_content)
        print("✅ README synchronized with latest intelligence.")

if __name__ == "__main__":
    sync()
