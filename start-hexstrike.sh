#!/bin/bash
# Start HexStrike AI Server
# This script starts the HexStrike AI server in the background

HEXSTRIKE_DIR="/opt/hexstrike"
LOG_DIR="/var/log/hexstrike"
PID_FILE="/var/run/hexstrike.pid"

# Create log directory if it doesn't exist
mkdir -p "$LOG_DIR"

# Check if already running
if [ -f "$PID_FILE" ]; then
    PID=$(cat "$PID_FILE")
    if ps -p "$PID" > /dev/null 2>&1; then
        echo "HexStrike AI server is already running (PID: $PID)"
        exit 0
    fi
fi

# Start HexStrike AI server
echo "Starting HexStrike AI server..."
cd "$HEXSTRIKE_DIR"
nohup python3 hexstrike_server.py > "$LOG_DIR/hexstrike.log" 2>&1 &
echo $! > "$PID_FILE"

# Wait a moment and check if it's running
sleep 2
if ps -p $(cat "$PID_FILE") > /dev/null 2>&1; then
    echo "✅ HexStrike AI server started successfully"
    echo "📡 Server running on port ${HEXSTRIKE_PORT:-8888}"
    echo "📝 Logs: $LOG_DIR/hexstrike.log"
    echo "🔍 PID: $(cat $PID_FILE)"
else
    echo "❌ Failed to start HexStrike AI server"
    echo "Check logs: $LOG_DIR/hexstrike.log"
    exit 1
fi
