-- Тестовые данные для Менеджера паролей

INSERT INTO Users (username, email, master_password_hash, is_active) VALUES 
('alex_ivanov', 'alex@example.com', '$2b$10$N9qo8uLOickgx2ZMRZ1Mye.KdW9tP2uVW5gRcQpOzBqGZv47q.LK6', TRUE),
('maria_petrova', 'maria@example.com', '$2b$10$N9qo8uLOickgx2ZMRZoMye.KdW9tP2uVW5gRcQpOzBqGZv47q.LK6', TRUE),
('sergey_smirnov', 'sergey@example.com', '$2b$10$N9qo8uLOickgx2ZMRZoMye.KdW9tP2uVW5gRcQpOzBqGZv47q.LK6', TRUE);

UPDATE Security_Settings SET biometric_auth = TRUE, two_factor_auth = TRUE WHERE user_id = 1;
UPDATE Security_Settings SET auto_lock_minutes = 10 WHERE user_id = 2;

INSERT INTO Categories (user_id, name, description, color) VALUES 
(1, 'Работа', 'Рабочие учетные записи', '#98FB98'),
(1, 'Соцсети', 'Социальные сети и мессенджеры', '#87CEEB'),
(1, 'Финансы', 'Банки и финансовые сервисы', '#FFB6C1'),
(2, 'Личное', 'Личные учетные записи', '#F0FFF0'),
(2, 'Работа', 'Рабочие аккаунты', '#D0F0D0'),
(3, 'Все записи', 'Все мои пароли', '#E8F5E8');

INSERT INTO Accounts (user_id, category_id, title, username, encrypted_password, url, notes, is_favorite) VALUES 

(1, 1, 'Корпоративная почта', 'a.ivanov@company.com', 'encrypted_password_1', 'https://mail.company.com', 'Рабочая почта', TRUE),
(1, 1, 'JIRA', 'alex.ivanov', 'encrypted_password_2', 'https://company.atlassian.net', 'Система управления задачами', FALSE),
(1, 2, 'Facebook', 'alex.ivanov.fb', 'encrypted_password_3', 'https://facebook.com', 'Личная страница', FALSE),
(1, 2, 'Telegram', '+79161234567', 'encrypted_password_4', NULL, 'Основной мессенджер', TRUE),
(1, 3, 'Сбербанк Онлайн', 'alex_ivanov', 'encrypted_password_5', 'https://online.sberbank.ru', 'Основной банковский аккаунт', TRUE),

(2, 4, 'Личная почта', 'maria.petrova.personal', 'encrypted_password_6', 'https://gmail.com', 'Личная почта', TRUE),
(2, 5, 'Slack работы', 'maria.petrova', 'encrypted_password_7', 'https://workspace.slack.com', 'Рабочий чат', FALSE),
(2, 4, 'Instagram', 'maria_petrova_art', 'encrypted_password_8', 'https://instagram.com', 'Аккаунт для творчества', TRUE),

(3, 6, 'Google Аккаунт', 'sergey.smirnov@gmail.com', 'encrypted_password_9', 'https://accounts.google.com', 'Основной Google аккаунт', TRUE),
(3, 6, 'GitHub', 'sergey-smirnov-dev', 'encrypted_password_10', 'https://github.com', 'Профиль разработчика', FALSE);

INSERT INTO Password_History (account_id, old_encrypted_password, change_reason) VALUES 
(1, 'old_encrypted_password_1_prev', 'Регулярная смена пароля'),
(1, 'old_encrypted_password_1_very_old', 'Первоначальная установка'),
(4, 'old_encrypted_password_4_prev', 'Обновление по безопасности'),
(7, 'old_encrypted_password_7_prev', 'Смена после утечки');

UPDATE Accounts SET last_accessed = '2024-12-15 10:30:00' WHERE account_id IN (1, 3, 5);
UPDATE Accounts SET last_accessed = '2024-12-14 16:45:00' WHERE account_id IN (2, 4);
UPDATE Accounts SET last_accessed = '2024-12-13 09:15:00' WHERE account_id IN (6, 7, 8, 9, 10);
