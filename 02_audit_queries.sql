-- ============================================================================
-- AUDIT TESTING SCRIPT: Production Database Access Log Analysis
-- Project: ITGC Audit
-- Framework Mapping: ISO 27001:2022 A.8.2, A.8.15 & ITGC Access Management
-- ============================================================================


-- ----------------------------------------------------------------------------
-- AUDIT TEST 1: Segregation of Duties (SoD) & Unauthorized DDL Commands
-- Objective: Identify non-DBA roles (e.g., Developers) executing Schema Modifications 
--            (DROP, ALTER, GRANT) in production.
-- Control Evaluated: ISO 27001 Annex A.8.2 (Privileged Access Rights)
-- ----------------------------------------------------------------------------
SELECT log_id, timestamp, db_user, user_role, client_ip, action_performed
FROM db_audit_logs
WHERE user_role = 'Developer' 
  AND (
       action_performed LIKE '%DROP%' 
    OR action_performed LIKE '%ALTER%' 
    OR action_performed LIKE '%GRANT%'
  );

/* 
EXPECTED AUDIT FINDING:
Row 103 flags 'dev_john' dropping the 'payment_logs' table. 
This is a direct violation of Separation of Duties(SoD) principles — 
developers should never have DDL rights in Production.
*/


-- ----------------------------------------------------------------------------
-- AUDIT TEST 2: Privilege Escalation & Unapproved Grants
-- Objective: Flag any GRANT operations executed in the database to verify 
--            if privileges were granted in accordance with Least Privilege.
-- Control Evaluated: ITGC Access Control Policy (Least Privilege)
-- ----------------------------------------------------------------------------
SELECT log_id, timestamp, db_user, action_performed, client_ip
FROM db_audit_logs
WHERE action_performed LIKE '%GRANT%';

/* 
EXPECTED AUDIT FINDING:
Row 102 shows 'admin_sarah' granting ALL PRIVILEGES to 'dev_john'. 
This explains how 'dev_john' was able to perform the DROP operation in Test 1.
*/


-- ----------------------------------------------------------------------------
-- AUDIT TEST 3: Anomalous Access (Off-Hours & Untrusted IP Addresses)
-- Objective: Detect logins originating from outside standard corporate IP ranges 
--            (192.168.x.x or 10.0.x.x) or outside business hours (08:00 to 19:00).
-- Control Evaluated: ISO 27001 Annex A.8.15 (Logging) & Network Perimeter Access
-- ----------------------------------------------------------------------------
SELECT log_id, timestamp, db_user, user_role, client_ip, action_performed
FROM db_audit_logs
WHERE (
        EXTRACT(HOUR FROM timestamp) NOT BETWEEN 8 AND 19
     OR (client_ip NOT LIKE '192.168.%' AND client_ip NOT LIKE '10.0.%')
);

/* 
EXPECTED AUDIT FINDING:
Row 104 shows 'shared_admin' accessing credit card tables at 02:15 AM from an untrusted public IP (185.220.101.5).
*/


-- ----------------------------------------------------------------------------
-- AUDIT TEST 4: Authentication Failures & Brute Force Patterns
-- Objective: Identify accounts experiencing consecutive failed login attempts 
--            to detect potential unauthorized access or credential stuffing.
-- Control Evaluated: ITGC Access Control Policy (Account Lockout & Monitoring)
-- ----------------------------------------------------------------------------
SELECT db_user, client_ip, COUNT(*) AS failed_login_count
FROM db_audit_logs
WHERE status = 'FAILURE'
GROUP BY db_user, client_ip
HAVING COUNT(*) >= 3;

/* 
EXPECTED AUDIT FINDING:
Rows 105, 106, and 107 show 'shared_admin' triggering 3 consecutive failed logins from an external IP within seconds.
*/