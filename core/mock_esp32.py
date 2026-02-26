from http.server import BaseHTTPRequestHandler, HTTPServer
import time

class MockESP32(BaseHTTPRequestHandler):
    def _send_success(self, message):
        self.send_response(200)
        self.send_header('Content-type', 'text/plain')
        self.end_headers()
        self.wfile.write(message.encode())

    def do_GET(self):
        # Allow GET for simple status checks
        print(f"\n[ 🛰️ MOCK ESP32 ] Status Check Received.")
        self._send_success("Ghost ESP32 is ONLINE. Use POST /ACTUATE_PUMP to trigger.")

    def do_POST(self):
        if self.path == "/ACTUATE_PUMP":
            print("\n[ 🛰️ MOCK ESP32 ] Received Actuation Signal!")
            print("[ 🌊 PUMP ] Status: RUNNING (Simulation pulse)")
            time.sleep(1)
            print("[ 🌊 PUMP ] Status: IDLE")
            self._send_success("Mock Pulse Success")
        else:
            self.send_error(404, "Unknown Actuation Path")

def run():
    print("🌫️ FogSift Mock Hardware Server: http://localhost:8080")
    server = HTTPServer(('localhost', 8080), MockESP32)
    server.serve_forever()

if __name__ == "__main__":
    run()
