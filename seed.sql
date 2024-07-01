-- Создание таблицы чат-ботов
CREATE TABLE chatbots (
    id SERIAL PRIMARY KEY,
    clerk_user_id VARCHAR(255) NOT NULL, -- Clerk's user ID
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Создание таблицы характеристик чат-ботов
CREATE TABLE chatbot_characteristics (
    id SERIAL PRIMARY KEY,
    chatbot_id INT REFERENCES chatbots(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Создание таблицы гостей
CREATE TABLE guests (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Создание таблицы сессий чата
CREATE TABLE chat_sessions (
    id SERIAL PRIMARY KEY,
    chatbot_id INT REFERENCES chatbots(id) ON DELETE CASCADE,
    guest_id INT REFERENCES guests(id) ON DELETE SET NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- Создание таблицы сообщений
CREATE TABLE messages (
    id SERIAL PRIMARY KEY,
    chat_session_id INT REFERENCES chat_sessions(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    sender VARCHAR(50) NOT NULL -- 'user' or 'ai'
);

-- Создание функции триггера для установки created_at
CREATE OR REPLACE FUNCTION set_created_at()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.created_at IS NULL THEN
    NEW.created_at = CURRENT_TIMESTAMP;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Создание триггеров для каждой таблицы для установки created_at
CREATE TRIGGER set_chatbots_created_at
BEFORE INSERT ON chatbots
FOR EACH ROW
EXECUTE FUNCTION set_created_at();

CREATE TRIGGER set_chatbot_characteristics_created_at
BEFORE INSERT ON chatbot_characteristics
FOR EACH ROW
EXECUTE FUNCTION set_created_at();

CREATE TRIGGER set_guests_created_at
BEFORE INSERT ON guests
FOR EACH ROW
EXECUTE FUNCTION set_created_at();

CREATE TRIGGER set_chat_sessions_created_at
BEFORE INSERT ON chat_sessions
FOR EACH ROW
EXECUTE FUNCTION set_created_at();

CREATE TRIGGER set_messages_created_at
BEFORE INSERT ON messages
FOR EACH ROW
EXECUTE FUNCTION set_created_at();
-- ----------------------------------------------

-- Вставка примерных данных чат-ботов
INSERT INTO chatbots (clerk_user_id, name, created_at) VALUES
('clerk_user_1', 'Бот поддержки клиентов', CURRENT_TIMESTAMP),
('clerk_user_2', 'Бот продаж', CURRENT_TIMESTAMP);

-- Вставка примерных данных характеристик чат-ботов
INSERT INTO chatbot_characteristics (chatbot_id, content, created_at) VALUES
(1, 'Вы полезный помощник поддержки клиентов.', CURRENT_TIMESTAMP),
(1, 'Наши часы работы поддержки с 9:00 до 17:00, с понедельника по пятницу.', CURRENT_TIMESTAMP),
(1, 'Вы можете отслеживать ваш заказ на нашем веб-сайте.', CURRENT_TIMESTAMP),
(2, 'Вы компетентный помощник по продажам.', CURRENT_TIMESTAMP),
(2, 'Мы предлагаем 30-дневную гарантию возврата денег на все наши продукты.', CURRENT_TIMESTAMP),
(2, 'Наши продукты доступны в различных размерах и цветах.', CURRENT_TIMESTAMP)

-- Вставка примерных данных гостей
INSERT INTO guests (name, email, created_at) VALUES
('Гость1', 'guest1@example.com', CURRENT_TIMESTAMP),
('Гость2', 'guest2@example.com', CURRENT_TIMESTAMP);

-- Вставка примерных данных сессий чата
INSERT INTO chat_sessions (chatbot_id, guest_id, created_at) VALUES
(1, 1, CURRENT_TIMESTAMP),
(2, 2, CURRENT_TIMESTAMP);

-- Вставка примерных данных сообщений
INSERT INTO messages (chat_session_id, content, created_at, sender) VALUES
(1, 'Здравствуйте, мне нужна помощь с моим заказом.', CURRENT_TIMESTAMP, 'user'),
(1, 'Конечно, я могу помочь с этим. В чем проблема?', CURRENT_TIMESTAMP, 'ai'),
(2, 'Можете ли вы рассказать мне больше о ваших продуктах?', CURRENT_TIMESTAMP, 'user'),
(2, 'Конечно! Мы предлагаем широкий ассортимент продуктов. Какой вас интересует?', CURRENT_TIMESTAMP, 'ai')