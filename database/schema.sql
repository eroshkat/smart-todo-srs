-- НОРМАЛИЗОВАННАЯ схема до 3NF для MySQL - Менеджер паролей

CREATE TABLE Users (
    user_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    master_password_hash VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_login DATETIME,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE Categories (
    category_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    user_id INTEGER NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    color VARCHAR(7) DEFAULT '#98FB98',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_category (user_id, name)
);

CREATE TABLE Password_Generator_Settings (
    user_id INTEGER PRIMARY KEY,
    default_length INTEGER DEFAULT 12,
    include_uppercase BOOLEAN DEFAULT TRUE,
    include_lowercase BOOLEAN DEFAULT TRUE,
    include_numbers BOOLEAN DEFAULT TRUE,
    include_symbols BOOLEAN DEFAULT TRUE,
    excluded_chars VARCHAR(50) DEFAULT '',
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    CHECK (default_length BETWEEN 8 AND 50)
);

CREATE TABLE Security_Settings (
    user_id INTEGER PRIMARY KEY,
    auto_lock_minutes INTEGER DEFAULT 5,
    biometric_auth BOOLEAN DEFAULT FALSE,
    two_factor_auth BOOLEAN DEFAULT FALSE,
    master_password_iterations INTEGER DEFAULT 100000,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    CHECK (auto_lock_minutes BETWEEN 1 AND 1440),
    CHECK (master_password_iterations >= 10000)
);

CREATE TABLE Accounts (
    account_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    user_id INTEGER NOT NULL,
    category_id INTEGER,
    title VARCHAR(200) NOT NULL,
    username VARCHAR(255),
    encrypted_password VARCHAR(500) NOT NULL,
    url VARCHAR(500),
    notes TEXT,
    custom_fields JSON,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    last_accessed DATETIME,
    is_favorite BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE SET NULL
);

CREATE TABLE Password_History (
    history_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    account_id INTEGER NOT NULL,
    old_encrypted_password VARCHAR(500) NOT NULL,
    changed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    change_reason VARCHAR(100),
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id) ON DELETE CASCADE
);

-- Индексы для оптимизациb
CREATE INDEX idx_users_username ON Users(username);
CREATE INDEX idx_users_email ON Users(email);
CREATE INDEX idx_users_created_at ON Users(created_at);

CREATE INDEX idx_categories_user_id ON Categories(user_id);
CREATE INDEX idx_categories_name ON Categories(name);

CREATE INDEX idx_accounts_user_id ON Accounts(user_id);
CREATE INDEX idx_accounts_category_id ON Accounts(category_id);
CREATE INDEX idx_accounts_title ON Accounts(title);
CREATE INDEX idx_accounts_url ON Accounts(url);
CREATE INDEX idx_accounts_updated_at ON Accounts(updated_at);
CREATE INDEX idx_accounts_is_favorite ON Accounts(is_favorite);
CREATE INDEX idx_accounts_user_category ON Accounts(user_id, category_id);

CREATE INDEX idx_password_history_account_id ON Password_History(account_id);
CREATE INDEX idx_password_history_changed_at ON Password_History(changed_at);
CREATE INDEX idx_password_history_account_changed ON Password_History(account_id, changed_at);

-- Триггер для автоматического обновления updated_at
DELIMITER //
CREATE TRIGGER update_accounts_timestamp 
    BEFORE UPDATE ON Accounts
    FOR EACH ROW 
BEGIN
    SET NEW.updated_at = CURRENT_TIMESTAMP;
END//
DELIMITER ;

-- Триггер для автоматического создания настроек при регистрации пользователя
DELIMITER //
CREATE TRIGGER create_user_settings 
    AFTER INSERT ON Users
    FOR EACH ROW 
BEGIN
    INSERT INTO Password_Generator_Settings (user_id) VALUES (NEW.user_id);
    INSERT INTO Security_Settings (user_id) VALUES (NEW.user_id);
END//
DELIMITER ;
