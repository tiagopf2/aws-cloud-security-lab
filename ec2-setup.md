EC2 Setup & Security Configuration
Overview

Two EC2 instances were deployed in AWS to simulate a real-world environment with both Linux and Windows servers. Security groups were configured following the Principle of Least Privilege (PLP) — only required ports were opened.

Instances Deployed
Instance Name	OS	Instance Type	Availability Zone
CYB310-Linux-Tiago	Amazon Linux 2023	t2.micro	us-east-1a
CYB310-Windows-Tiago	Windows Server	t2.micro	us-east-1a

Access Verification
Linux — Echo Command

Authenticated via SSH using a public key (CYB310-Tiago) and verified access with the echo command.

[ec2-user@ip-172-31-80-161 ~]$ echo "Tiago Perez"
Tiago Perez


Windows — Echo Command

Accessed via Remote Desktop Connection (RDP) and verified with Command Prompt.

C:\Users\Administrator> echo Tiago Perez
Tiago Perez


Ping Test

Verified outbound connectivity from the Windows instance:

C:\Users\Administrator> ping 1.1.1.1

Pinging 1.1.1.1 with 32 bytes of data:
Reply from 1.1.1.1: bytes=32 time=1ms TTL=57
Reply from 1.1.1.1: bytes=32 time=1ms TTL=57
Reply from 1.1.1.1: bytes=32 time=1ms TTL=57

Packets: Sent = 3, Received = 3, Lost = 0 (0% loss)
Minimum = 1ms, Maximum = 1ms, Average = 1ms

Security Group Configuration

Security groups were configured to allow only the minimum required ports.

Windows Instance — Inbound Rules
Rule	Protocol	Port	Purpose
sgr-08c8e275336ae54d9	TCP	3389	RDP Access
sgr-0f2d409b7cbf8fef1	ICMP	All	Ping / Echo

Security Note: All other inbound traffic is denied by default. No ports like SSH (22) or HTTP (80) were opened unless explicitly required.

Windows Firewall

In addition to AWS Security Groups, the Windows Defender Firewall was configured to allow ICMP echo requests (ping) inbound.

Running Processes & User Monitoring
Linux — top Command

Used to monitor active processes, CPU usage, memory, and running users in real time.

[ec2-user@ip-172-31-80-161 ~]$ top


Windows — Resource Monitor

Used to monitor CPU, memory, disk, and network usage per process.

What a Security Administrator Looks For

When reviewing processes and users, a security admin watches for:

🔴 Unauthorized processes running under unexpected users
🔴 Privilege escalation — processes running as root/Administrator unexpectedly
🔴 High resource usage — could indicate cryptomining or a DoS attack
🔴 Unknown user accounts — signs of compromised credentials
🔴 Unusual login times — logins outside business hours
🔴 Shared or default accounts — violates accountability principles
EC2 CLI Access

EC2 instances were also managed via the AWS CLI from a local Windows machine.

aws --version
# aws-cli/2.19.1 Python/3.12.6 Windows/11 exe/AMD64

# Start an instance
aws ec2 start-instances --instance-ids i-084fe10dfb6264a78

# Stop an instance
aws ec2 stop-instances --instance-ids i-084fe10dfb6264a78


Network Traffic Monitoring — tcpdump

Used tcpdump on the Linux instance to capture and analyze live network traffic.

Basic Capture
sudo tcpdump -i enX0

Capture with Packet Limit
sudo tcpdump -i enX0 -c 10
# Captured 10 packets — observed SSH and HTTP traffic

Verbose Output
sudo tcpdump -i enX0 -vv
# Full protocol decode — shows TTL, flags, sequence numbers


Key Observation: Traffic included SSH sessions and HTTP PUT requests to the EC2 instance metadata service — both expected and normal for this environment.

Key Takeaways
✅ Both instances deployed and verified accessible
✅ Security groups follow least privilege (only required ports open)
✅ Firewall rules configured on both OS levels
✅ Process and user monitoring in place
✅ CLI access configured and tested
✅ Network traffic captured and analyzed

➡️ Next: Server Hardening
