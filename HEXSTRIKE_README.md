# HexStrike AI Integration

This Kali Linux Docker image now includes the HexStrike AI server, providing AI-powered penetration testing capabilities.

## What is HexStrike AI?

HexStrike AI is an advanced AI-powered penetration testing framework that provides:

- **150+ Security Tools Integration**: Automated access to network scanning, web testing, password cracking, and more
- **12+ AI Agents**: Specialized autonomous agents for bug bounty hunting, CTF solving, vulnerability intelligence
- **Intelligent Decision Engine**: AI-powered tool selection and parameter optimization
- **Real-time Process Management**: Live command control and monitoring
- **Browser Automation**: Headless Chrome integration for web application testing

## Quick Start

### Starting HexStrike AI Server

```bash
# Run the container
docker run --rm -it -p 8888:8888 gwokfun/kali-linux bash

# Inside the container, start HexStrike AI
start-hexstrike

# Or start manually
cd /opt/hexstrike
python3 hexstrike_server.py
```

### Verifying Server Status

```bash
# Check server health
curl http://localhost:8888/health

# View logs
tail -f /var/log/hexstrike/hexstrike.log
```

## Using HexStrike AI

### With MCP-Compatible AI Clients

HexStrike AI works with various AI clients:

- **Claude Desktop**
- **VS Code Copilot**
- **Cursor**
- **Roo Code**
- **Any MCP-compatible agent**

### Configuration Example (Claude Desktop)

Edit `~/.config/Claude/claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "hexstrike-ai": {
      "command": "docker",
      "args": [
        "exec",
        "kali-container",
        "python3",
        "/opt/hexstrike/hexstrike_mcp.py",
        "--server",
        "http://localhost:8888"
      ],
      "description": "HexStrike AI - Advanced Cybersecurity Automation",
      "timeout": 300
    }
  }
}
```

### API Endpoints

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/health` | GET | Server health check |
| `/api/command` | POST | Execute security tools |
| `/api/intelligence/analyze-target` | POST | AI-powered target analysis |
| `/api/intelligence/select-tools` | POST | Intelligent tool selection |
| `/api/processes/list` | GET | List active processes |

### Example Usage

```bash
# Network scanning
curl -X POST http://localhost:8888/api/command \
  -H "Content-Type: application/json" \
  -d '{"command": "nmap", "args": ["-sV", "target.com"]}'

# AI-powered target analysis
curl -X POST http://localhost:8888/api/intelligence/analyze-target \
  -H "Content-Type: application/json" \
  -d '{"target": "example.com", "analysis_type": "comprehensive"}'
```

## Security Considerations

⚠️ **Important Notes**:

- HexStrike AI provides powerful system access to AI agents
- Only use on systems you own or have explicit authorization to test
- Run in isolated environments or dedicated security testing VMs
- Monitor AI agent activities through the real-time dashboard
- Default port 8888 is exposed - ensure proper network security

## Included Tools

HexStrike AI provides intelligent access to:

- **Network Tools**: nmap, masscan, rustscan, amass, subfinder
- **Web Tools**: gobuster, feroxbuster, nuclei, sqlmap, nikto
- **Password Tools**: hydra, john, hashcat, medusa
- **Binary Tools**: ghidra, radare2, gdb, pwntools
- **Cloud Tools**: prowler, trivy, kube-hunter
- **And 130+ more security tools**

## Troubleshooting

### Server Won't Start

```bash
# Check if port is already in use
netstat -tlnp | grep 8888

# Check logs
cat /var/log/hexstrike/hexstrike.log

# Restart server
pkill -f hexstrike_server
start-hexstrike
```

### Permission Issues

```bash
# Ensure log directory has proper permissions
chmod 777 /var/log/hexstrike
```

## Credits

- **HexStrike AI**: [github.com/0x4m4/hexstrike-ai](https://github.com/0x4m4/hexstrike-ai)
- **Kali Linux Image**: [github.com/gwokfun/kali-linux-image](https://github.com/gwokfun/kali-linux-image)

## License

This integration maintains the MIT License for the Docker configuration. HexStrike AI and included security tools are subject to their respective licenses.
