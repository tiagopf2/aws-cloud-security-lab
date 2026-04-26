# VPC Design & Peering

## Overview
This section demonstrates secure network architecture using multiple VPCs, subnet isolation, and **VPC Peering**. The goal is to allow two isolated networks to communicate privately while following the Principle of Least Privilege.

---

## 1. Network Architecture
Two VPCs were created with non-overlapping CIDR blocks to simulate separate environments (e.g., Production and Development).

| Component | VPC Name | CIDR Block | Instance |
|---|---|---|---|
| **Requester VPC** | `primaryVPC-Tiago` | `172.31.0.0/16` | Linux 1 |
| **Accepter VPC** | `secondaryVPC-tiago` | `10.0.0.0/16` | Linux 2 |

![VPC Overview](screenshots/vpc-list.png)

---

## 2. Isolation Strategy
- **Linux 2 (Secondary VPC):** Placed in a different Availability Zone (AZ) and configured with **no public access**.
- **Privileged Communication:** Instances in different VPCs cannot communicate by default until a peering connection is established and routing tables are updated.

---

## 3. VPC Peering Configuration
A peering connection (`linux1andlinux2`) was established between the two VPCs.

### Steps Taken:
1. **Request:** The connection was initiated from `primaryVPC-Tiago`.
2. **Acceptance:** The connection was accepted by `secondaryVPC-tiago`.
3. **Routing:** Route tables for both VPCs were updated to direct traffic for the peer CIDR through the Peering Connection ID (`pcx-xxxx`).

![Peering Connection Status](screenshots/vpc-peering-status.png)

---

## 4. Network Diagram
The following diagram illustrates the routing logic, subnet isolation, and the peering link.

![Network Diagram](screenshots/network-diagram.png)

---

## 5. Security Group Rules (Least Privilege)
Security groups were configured to allow ONLY internal traffic between the peered instances.
- **Rule:** Allow ICMP (Ping) from the peer CIDR only.
- **Result:** Linux 1 was able to successfully ping Linux 2 via its private IP address.

---

## Key Takeaways
- ✅ VPCs isolated by segmented CIDR blocks
- ✅ Private instances secured with no public exposure
- ✅ VPC Peering enables secure, private cross-VPC traffic
- ✅ Routing tables ensure traffic follows defined paths

---

➡️ Next: [Network ACLs (NACL)](nacl.md)
