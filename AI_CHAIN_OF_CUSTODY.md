# 🛡️ The AI Coder's Grimoire & Garage Manual: Safe Git Practices

When you transition from human coding to AI coding, the AI becomes the builder, and you become the **Editor-in-Chief**. AI tools like Cursor can write 500 lines of code in a minute, which is magical, but also chaotic. 

We use standard Git practices to build a **Chain of Custody**. For the millennial dad, Git is your padded workbench in the garage so the AI doesn't accidentally tear down a load-bearing wall. For the witchy wife, Git is your grimoire—an immutable, time-stamped ledger of every spell cast, complete with an undo button if a potion explodes.

Here are the standard tools developers use to keep their code stable and secure, and the terminal commands to use them.

---

## 1. The Padded Room: Branches
**The Standard:** Never let AI write code directly into your live, working project (the `main` branch). Always create a "Feature Branch." This is an invisible parallel universe where the AI can hallucinate and break things without ruining your actual project.

**The Command:**
`git checkout -b garage-experiment-1`

## 2. The Unbreakable Seal: Commits and Hashes
**The Standard:** When the AI writes something that actually works, you save it. Git takes a snapshot of the code and stamps it with a unique, unbreakable cryptographic hash (like `a1b2c3d`). This is your Chain of Custody. If the code breaks tomorrow, you know exactly who broke it and when.

**The Commands:**
`git add .`
`git commit -m "AI successfully built the dark mode UI"`

## 3. The Sync: Pushing the Branch
**The Standard:** Once your experiment is safely saved on your computer, you back up that parallel universe to the cloud (GitHub) so it's safe if your laptop dies.

**The Command:**
`git push -u origin garage-experiment-1`

## 4. The Human Checkpoint: Pull Requests (PRs)
**The Standard:** A Pull Request is how you merge your experimental branch back into the sacred `main` timeline. This is the ultimate security gate. It forces a human to review the "diff" (the exact lines the AI added or deleted) before it goes live.

**The Command (Using GitHub CLI `gh` to avoid the web UI):**
`gh pr create --title "Merge Dark Mode" --body "Reviewed the AI code. No hallucinations found."`

## 5. The Undo Spell: Reverting
**The Standard:** Sometimes bad AI code slips through. Because Git tracks every single hash, you can simply tell Git to reverse time and remove that specific snapshot.

**The Command:**
`git log --oneline`
`git revert <type-the-hash-here>`
