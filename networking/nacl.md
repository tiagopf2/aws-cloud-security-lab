# Network Access Control Lists (NACL)

## Overview
While Security Groups are stateful and operate at the instance level, **Network ACLs (NACLs)** are stateless and operate at the subnet level. This section demonstrates how NACLs provide an additional layer of perimeter security.

---

## 1. NACL Configuration
A custom NACL was applied to the public subnet. Following the Principle of Least Privilege, the rules were configured to allow only specific, necessary traffic.

### Inbound Rules

| Rule # | Type | Protocol | Port Range | Source | Allow/Deny |
|---|---|---|---|---|---|
| 100 | SSH | TCP | 22 | [Admin-IP/32] | ALLOW |
| 200 | HTTP | TCP | 80 | 0.0.0.0/0 | ALLOW |
| 300 | ICMP | ALL | ALL | 0.0.0.0/0 | ALLOW |
| * | ALL Traffic | ALL | ALL | 0.0.0.0/0 | **DENY** |

![NACL Inbound Rules](screenshots/nacl-inbound.png)

---

## 2. Inbound vs. Outbound Logic
NACLs are **stateless**. This means that if you allow traffic in, you must also explicitly allow the response traffic out.

### Outbound Rules
The outbound rules were configured to allow response traffic back to the requester.

![NACL Outbound Rules](screenshots/nacl-outbound.png)

---

## 3. Security Analysis: SG vs. NACL
In this project, both were used for **Defense-in-Depth**:
- **NACL:** Acts as the first line of defense at the subnet gate.
- **Security Group:** Acts as the final firewall at the virtual network interface of the EC2 instance.

---

## 4. Verification
Testing confirmed that:
1. Ping (ICMP) was successful when the NACL rule existed.
2. Access was immediately dropped when the rule was removed or set to `Deny`.

---

## Key Takeaways
- ✅ NACLs provide a secondary "Subnet-level" firewall.
- ✅ Stateless nature requires managing both Inbound and Outbound flows.
- ✅ Custom rules reduce the attack surface compared to Default NACLs (which allow all).
- ✅ Essential for blocking specific IP ranges at the network entry point.

---

➡️ Back to: [VPC Peering](vpc-peering.md)
