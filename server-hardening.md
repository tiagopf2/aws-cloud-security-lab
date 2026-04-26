# Server Hardening

## Overview
After deploying the EC2 instances, both the Linux and Windows servers were hardened following security best practices. The goal is to reduce the attack surface and ensure only authorized activity can occur on each machine.

---

## Linux Server Hardening

### 1. Disable Root Login
Direct root login via SSH is disabled. All administrative tasks are performed using `sudo`.

```bash
# In /etc/ssh/sshd_config
PermitRootLogin no

# Restart SSH to apply
sudo systemctl restart sshd
```

> **Why it matters:** If an attacker gains SSH access, disabling root login limits the damage they can do immediately.

---

### 2. Enable Firewall (UFW)

```bash
# Enable the firewall
sudo ufw enable

# Allow only required traffic
sudo ufw allow ssh
sudo ufw allow 443/tcp

# Check rules
sudo ufw status verbose
```

---

### 3. System Updates & Patching

```bash
# Amazon Linux / RHEL-based
sudo yum update -y

# Debian/Ubuntu-based
sudo apt-get update && sudo apt-get upgrade -y
```

> **Why it matters:** Unpatched systems are one of the most common attack vectors. Regular updates close known vulnerabilities.

---

### 4. Audit Logging with `auditd`

```bash
# List current audit rules
sudo auditctl -l

# Monitor a sensitive file
sudo auditctl -w /etc/passwd -p wa -k passwd_changes
```

> **Why it matters:** `auditd` tracks file access, user activity, and system calls — essential for detecting unauthorized changes.

---

### 5. Monitor Running Processes

```bash
# Real-time process monitoring
top

# Check logged-in users
who
w

# Check recent logins
last
```

![Linux Top Command](screenshots/linux-top.png)

---

### Key Linux Hardening Commands Summary

| Command | Purpose |
|---|---|
| `sudo ufw enable` | Enable firewall |
| `sudo ufw allow [port]` | Allow specific traffic |
| `sudo yum update -y` | Patch the system |
| `sudo auditctl -l` | List audit rules |
| `top` | Monitor processes |
| `who` / `last` | Check active/recent users |

---

## Windows Server Hardening

### 1. Active Directory & MFA
- Users managed through **Active Directory**
- **Multi-Factor Authentication (MFA)** enforced for all accounts
- Strong password policies applied via Group Policy

---

### 2. Windows Defender Firewall
Configured inbound rules to allow only required traffic. All other inbound connections are blocked by default.

```powershell
# View firewall rules via PowerShell
Get-NetFirewallRule | Where-Object { $_.Enabled -eq "True" }
```

![Windows Firewall Rules](screenshots/windows-firewall.png)

> The ICMP echo request rule was specifically enabled to allow ping testing while keeping all other unnecessary ports closed.

---

### 3. Windows Update / WSUS
Regular updates applied through **Windows Update** or **WSUS (Windows Server Update Services)** to patch vulnerabilities.

---

### 4. Event Viewer — Log Monitoring
Used **Event Viewer** to review security logs for:
- Failed login attempts
- Account lockouts
- Privilege use
- Service changes

```powershell
# Open Event Viewer via PowerShell
eventvwr
```

---

### 5. PowerShell Automation
PowerShell used to automate security tasks such as:
- Reviewing user accounts
- Checking firewall status
- Auditing running services

```powershell
# List all local users
Get-LocalUser

# Check running services
Get-Service | Where-Object { $_.Status -eq "Running" }

# Check firewall status
Get-NetFirewallProfile | Select Name, Enabled
```

![Windows Resource Monitor](screenshots/windows-resource-monitor.png)

---

### Key Windows Hardening Summary

| Tool / Command | Purpose |
|---|---|
| Active Directory | User management + password policies |
| MFA | Prevent unauthorized access |
| Windows Defender Firewall | Block unwanted inbound traffic |
| Event Viewer (`eventvwr`) | Review security logs |
| Windows Update / WSUS | Patch vulnerabilities |
| PowerShell | Automate security checks |

---

## Hardening Comparison: Linux vs Windows

| Area | Linux | Windows |
|---|---|---|
| Firewall | `ufw` | Windows Defender Firewall |
| User Management | `sudo`, disable root | Active Directory, MFA |
| Patching | `yum` / `apt` | Windows Update / WSUS |
| Audit Logging | `auditd` | Event Viewer |
| Automation | Bash scripts | PowerShell |
| Process Monitoring | `top`, `ps` | Resource Monitor, Task Manager |

---

## Key Takeaways

- ✅ Root login disabled on Linux — `sudo` enforced
- ✅ Firewall enabled and configured on both OS
- ✅ Systems kept up to date with patches
- ✅ Audit logging active on Linux (`auditd`)
- ✅ Windows logs reviewed via Event Viewer
- ✅ PowerShell used for automation and auditing

---

➡️ Back to: [EC2 Setup](ec2-setup.md)  
➡️ Next: [IAM Security](../iam-security/iam-setup.md)
