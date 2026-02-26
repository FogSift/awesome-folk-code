import re
import plotext as plt

def render_chart():
    try:
        with open('evidence/actuation_history.md', 'r') as f:
            content = f.read()
            
        # Extract moisture percentages
        points = [int(p) for p in re.findall(r'(\d+)%', content)]
        
        if len(points) < 2:
            print("📈 Moisture Trend: [ NOT ENOUGH DATA ]")
            return
            
        # Take the last 20 points
        y = points[-20:]
        
        # Build the chart
        plt.clear_figure()
        plt.plot(y, marker="dot", color="cyan")
        plt.title("Chico Chickpea: 20-Tick Moisture Trend")
        plt.xlabel("Time (Ticks)")
        plt.ylabel("Moisture (%)")
        plt.ylim(0, 100)
        plt.plotsize(60, 15)
        plt.theme('clear')
        
        plt.show()

    except Exception as e:
        print(f"📈 Visualizer Error: {e}")

if __name__ == "__main__":
    render_chart()
