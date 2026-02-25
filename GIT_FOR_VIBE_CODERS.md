# 🎸 Git for Vibe Coders (The No-BS Guide)

If you are using AI to code, you do not need to click around GitHub's confusing web menus. You can do almost everything right inside your terminal (in Cursor, VS Code, or on your Mac). 

Think of Git as a **time machine and a cloud backup** for your folders. You only need to know **four commands** to survive.

---

## 1. The Download (`git clone`)
**What it does:** Downloads a cloud folder onto your computer.
**The Analogy:** Downloading a Google Doc so you can edit it offline.
**The Command:**
`git clone https://github.com/Username/repository-name.git`

## 2. The Shopping Cart (`git add`)
**What it does:** Tells the computer, "Hey, notice the files I just changed." 
**The Analogy:** Putting items into your shopping cart at the grocery store. You haven't bought them yet; you are just staging them.
**The Command:**
`git add .`
*(Note: The `.` is very important. It means "add EVERYTHING in this folder")*

## 3. The Save Point (`git commit`)
**What it does:** Locks in your changes and attaches a note.
**The Analogy:** Checking out at the register and getting a receipt. This creates a permanent save point you can always return to if your code breaks later.
**The Command:**
`git commit -m "Added my sourdough tracker to the list"`

## 4. The Upload (`git push`)
**What it does:** Sends your locked-in saves back up to the cloud.
**The Analogy:** Hitting "Sync" so the rest of the world can see your work.
**The Command:**
`git push`

---

### 🛠️ The Standard Workflow
When you are building something with Claude or Cursor, here is what your workflow looks like when you want to permanently save your progress:

1. Make sure your code actually works.
2. Open your terminal.
3. Type `git add .` and hit Enter.
4. Type `git commit -m "It works!"` and hit Enter.
5. Type `git push` and hit Enter.

Boom. You are a hacker.
