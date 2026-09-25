-- 1. Create Audit Log Table
CREATE TABLE db_audit_logs (
    log_id INT PRIMARY KEY,
    timestamp TIMESTAMP NOT NULL,
    db_user VARCHAR(50) NOT NULL,
    user_role VARCHAR(50) NOT NULL,
    client_ip VARCHAR(45) NOT NULL,
    action_performed VARCHAR(100) NOT NULL,
    status VARCHAR(20) NOT NULL
);

-- 2. Insert Sample Audit Trail Data (Including Control Exceptions)
INSERT INTO db_audit_logs VALUES
(101, '2026-08-01 09:15:00', 'dev_john', 'Developer', '192.168.1.45', 'SELECT * FROM users', 'SUCCESS'),
(102, '2026-08-01 10:30:00', 'admin_sarah', 'DBA', '10.0.0.12', 'GRANT ALL PRIVILEGES TO dev_john', 'SUCCESS'),
(103, '2026-08-01 11:00:00', 'dev_john', 'Developer', '192.168.1.45', 'DROP TABLE payment_logs', 'SUCCESS'),
(104, '2026-08-02 02:15:00', 'shared_admin', 'DBA', '185.220.101.5', 'SELECT * FROM credit_cards', 'SUCCESS'),
(105, '2026-08-02 02:16:00', 'shared_admin', 'DBA', '185.220.101.5', 'FAILED LOGIN ATTEMPT', 'FAILURE'),
(106, '2026-08-02 02:16:05', 'shared_admin', 'DBA', '185.220.101.5', 'FAILED LOGIN ATTEMPT', 'FAILURE'),
(107, '2026-08-02 02:16:10', 'shared_admin', 'DBA', '185.220.101.5', 'FAILED LOGIN ATTEMPT', 'FAILURE');