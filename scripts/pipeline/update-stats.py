import re

with open("THE_TRIAL.md", "r") as f:
    trial_content = f.read()

# Count rows in the table (excluding header and separator)
initiates = len(re.findall(r"^\| @", trial_content, re.MULTILINE))

with open("README.md", "r") as f:
    readme_content = f.read()

# Replace or insert the badge
stat_badge = f"![Initiates](https://img.shields.io/badge/Initiates-{initiates}-e07b3c?style=flat-square&logo=git)"
if "![Initiates]" in readme_content:
    new_content = re.sub(r"!\[Initiates\].*?\)", stat_badge, readme_content)
else:
    # Insert it right before the first line
    new_content = stat_badge + "\n\n" + readme_content

with open("README.md", "w") as f:
    f.write(new_content)

print(f"✅ README updated with {initiates} Initiates.")
