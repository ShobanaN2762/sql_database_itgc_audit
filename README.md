# SQL Database ITGC Access Control & Audit Simulation

![Audit Standard](https://img.shields.io/badge/Compliance-ISO%2027001%3A2022-blue)
![Domain](https://img.shields.io/badge/Domain-ITGC%20%7C%20Access%20Management-green)
![Tools](https://img.shields.io/badge/Tools-SQL%20%7C%20PostgreSQL%20%7C%20MySQL-orange)

> **Note:** This is a portfolio project using a fictional company and synthetic (mock) data. No real systems, logs, or customer information were used.

## 📌 Executive Overview

This repository contains an end-to-end technical **IT General Controls (ITGC)** audit simulation of a production database access log review for a fictional fintech platform (_VortexPe Solutions_).

The project demonstrates technical audit testing using custom SQL queries to identify compliance exceptions, evaluate risks using the **CCCER Framework** (Condition, Criteria, Cause, Effect, Recommendation), and map findings to **ISO 27001:2022** controls and standard ITGC Access Management practices.

---

## 🎯 Audit Scope & Objective

- **Target System:** Simulated production transaction database access logs (Q3 2026, mock dataset)
- **Objective:** Evaluate user access controls, privilege allocation, and log monitoring mechanisms.
- **Framework Mapping:**
  - **ISO 27001:2022 A.5.3:** Segregation of Duties
  - **ISO 27001:2022 A.8.2:** Privileged Access Rights & Least Privilege
  - **ISO 27001:2022 A.5.17:** Authentication Information (Credential & Account Accountability)
  - **ISO 27001:2022 A.8.5:** Secure Authentication
  - **ISO 27001:2022 A.8.15:** Logging
  - **ITGC Access Management:** Access provisioning, privileged access, and account accountability

---

## 🔍 Key Findings Summary

| Finding ID    | Control Gap                                                                                                   | Risk Level | Relevant Standard                                   | Key Recommendation                                                                            |
| :------------ | :------------------------------------------------------------------------------------------------------------ | :--------- | :-------------------------------------------------- | :-------------------------------------------------------------------------------------------- |
| **FINDING 1** | Excessive Developer Privileges in Production (Developer dropped a production table; Least Privilege & SoD)    | **HIGH**   | ISO 27001 A.8.2 / A.5.3<br>ITGC Access Control      | Revoke developer DDL permissions in production; enforce RBAC and just-in-time admin access.   |
| **FINDING 2** | Unapproved Privilege Escalation (`GRANT ALL PRIVILEGES` executed; no approval evidence in the logs provided)  | **HIGH**   | ISO 27001 A.8.2<br>ITGC Access Control              | Trace grants to approved change requests; alert on privilege grants; quarterly access review. |
| **FINDING 3** | Shared Admin Account & Off-Hours External Access (Session at 02:15 AM from a public IP, then repeated failed logins) | **HIGH**   | ISO 27001 A.5.17 / A.8.5 / A.8.15<br>ITGC Access & Operations | Replace shared logins with named accounts; enforce MFA and VPN/bastion host access.           |

---

## 📁 Repository Artifacts

- [`01_schema_and_logs.sql`](./01_schema_and_logs.sql): Creates the database schema and inserts mock audit logs containing simulated control exceptions.
- [`02_audit_queries.sql`](./02_audit_queries.sql): Audit test queries that detect developer DDL activity, privilege grants, off-hours or untrusted-IP access, and repeated failed logins.
- [`03_Audit_Report.pdf`](./03_Audit_Report.pdf): IT Audit Observation Memo with findings, query output exhibits, risk ratings, and a Management Remediation Action Plan.

---

## ▶️ How to Run

1. Create an empty database in PostgreSQL (or MySQL).
2. Run `01_schema_and_logs.sql` to create the table and load the mock logs.
3. Run the queries in `02_audit_queries.sql` one at a time and compare the output with the exhibits in the audit report.

---

## ⚠️ Limitations

- The dataset is synthetic and small (7 log rows), built to demonstrate audit logic rather than real-world scale.
- No ticketing or approval system data was included, so approval status can only be flagged for follow-up, not confirmed.
- Queries use fixed thresholds (business hours, trusted IP ranges, 3 failed logins) that a real audit would tune to the organization's policy.
