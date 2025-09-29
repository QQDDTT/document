CREATE DATABASE auth_mng;

USE auth_mng;
DROP TABLE role_authority;
DROP TABLE user;
DROP TABLE role;
DROP TABLE authority;

-- 创建 authority 表
CREATE TABLE authority (
    authority_id VARCHAR(4) NOT NULL PRIMARY KEY,
    authority_name VARCHAR(50) NOT NULL,
    authority_description VARCHAR(255),
    delete_flag VARCHAR(1) NOT NULL DEFAULT '0'
);

-- 创建 role 表
CREATE TABLE role (
    role_id VARCHAR(6) NOT NULL PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL,
    role_description VARCHAR(255),
    delete_flag VARCHAR(1) NOT NULL DEFAULT '0'
);

-- 创建 user 表
CREATE TABLE user (
    user_id VARCHAR(8) NOT NULL PRIMARY KEY,           -- 用户 ID，作为主键
    user_name VARCHAR(16) NOT NULL,                    -- 用户姓名
    email VARCHAR(64) NOT NULL UNIQUE,            -- 用户邮箱，唯一
    password VARCHAR(32) NOT NULL,                -- 用户密码
    phone VARCHAR(11),                            -- 用户电话
    address VARCHAR(255),                         -- 用户地址
    role_id VARCHAR(6) NOT NULL,                  -- 角色 ID，外键
    delete_flag VARCHAR(1) NOT NULL DEFAULT '0',  -- 删除标志，0 表示未删除，1 表示已删除
    create_date DATETIME NOT NULL,                -- 创建时间
    update_date DATETIME NOT NULL,                -- 更新时间
    FOREIGN KEY (role_id) REFERENCES role(role_id)     -- 角色 ID 外键约束
);

-- 创建中间表 role_authority
CREATE TABLE role_authority (
    role_id VARCHAR(6) NOT NULL,
    authority_id VARCHAR(4) NOT NULL,
    PRIMARY KEY (role_id, authority_id),
    FOREIGN KEY (role_id) REFERENCES role(role_id),
    FOREIGN KEY (authority_id) REFERENCES authority(authority_id)
);

-- 学生管理权限
INSERT INTO authority (authority_id, authority_name, authority_description) VALUES 
('ST01', 'VIEW_STUDENT', '查看学生信息'),
('ST02', 'ADD_STUDENT', '添加学生信息'),
('ST03', 'EDIT_STUDENT', '编辑学生信息'),
('ST04', 'DELETE_STUDENT', '删除学生信息');

-- 课程管理权限
INSERT INTO authority (authority_id, authority_name, authority_description) VALUES 
('CO01', 'VIEW_COURSE', '查看课程信息'),
('CO02', 'ADD_COURSE', '添加课程'),
('CO03', 'EDIT_COURSE', '编辑课程信息'),
('CO04', 'DELETE_COURSE', '删除课程');

-- 成绩管理权限
INSERT INTO authority (authority_id, authority_name, authority_description) VALUES 
('GR01', 'VIEW_GRADES', '查看成绩'),
('GR02', 'ADD_GRADES', '录入成绩'),
('GR03', 'EDIT_GRADES', '编辑成绩'),
('GR04', 'DELETE_GRADES', '删除成绩记录');

-- 用户管理权限
INSERT INTO authority (authority_id, authority_name, authority_description) VALUES 
('US01', 'VIEW_USER', '查看用户'),
('US02', 'ADD_USER', '添加用户'),
('US03', 'EDIT_USER', '编辑用户'),
('US04', 'DELETE_USER', '删除用户');

-- 系统设置权限
INSERT INTO authority (authority_id, authority_name, authority_description) VALUES 
('SY01', 'MANAGE_role', '管理角色和权限'),
('SY02', 'VIEW_LOGS', '查看系统日志'),
('SY03', 'BACKUP_RESTORE', '备份和恢复数据'),
('SY04', 'SET_NOTIFICATIONS', '设置通知和消息');

-- 通知与公告管理权限
INSERT INTO authority (authority_id, authority_name, authority_description) VALUES 
('AN01', 'VIEW_ANNOUNCEMENTS', '查看公告'),
('AN02', 'ADD_ANNOUNCEMENTS', '发布公告'),
('AN03', 'EDIT_ANNOUNCEMENTS', '编辑公告'),
('AN04', 'DELETE_ANNOUNCEMENTS', '删除公告');

-- 报表管理权限
INSERT INTO authority (authority_id, authority_name, authority_description) VALUES 
('RP01', 'GENERATE_STUDENT_REPORT', '生成学生报表'),
('RP02', 'GENERATE_COURSE_REPORT', '生成课程报表'),
('RP03', 'EXPORT_REPORT', '导出报表');

-- 宿舍和后勤管理权限
INSERT INTO authority (authority_id, authority_name, authority_description) VALUES 
('DM01', 'VIEW_DORM_ASSIGNMENT', '查看宿舍分配信息'),
('DM02', 'MANAGE_DORM_ASSIGNMENT', '管理宿舍分配'),
('LG01', 'VIEW_LOGISTICS_REQUEST', '查看后勤服务请求'),
('LG02', 'PROCESS_LOGISTICS_REQUEST', '处理后勤服务请求');

-- 其他权限
INSERT INTO authority (authority_id, authority_name, authority_description) VALUES 
('OT01', 'ACCESS_CONTROL', '访问控制'),
('OT02', 'DATA_IMPORT_EXPORT', '数据导入/导出'),
('OT03', 'APPROVAL', '审批权限');

-- 测试用权限
INSERT INTO authority (authority_id, authority_name, authority_description) VALUES 
('TE01', 'TEST_PERMISSION_1', '测试权限 1'),
('TE02', 'TEST_PERMISSION_2', '测试权限 2'),
('TE03', 'TEST_PERMISSION_3', '测试权限 3');

-- 插入角色
INSERT INTO role (role_id, role_name, role_description) VALUES 
('ADMIN', '超级管理员', '系统的最高权限用户'),
('MOD', '管理员', '系统的日常管理者'),
('TEACH', '教师', '负责授课和学生管理'),
('STUD', '学生', '学生用户'),
('ACA', '教务处', '负责学生学籍和成绩管理的部门'),
('LOG', '后勤管理', '负责学生宿舍和后勤服务的管理'),
('AUD', '审计员', '负责系统审计和合规性检查的角色'),
('GUEST', '访客', '只有查看权限的角色'),
('BLANK', '空白', '没有任何权限的角色');

-- 超级管理员 (ADMIN) - 拥有所有权限
INSERT INTO role_authority (role_id, authority_id) VALUES 
('ADMIN', 'ST01'), ('ADMIN', 'ST02'), ('ADMIN', 'ST03'), ('ADMIN', 'ST04'),
('ADMIN', 'CO01'), ('ADMIN', 'CO02'), ('ADMIN', 'CO03'), ('ADMIN', 'CO04'),
('ADMIN', 'GR01'), ('ADMIN', 'GR02'), ('ADMIN', 'GR03'), ('ADMIN', 'GR04'),
('ADMIN', 'US01'), ('ADMIN', 'US02'), ('ADMIN', 'US03'), ('ADMIN', 'US04'),
('ADMIN', 'SY01'), ('ADMIN', 'SY02'), ('ADMIN', 'SY03'), ('ADMIN', 'SY04'),
('ADMIN', 'AN01'), ('ADMIN', 'AN02'), ('ADMIN', 'AN03'), ('ADMIN', 'AN04'),
('ADMIN', 'RP01'), ('ADMIN', 'RP02'), ('ADMIN', 'RP03'),
('ADMIN', 'DM01'), ('ADMIN', 'DM02'), ('ADMIN', 'LG01'), ('ADMIN', 'LG02'),
('ADMIN', 'OT01'), ('ADMIN', 'OT02'), ('ADMIN', 'OT03');

-- 管理员 (MOD) - 用户、公告和部分系统设置权限
INSERT INTO role_authority (role_id, authority_id) VALUES 
('MOD', 'US01'), ('MOD', 'US02'), ('MOD', 'US03'), ('MOD', 'AN01'),
('MOD', 'AN02'), ('MOD', 'AN03'), ('MOD', 'SY02'), ('MOD', 'RP01'), ('MOD', 'RP03');

-- 教师 (TEACH) - 学生和成绩查看、编辑权限，课程查看权限
INSERT INTO role_authority (role_id, authority_id) VALUES 
('TEACH', 'ST01'), ('TEACH', 'ST03'), ('TEACH', 'GR01'), ('TEACH', 'GR03'), ('TEACH', 'CO01');

-- 学生 (STUD) - 查看课程、公告和自己的成绩
INSERT INTO role_authority (role_id, authority_id) VALUES 
('STUD', 'ST01'), ('STUD', 'CO01'), ('STUD', 'AN01'), ('STUD', 'GR01');

-- 教务处 (ACA) - 学生、课程和成绩管理及报表生成
INSERT INTO role_authority (role_id, authority_id) VALUES 
('ACA', 'ST01'), ('ACA', 'ST02'), ('ACA', 'ST03'), ('ACA', 'ST04'),
('ACA', 'CO01'), ('ACA', 'CO02'), ('ACA', 'CO03'), ('ACA', 'CO04'),
('ACA', 'GR01'), ('ACA', 'GR02'), ('ACA', 'GR03'), ('ACA', 'RP01'), ('ACA', 'RP02');

-- 后勤管理 (LOG) - 宿舍、后勤管理相关权限
INSERT INTO role_authority (role_id, authority_id) VALUES 
('LOG', 'DM01'), ('LOG', 'DM02'), ('LOG', 'LG01'), ('LOG', 'LG02');

-- 审计员 (AUD) - 查看日志和导出报表
INSERT INTO role_authority (role_id, authority_id) VALUES 
('AUD', 'SY02'), ('AUD', 'RP03');

-- 用户数据
INSERT INTO user (user_id, user_name, email, password, phone, address, role_id, delete_flag, create_date, update_date) VALUES 
('U0000001', 'admin', 'admin@example.com', 'password', '12345678901', 'Headquarters', 'ADMIN', '0', NOW(), NOW()),
('U0000002', 'mod', 'mod@example.com', 'password', '12345678902', 'Headquarters', 'MOD', '0', NOW(), NOW()),
('U0000003', 'teacher', 'teacher@example.com', 'password', '12345678903', 'Headquarters', 'TEACH', '0', NOW(), NOW()),
('U0000004', 'student', 'student@example.com', 'password', '12345678904', 'Headquarters', 'STUD', '0', NOW(), NOW()),
('U0000005', 'aca', 'aca@example.com', 'password', '12345678905', 'Headquarters', 'ACA', '0', NOW(), NOW()),
('U0000006', 'log', 'log@example.com', 'password', '12345678906', 'Headquarters', 'LOG', '0', NOW(), NOW()),
('U0000007', 'aud', 'aud@example.com', 'password', '12345678907', 'Headquarters', 'AUD', '0', NOW(), NOW()),
('U0000008', 'guest', 'guest@example.com', 'password', '12345678908', 'Headquarters', 'GUEST', '0', NOW(), NOW()),
('U0000009', 'test', 'test@example.com', 'password', '12345678909', 'Headquarters', 'BLANK', '0', NOW(), NOW()) 
;

-- 查询用户数据
SELECT u.user_id, u.user_name, u.email, u.password, u.phone, u.address, u.role_id, u.delete_flag, u.create_date, u.update_date, 
       r.role_name, r.role_description, 
       a.authority_id, a.authority_name, a.authority_description
FROM user u 
INNER JOIN role r ON u.role_id = r.role_id
INNER JOIN role_authority ra ON r.role_id = ra.role_id
INNER JOIN authority a ON ra.authority_id = a.authority_id
WHERE u.user_id = 'U0000002';

--LEFT JOIN
--目的：即使某个角色没有权限，也要列出它的信息。
SELECT 
    r.role_id, r.role_name, 
    a.authority_id, a.authority_name
FROM role r
LEFT JOIN role_authority ra ON r.role_id = ra.role_id
LEFT JOIN authority a ON ra.authority_id = a.authority_id
WHERE r.role_id = 'BLANK';

--RIGHT JOIN
--目的：即使某个权限没有角色，也要列出它的信息。
SELECT 
    r.role_id, r.role_name, 
    a.authority_id, a.authority_name
FROM role r
RIGHT JOIN role_authority ra ON r.role_id = ra.role_id
RIGHT JOIN authority a ON ra.authority_id = a.authority_id
WHERE a.authority_id = 'TE01';


-- 哪些权限未被分配
SELECT 
    a.authority_id, a.authority_name
FROM authority a
LEFT JOIN role_authority ra ON a.authority_id = ra.authority_id
WHERE ra.authority_id IS NULL;

-- 笛卡尔积
SELECT u.user_id, u.user_name, r.role_id, r.role_name
FROM user u
CROSS JOIN role r;



-- 左连接：所有用户
-- 右连接补全：只保留没有被 user 匹配到的角色
SELECT u.user_id, u.user_name, u.role_id, r.role_name
FROM user u
LEFT JOIN role r ON u.role_id = r.role_id

UNION

SELECT u.user_id, u.user_name, u.role_id, r.role_name
FROM user u
RIGHT JOIN role r ON u.role_id = r.role_id
WHERE u.user_id IS NULL;
