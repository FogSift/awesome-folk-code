.PHONY: check trial submit help

help:
	@echo "🔮 FogSift Vibe Commands 🔮"
	@echo "---------------------------"
	@echo "make check   - Run the vibe-check to ensure your terminal is ready"
	@echo "make trial   - Learn how to pass the Git Trial"
	@echo "make submit  - Steps to submit your project"
	@echo "---------------------------"

check:
	@./vibe-check.sh

trial:
	@echo "⚔️  Ready for The Trial?"
	@echo "1. Create your branch: git checkout -b trial-yourname"
	@echo "2. Edit THE_TRIAL.md and add your name to the bottom."
	@echo "3. Stage, commit, and push!"
	@echo "   git add THE_TRIAL.md"
	@echo "   git commit -m 'I have passed the trial'"
	@echo "   git push -u origin HEAD"
	@echo "4. Open a Pull Request on GitHub. You got this."

submit:
	@echo "🚀 Ready to submit your Awesome Folk Code?"
	@echo "1. Make sure you passed The Trial first."
	@echo "2. Branch out: git checkout -b add-my-tool"
	@echo "3. Add your link to the correct category in README.md"
	@echo "4. Stage, commit, and push!"
	@echo "   git add README.md"
	@echo "   git commit -m 'Add [Your Project Name]'"
	@echo "   git push -u origin HEAD"
	@echo "5. Use the GitHub CLI to open a PR: gh pr create"

stats:
	@python3 update-stats.py

game:
	@echo "🚀 Launching local preview of the game..."
	@open games/minotaur-labyrinth/index.html
