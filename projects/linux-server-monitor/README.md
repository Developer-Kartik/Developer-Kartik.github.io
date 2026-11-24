
# Linux Server Monitoring Tool

A Bash-based Linux system monitoring utility that collects
CPU, memory, disk and process information, checks resource
usage thresholds and stores monitoring reports in log files.

## Features

- CPU utilization monitoring
- RAM and swap usage monitoring
- Disk utilization monitoring
- Disk usage alerts (80% threshold)
- CPU usage alerts (80% threshold)
- Memory usage alerts (80% threshold)
- Top 5 CPU-consuming processes
- System hostname and uptime information
- Timestamped monitoring reports
- Automated execution using Cron
- Basic command availability checks

## Technology Stack

- Rocky Linux 9
- Bash Shell Scripting
- Linux system utilities
- Cron
- Git and GitHub

## Project Structure

```text
linux-server-monitor/
├── monitor.sh
├── README.md
└── logs/
    └── server-monitor.log
```

## Prerequisites

- Linux operating system
- Bash
- Core Linux utilities
- bc (for CPU threshold comparison)
- Cron service

## Installation

Clone the repository:

```bash
git clone <YOUR-REPOSITORY-URL>
cd linux-server-monitor
```

Make the script executable:

```bash
chmod +x monitor.sh
```

Run the monitoring script:

```bash
./monitor.sh
```

## Automated Monitoring

Configure Cron:

```bash
crontab -e
```

Add:

```bash
*/5 * * * * cd /path/to/linux-server-monitor && ./monitor.sh >/dev/null 2>&1
```

This schedules monitoring every five minutes.

## Log Files

Reports are saved in:

```text
logs/server-monitor.log
```

View the latest reports:

```bash
tail -30 logs/server-monitor.log
```

## Alert Thresholds

| Resource | Threshold |
| CPU | 80% |
| Memory | 80% |
| Disk | 80% |

## Author

Kartik Verma

GitHub: https://github.com/Developer-Kartik
