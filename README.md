# SQL Database ITGC Access Control & Audit Simulation

![Audit Standard](https://img.shields.io/badge/Compliance-ISO%2027001%3A2022-blue)
![Domain](https://img.shields.io/badge/Domain-ITGC%20%7C%20Access%20Management-green)
![Tools](https://img.shields.io/badge/Tools-SQL%20%7C%20PostgreSQL%20%7C%20MySQL-orange)

## 📌 Executive Overview

This repository contains an end-to-end technical **IT General Controls (ITGC)** audit project simulating a production database access log review for a fintech platform (_VortexPe Solutions_).

The project demonstrates technical audit testing using custom SQL queries to identify compliance exceptions, evaluate risks using the **CCCER Framework** (Condition, Criteria, Cause, Effect, Recommendation), and map findings to **ISO 27001:2022** controls and standard ITGC Access Management frameworks.

---

## 🎯 Audit Scope & Objective

- **Target System:** Production Transaction Database Access Logs (Q3 2026)
- **Objective:** Verify operational effectiveness of user access controls, privilege allocation, and log monitoring mechanisms.
- **Framework Mapping:**
  - **ISO 27001:2022 Control A.8.2:** Privileged Access Rights & Least Privilege
  - **ISO 27001:2022 Control A.8.15:** Logging & Monitoring
  - **ISO 27001:2022 Control A.8.3:** Segregation of Duties(SoD) and Information Access Restriction
  - **ISO 27001:2022 Control A.5.17:** Authentication Information (Credential & Account Accountability)
  - **ITGC Access Management:** Segregation of Duties (SoD) & Account Accountability

---

## 🔍 Key Findings Summary

| Finding ID    | Control Gap                                                                             | Risk Level | Relevant Standard  | Key Recommendation                                                                            |
| :------------ | :-------------------------------------------------------------------------------------- | :--------- | :-----------------  | :-------------------------------------------------------------------------------------------- |
| **FINDING 1** | Segregation of Duties (SoD) Breakdown (Developer dropped production table)              | **HIGH**   | **ISO 27001 A.5.3 / A.8.2**<br>**ITGC Access Control**    | Revoke developer DDL write permissions in production; enforce RBAC.                           |
| **FINDING 2** | Unapproved Privilege Escalation (`GRANT ALL PRIVILEGES` executed without change ticket) | **HIGH**   | **ISO 27001 A.8.2**<br>**ITGC Access Control** | Implement automated SIEM alerts on privilege grants & quarterly recertification.              |
| **FINDING 3** | Shared Admin Account & Off-Hours External Access (Login at 02:15 AM from public IP)     | **HIGH**   | **ISO 27001 A.8.15 / A.5.17**<br>**ITGC Access & Operations**   | Deprecate generic shared logins; enforce individual named accounts, MFA, & VPN/Bastion hosts. |

---

## 📁 Repository Artifacts

- [`01_schema_and_logs.sql`](./01_schema_and_logs.sql): SQL script for creating the database schema and inserting mock audit logs containing simulated control exceptions.
- [`02_audit_queries.sql`](./02_audit_queries.sql): Audit verification queries executed to detect SoD failures, unauthorized grants, off-hours logins, and brute-force authentication patterns.
- [`03_Audit_Report.pdf`](./03_Audit_Report.pdf): Formal 4-page IT Audit Observation Memo documenting detailed findings, audit evidence exhibits, risk evaluations, and a Management Remediation Action Plan.

---
