# Data Model: PromoLink Web Application

This document defines the database schema for the PromoLink application based on the entities identified in the specification.

## 1. `users` Table

Stores user accounts and their roles.

| Column Name | Data Type | Constraints | Description |
|---|---|---|---|
| `id` | `INTEGER` | **Primary Key** | Unique identifier for the user. |
| `username` | `VARCHAR(255)` | **Unique**, **Not Null** | User's login name. |
| `hashed_password` | `VARCHAR(255)` | **Not Null** | Hashed password. |
| `role` | `VARCHAR(50)` | **Not Null** | User's role (`admin`, `sales`, `cto`). |
| `created_at` | `TIMESTAMP` | **Not Null**, Default: `NOW()` | Timestamp of user creation. |

## 2. `clients` Table

Stores information about the clients (companies) who receive promo cards.

| Column Name | Data Type | Constraints | Description |
|---|---|---|---|
| `id` | `INTEGER` | **Primary Key** | Unique identifier for the client. |
| `unp` | `VARCHAR(9)` | **Unique**, **Not Null** | Client's taxpayer identification number. |
| `company_name` | `VARCHAR(255)` | **Not Null** | Client's company name. |
| `created_at` | `TIMESTAMP` | **Not Null**, Default: `NOW()` | Timestamp of client creation. |

## 3. `products` Table

Stores the products for which promo cards can be issued.

| Column Name | Data Type | Constraints | Description |
|---|---|---|---|
| `id` | `INTEGER` | **Primary Key** | Unique identifier for the product. |
| `name` | `VARCHAR(255)` | **Unique**, **Not Null** | Name of the product. |
| `default_discount_id` | `INTEGER` | Foreign Key (`discounts.id`) | Default discount for this product. |
| `created_at` | `TIMESTAMP` | **Not Null**, Default: `NOW()` | Timestamp of product creation. |

## 4. `discounts` Table

Stores different types of discounts.

| Column Name | Data Type | Constraints | Description |
|---|---|---|---|
| `id` | `INTEGER` | **Primary Key** | Unique identifier for the discount. |
| `name` | `VARCHAR(255)` | **Not Null** | Name of the discount (e.g., "10% off"). |
| `percentage` | `DECIMAL(5, 2)` | **Not Null** | Discount percentage. |
| `type` | `VARCHAR(50)` | **Not Null** | Type of discount (`promo`, `service_center`). |
| `duration_months` | `INTEGER` | | Duration of the discount in months (for service center discounts). |
| `created_at` | `TIMESTAMP` | **Not Null**, Default: `NOW()` | Timestamp of discount creation. |

## 5. `promo_cards` Table

The core table of the application, storing the promo cards.

| Column Name | Data Type | Constraints | Description |
|---|---|---|---|
| `id` | `INTEGER` | **Primary Key** | Unique identifier for the promo card. |
| `qr_serial` | `VARCHAR(255)` | **Unique**, **Not Null** | Unique serial number from the QR code. |
| `status` | `VARCHAR(50)` | **Not Null**, Default: `'valid'` | Status of the card (`valid`, `redeemed`, `expired`). |
| `client_id` | `INTEGER` | **Not Null**, Foreign Key (`clients.id`) | The client who received the card. |
| `product_id` | `INTEGER` | **Not Null**, Foreign Key (`products.id`) | The product for which the card is valid. |
| `discount_id` | `INTEGER` | **Not Null**, Foreign Key (`discounts.id`) | The discount applied to this card. |
| `issued_by_user_id` | `INTEGER` | **Not Null**, Foreign Key (`users.id`) | The sales manager who issued the card. |
| `valid_from` | `DATE` | **Not Null** | The date from which the card is valid. |
| `valid_until` | `DATE` | **Not Null** | The date until which the card is valid. |
| `redeemed_at` | `TIMESTAMP` | | Timestamp of when the card was redeemed. |
| `service_center_discount_until` | `DATE` | | The date until which the service center discount is valid for the original client. |
| `created_at` | `TIMESTAMP` | **Not Null**, Default: `NOW()` | Timestamp of card creation. |

## 6. `audit_logs` Table

Stores a log of all important user actions.

| Column Name | Data Type | Constraints | Description |
|---|---|---|---|
| `id` | `INTEGER` | **Primary Key** | Unique identifier for the log entry. |
| `user_id` | `INTEGER` | Foreign Key (`users.id`) | The user who performed the action. |
| `action` | `VARCHAR(255)` | **Not Null** | The action performed (e.g., `login`, `create_card`, `redeem_card`). |
| `details` | `JSONB` | | Additional details about the action. |
| `created_at` | `TIMESTAMP` | **Not Null**, Default: `NOW()` | Timestamp of the action. |

## Entity-Relationship Diagram (ERD)

```
+-------------+       +-------------+       +-------------+
|    users    |       | promo_cards |       |   clients   |
+-------------+       +-------------+       +-------------+
| id (PK)     |-------| issued_by_user_id (FK) | id (PK)     |
| username    |       | client_id (FK)  |-------| unp         |
| ...         |       | product_id (FK) |       | company_name|
+-------------+       | discount_id (FK)|       | ...         |
                      | ...             |       +-------------+
                      +-------------+
                             |
                             |
                      +-------------+
                      |  products   |
                      +-------------+
                      | id (PK)     |
                      | name        |
                      | ...         |
                      +-------------+
                             |
                             |
                      +-------------+
                      |  discounts  |
                      +-------------+
                      | id (PK)     |
                      | name        |
| ...         |
                      +-------------+
```

## Русский перевод

# Модель данных: Веб-приложение PromoLink

Этот документ определяет схему базы данных для приложения PromoLink на основе сущностей, определенных в спецификации.

## 1. Таблица `users`

Хранит учетные записи пользователей и их роли.

| Имя столбца | Тип данных | Ограничения | Описание |
|---|---|---|---|
| `id` | `INTEGER` | **Первичный ключ** | Уникальный идентификатор пользователя. |
| `username` | `VARCHAR(255)` | **Уникальный**, **Не NULL** | Имя пользователя для входа. |
| `hashed_password` | `VARCHAR(255)` | **Не NULL** | Хешированный пароль. |
| `role` | `VARCHAR(50)` | **Не NULL** | Роль пользователя (`admin`, `sales`, `cto`). |
| `created_at` | `TIMESTAMP` | **Не NULL**, По умолчанию: `NOW()` | Отметка времени создания пользователя. |

## 2. Таблица `clients`

Хранит информацию о клиентах (компаниях), которые получают промо-карты.

| Имя столбца | Тип данных | Ограничения | Описание |
|---|---|---|---|
| `id` | `INTEGER` | **Первичный ключ** | Уникальный идентификатор клиента. |
| `unp` | `VARCHAR(9)` | **Уникальный**, **Не NULL** | УНП клиента. |
| `company_name` | `VARCHAR(255)` | **Не NULL** | Название компании клиента. |
| `created_at` | `TIMESTAMP` | **Не NULL**, По умолчанию: `NOW()` | Отметка времени создания клиента. |

## 3. Таблица `products`

Хранит продукты, для которых могут быть выпущены промо-карты.

| Имя столбца | Тип данных | Ограничения | Описание |
|---|---|---|---|
| `id` | `INTEGER` | **Первичный ключ** | Уникальный идентификатор продукта. |
| `name` | `VARCHAR(255)` | **Уникальный**, **Не NULL** | Название продукта. |
| `default_discount_id` | `INTEGER` | Внешний ключ (`discounts.id`) | Скидка по умолчанию для этого продукта. |
| `created_at` | `TIMESTAMP` | **Не NULL**, По умолчанию: `NOW()` | Отметка времени создания продукта. |

## 4. Таблица `discounts`

Хранит различные типы скидок.

| Имя столбца | Тип данных | Ограничения | Описание |
|---|---|---|---|
| `id` | `INTEGER` | **Первичный ключ** | Уникальный идентификатор скидки. |
| `name` | `VARCHAR(255)` | **Не NULL** | Название скидки (например, "10% скидка"). |
| `percentage` | `DECIMAL(5, 2)` | **Не NULL** | Процент скидки. |
| `type` | `VARCHAR(50)` | **Не NULL** | Тип скидки (`promo`, `service_center`). |
| `duration_months` | `INTEGER` | | Продолжительность скидки в месяцах (для скидок сервисного центра). |
| `created_at` | `TIMESTAMP` | **Не NULL**, По умолчанию: `NOW()` | Отметка времени создания скидки. |

## 5. Таблица `promo_cards`

Основная таблица приложения, хранящая промо-карты.

| Имя столбца | Тип данных | Ограничения | Описание |
|---|---|---|---|
| `id` | `INTEGER` | **Первичный ключ** | Уникальный идентификатор промо-карты. |
| `qr_serial` | `VARCHAR(255)` | **Уникальный**, **Не NULL** | Уникальный серийный номер из QR-кода. |
| `status` | `VARCHAR(50)` | **Не NULL**, По умолчанию: `'valid'` | Статус карты (`valid`, `redeemed`, `expired`). |
| `client_id` | `INTEGER` | **Не NULL**, Внешний ключ (`clients.id`) | Клиент, получивший карту. |
| `product_id` | `INTEGER` | **Не NULL**, Внешний ключ (`products.id`) | Продукт, для которого действительна карта. |
| `discount_id` | `INTEGER` | **Не NULL**, Внешний ключ (`discounts.id`) | Примененная к этой карте скидка. |
| `issued_by_user_id` | `INTEGER` | **Не NULL**, Внешний ключ (`users.id`) | Менеджер по продажам, выдавший карту. |
| `valid_from` | `DATE` | **Не NULL** | Дата начала действия карты. |
| `valid_until` | `DATE` | **Не NULL** | Дата окончания действия карты. |
| `redeemed_at` | `TIMESTAMP` | | Отметка времени погашения карты. |
| `service_center_discount_until` | `DATE` | | Дата окончания действия скидки сервисного центра для первоначального клиента. |
| `created_at` | `TIMESTAMP` | **Не NULL**, По умолчанию: `NOW()` | Отметка времени создания карты. |

## 6. Таблица `audit_logs`

Хранит журнал всех важных действий пользователя.

| Имя столбца | Тип данных | Ограничения | Описание |
|---|---|---|---|
| `id` | `INTEGER` | **Первичный ключ** | Уникальный идентификатор записи журнала. |
| `user_id` | `INTEGER` | Внешний ключ (`users.id`) | Пользователь, выполнивший действие. |
| `action` | `VARCHAR(255)` | **Не NULL** | Выполненное действие (например, `login`, `create_card`, `redeem_card`). |
| `details` | `JSONB` | | Дополнительные сведения о действии. |
| `created_at` | `TIMESTAMP` | **Не NULL**, По умолчанию: `NOW()` | Отметка времени действия. |

## Диаграмма сущность-связь (ERD)

```
+-------------+       +-------------+       +-------------+
|    users    |       | promo_cards |       |   clients   |
+-------------+       +-------------+       +-------------+
| id (PK)     |-------| issued_by_user_id (FK) | id (PK)     |
| username    |       | client_id (FK)  |-------| unp         |
| ...         |       | product_id (FK) |       | company_name|
+-------------+       | discount_id (FK)|       | ...         |
                      | ...             |       +-------------+
                      +-------------+
                             |
                             |
                      +-------------+
                      |  products   |
                      +-------------+
                      | id (PK)     |
                      | name        |
                      | ...         |
                      +-------------+
                             |
                             |
                      +-------------+
                      |  discounts  |
                      +-------------+
                      | id (PK)     |
                      | name        |
| ...         |
                      +-------------+
```
