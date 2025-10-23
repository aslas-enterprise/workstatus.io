# Workstatus.io Linux Client Guide

This guide provides simple, step-by-step instructions to install or uninstall the Workstatus.io desktop client on Debian-based Linux systems (like Ubuntu).

---

## Installation

Follow these steps to install the Workstatus.io client.

### Step 1: Open the Terminal and Gain Root Access

First, you need administrative privileges to install new software. Open your terminal and run the following command. You will be prompted to enter your password.
```bash
sudo su
```

### Step 2: Run the Installation Command

Next, copy the entire command below, paste it into your terminal, and press `Enter`. This command will automatically download and run the official installer script for Workstatus.io.

```bash
(apt-get update -qq && apt-get install -y wget >/dev/null 2>&1) && bash <(wget -qO- https://raw.githubusercontent.com/aslas-enterprise/workstatus.io/master/workstatus-install.sh)
```
The installation is now complete!

---

## Uninstallation (Optional)

If you need to remove the Workstatus.io client from your system, follow these steps.

### Step 1: Open the Terminal and Gain Root Access

Just like with the installation, you need administrative privileges. If your terminal session is still open and you are the root user, you can skip this step. Otherwise, run the command again:

```bash
sudo su
```

### Step 2: Run the Uninstallation Command

Copy and paste the following command into your terminal. This will download and run the official uninstallation script, which will remove the application and its components.

```bash
(apt-get update -qq && apt-get install -y wget >/dev/null 2>&1) && bash <(wget -qO- https://raw.githubusercontent.com/aslas-enterprise/workstatus.io/master/workstatus-uninstall.sh)
```

The Workstatus.io client has now been removed from your system.
