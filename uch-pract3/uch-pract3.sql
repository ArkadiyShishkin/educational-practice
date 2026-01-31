-- 1. Создание таблиц-справочников

-- Таблица: Клиенты
CREATE TABLE Clients (
    client_id INT PRIMARY KEY,              -- Уникальный ID клиента
    full_name VARCHAR(100) NOT NULL,        -- ФИО клиента
    passport_data VARCHAR(50) NOT NULL,     -- Паспортные данные
    phone VARCHAR(20),                      -- Телефон
    email VARCHAR(100),                     -- Email
    birth_date DATE                         -- Дата рождения
);

-- Таблица: Каталог туров (Услуги)
CREATE TABLE Tours (
    tour_id INT PRIMARY KEY,                -- Уникальный ID тура
    tour_name VARCHAR(150) NOT NULL,        -- Название тура (например, "Неделя в Париже")
    country VARCHAR(50) NOT NULL,           -- Страна назначения
    description TEXT,                       -- Описание услуг, входящих в тур
    duration_days INT NOT NULL,             -- Длительность (дней)
    base_price DECIMAL(10, 2) NOT NULL      -- Базовая стоимость
);

-- Таблица: Менеджеры
CREATE TABLE Managers (
    manager_id INT PRIMARY KEY,             -- Уникальный ID менеджера
    full_name VARCHAR(100) NOT NULL,        -- ФИО менеджера
    hire_date DATE,                         -- Дата найма
    office_phone VARCHAR(20)                -- Рабочий телефон
);

-- Таблица: Статусы заказа
CREATE TABLE OrderStatuses (
    status_id INT PRIMARY KEY,              -- Уникальный ID статуса
    status_name VARCHAR(30) NOT NULL,       -- Название (Новый, Оплачен, Завершен, Отменен)
    description VARCHAR(255)                -- Пояснение к статусу
);

-- 2. Создание таблицы переменной информации

-- Таблица: Заказы (Бронирования)
-- Эта таблица ссылается на все предыдущие справочники
CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY,             -- Номер заказа
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Дата и время оформления
    
    -- Внешние ключи (ссылки на справочники)
    client_id INT NOT NULL,
    tour_id INT NOT NULL,
    manager_id INT NOT NULL,
    status_id INT NOT NULL,
    
    number_of_people INT DEFAULT 1,         -- Количество человек
    final_price DECIMAL(10, 2) NOT NULL,    -- Итоговая цена (с учетом скидок или доп. услуг)
    
    -- Определение связей (Constraints)
    CONSTRAINT fk_booking_client 
        FOREIGN KEY (client_id) REFERENCES Clients(client_id)
        ON DELETE CASCADE,                  -- Если удалят клиента, удалятся и его заказы
        
    CONSTRAINT fk_booking_tour 
        FOREIGN KEY (tour_id) REFERENCES Tours(tour_id)
        ON DELETE RESTRICT,                 -- Нельзя удалить тур, если на него есть заказы
        
    CONSTRAINT fk_booking_manager 
        FOREIGN KEY (manager_id) REFERENCES Managers(manager_id)
        ON DELETE SET NULL,                 -- Если уволят менеджера, в истории ID станет NULL
        
    CONSTRAINT fk_booking_status 
        FOREIGN KEY (status_id) REFERENCES OrderStatuses(status_id)
);

-- 3. Создание индексов для оптимизации производительности
-- Индексы создаются на полях внешних ключей для ускорения соединений (JOIN) таблиц

CREATE INDEX idx_bookings_client ON Bookings(client_id);
CREATE INDEX idx_bookings_tour ON Bookings(tour_id);
CREATE INDEX idx_bookings_manager ON Bookings(manager_id);
CREATE INDEX idx_bookings_date ON Bookings(booking_date);

-- 4. (Опционально) Пример заполнения справочников начальными данными

INSERT INTO OrderStatuses (status_id, status_name) VALUES 
(1, 'Создан'),
(2, 'Ожидает оплаты'),
(3, 'Оплачен'),
(4, 'Выполнен'),
(5, 'Отменен');

INSERT INTO Tours (tour_id, tour_name, country, duration_days, base_price) VALUES
(1, 'Пляжный отдых в Анталии', 'Турция', 7, 50000.00),
(2, 'Экскурсии по Риму', 'Италия', 5, 75000.00),
(3, 'Сафари', 'Кения', 10, 150000.00);
