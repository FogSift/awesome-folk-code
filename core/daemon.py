import time
import subprocess
import sys
from datetime import datetime

def run_loop():
    print("🌫️ FogSift Daemon Initialized. Running in background...")
    while True:
        try:
            # 1. Execute the tactical gate silently
            subprocess.run(["./core/run_actuation.sh"], capture_output=True)
            
            # 2. Write a heartbeat file so the dashboard knows we are alive
            with open("evidence/daemon_heartbeat.txt", "w") as f:
                f.write(datetime.now().strftime("%Y-%m-%d %H:%M:%S"))
                
            # 3. Sleep for 60 seconds before checking again
            time.sleep(60)
            
        except KeyboardInterrupt:
            print("Shutting down daemon...")
            sys.exit(0)
        except Exception as e:
            with open("evidence/daemon_error.log", "a") as f:
                f.write(f"Error at {datetime.now()}: {e}\n")
            time.sleep(60)

if __name__ == "__main__":
    run_loop()
