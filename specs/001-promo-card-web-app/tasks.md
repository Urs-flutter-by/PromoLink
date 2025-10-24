# Tasks: PromoLink Web Application

## Phase 1: Setup

### Goal
Initialize the project structure, version control, and basic Docker Compose configuration to enable local development.

### Tasks
- [X] T001 Create `backend/` and `frontend/` directories per implementation plan
- [X] T002 Initialize Git repository and make initial commit
- [X] T003 Configure `docker-compose.yml` for `backend`, `frontend`, and `postgres` services
- [X] T004 Create initial `.env` file with placeholder variables for `SECRET_KEY`, `DATABASE_URL`, `API_UNP_URL`, `POSTGRES_USER`, `POSTGRES_PASSWORD`, `POSTGRES_DB`
- [X] T005 Create `backend/main.py` for FastAPI application entry point
- [X] T006 Create `frontend/lib/main.dart` for Flutter application entry point

## Phase 2: Foundational

### Goal
Implement core infrastructure components including database connection, user authentication, and role-based access control, which are prerequisites for all user stories.

### Tasks
- [X] T007 Implement database connection and session management in `backend/app/db/database.py`
- [X] T008 Create SQLAlchemy models for `User`, `Client`, `Product`, `Discount`, `PromoCard`, `AuditLog` in `backend/app/models/`
- [X] T009 Implement Pydantic schemas for `User`, `Client`, `Product`, `Discount`, `PromoCard` (base, create, update) in `backend/app/schemas/`
- [X] T010 Implement user authentication logic (password hashing, JWT token generation) in `backend/app/core/security.py`
- [X] T011 Implement FastAPI endpoint for user login (`/token`) in `backend/app/api/v1/endpoints/auth.py`
- [X] T012 Implement dependency for JWT token validation and current user retrieval in `backend/app/api/deps.py`
- [X] T013 Implement role-based access control (RBAC) utility functions/decorators in `backend/app/core/rbac.py`
- [X] T014 Implement FastAPI endpoint to get current user (`/users/me`) in `backend/app/api/v1/endpoints/users.py`

## Phase 3: User Story 1 - Guest - View Promo Card Details (P1)

### Goal
Allow unauthenticated users to scan a QR code and view promo card status and details.

### Independent Test Criteria
- A valid QR code displays correct card information (status, sender, product, discount, expiry, ad text).
- An invalid/expired/redeemed QR code displays appropriate status and message.

### Tasks
- [X] T015 [US1] Implement FastAPI endpoint to retrieve PromoCard by QR serial (`/promo-cards/{qr_serial}`) in `backend/app/api/v1/endpoints/promo_cards.py`
- [X] T016 [US1] Implement Flutter screen for public QR scan and display in `frontend/lib/screens/public_promo_card_view.dart`
- [X] T017 [US1] Implement Flutter service to call backend API for promo card details in `frontend/lib/api/promo_card_api.dart`

## Phase 4: User Story 2 - Sales Manager - Link Promo Card (P2)

### Goal
Enable sales managers to link new promo cards to clients, including UNP lookup and data persistence.

### Independent Test Criteria
- Sales manager can successfully link a new card with valid client UNP, dates, product, and QR scan.
- Invalid UNP prevents card saving and displays an error message.

### Tasks
- [X] T018 [US2] Implement external UNP API integration service in `backend/app/services/unp_api.py`
- [X] T019 [US2] Implement FastAPI endpoint to create PromoCard (`/promo-cards`) in `backend/app/api/v1/endpoints/promo_cards.py`
- [X] T020 [US2] Implement Flutter screen for sales manager to input client UNP, dates, product, and scan QR in `frontend/lib/screens/sales_link_promo_card.dart`
- [X] T021 [US2] Implement Flutter service to call backend API for UNP lookup and promo card creation in `frontend/lib/api/sales_api.dart`

## Phase 5: User Story 3 - Sales Manager - Redeem Card (P2)

### Goal
Allow sales managers to mark a promo card as redeemed and optionally adjust its validity period.

### Independent Test Criteria
- Sales manager can successfully redeem an active promo card and update its status in the DB.
- Attempting to redeem an already redeemed card displays an appropriate message.

### Tasks
- [X] T022 [US3] Implement FastAPI endpoint to redeem PromoCard (`/promo-cards/{qr_serial}/redeem`) in `backend/app/api/v1/endpoints/promo_cards.py`
- [X] T023 [US3] Implement Flutter screen for sales manager to scan and redeem card in `frontend/lib/screens/sales_redeem_promo_card.dart`

## Phase 6: User Story 4 - Sales Manager - List Issued Cards (P3)

### Goal
Provide sales managers with a searchable and filterable list of all issued promo cards.

### Independent Test Criteria
- The list displays all issued cards with correct data.
- Search and filter functionalities work as expected.

### Tasks
- [X] T024 [US4] Implement FastAPI endpoint to list PromoCards with search/filter (`/promo-cards`) in `backend/app/api/v1/endpoints/promo_cards.py`
- [X] T025 [US4] Implement Flutter screen to display list of PromoCards with search/filter in `frontend/lib/screens/sales_list_promo_cards.dart`

## Phase 7: User Story 5 - Sales Manager - Manage Constants (P3)

### Goal
Enable sales managers to manage promotional constants such as products and discounts.

### Independent Test Criteria
- Sales manager can successfully perform CRUD operations on products and discounts.

### Tasks
- [X] T026 [US5] Implement FastAPI CRUD endpoints for Products (`/products`) in `backend/app/api/v1/endpoints/products.py`
- [X] T027 [US5] Implement FastAPI CRUD endpoints for Discounts (`/discounts`) in `backend/app/api/v1/endpoints/discounts.py`
- [X] T028 [US5] Implement Flutter screens for sales manager to manage products and discounts in `frontend/lib/screens/sales_manage_constants.dart`

## Phase 8: User Story 6 - Service Center Manager - List Issued Cards & Manage Discounts (P3)

### Goal
Allow service center managers to view issued cards and set service-specific discounts for original card recipients.

### Independent Test Criteria
- Service center manager can view the list of issued cards.
- Service center manager can successfully set a service discount period for a card.

### Tasks
- [X] T029 [US6] Implement FastAPI endpoint to set service center discount (`/promo-cards/{qr_serial}/service-discount`) in `backend/app/api/v1/endpoints/promo_cards.py`
- [X] T030 [US6] Implement Flutter screen for service center manager to view cards and manage discounts in `frontend/lib/screens/cto_manage_discounts.dart`

## Final Phase: Polish & Cross-Cutting Concerns

### Goal
Ensure the application is robust, well-tested, and ready for deployment, addressing non-functional requirements.

### Tasks
- [X] T031 Implement comprehensive logging and error handling across backend and frontend
- [X] T032 Implement CI/CD pipeline configuration for automated testing and deployment
- [X] T033 Write comprehensive unit and integration tests for all backend services and endpoints
- [X] T034 Write comprehensive unit and widget tests for all frontend components and screens
- [X] T035 Deploy to staging environment and perform end-to-end testing
- [X] T036 Implement audit logging for all critical user actions in `backend/app/services/audit_log.py`

## Dependencies

- Phase 1 must be completed before Phase 2.
- Phase 2 must be completed before any User Story phase.
- User Story phases can be implemented in parallel where dependencies allow, but generally follow priority order.

## Parallel Execution Examples

- **User Story 1 (Guest View)**: Backend endpoint (T015) and Frontend UI (T016, T017) can be developed in parallel after Foundational Phase.
- **User Story 2 (Sales Link)**: Backend UNP integration (T018) and PromoCard creation endpoint (T019) can be developed in parallel with Frontend UI (T020, T021).

## Implementation Strategy

Adopt an MVP-first approach, focusing on delivering User Story 1 (Guest - View Promo Card Details) as the initial functional increment. Subsequent user stories will be implemented incrementally, prioritizing P2 stories before P3 stories. Each user story will be developed with its corresponding backend API, frontend UI, and tests, ensuring independent testability and continuous integration. Cross-cutting concerns like comprehensive logging, CI/CD, and full test coverage will be addressed in the Final Phase.

## Русский перевод

# Задачи: Веб-приложение PromoLink

## Фаза 1: Настройка

### Цель
Инициализация структуры проекта, системы контроля версий и базовой конфигурации Docker Compose для обеспечения локальной разработки.

### Задачи
- [ ] T001 Создать каталоги `backend/` и `frontend/` согласно плану реализации
- [ ] T002 Инициализировать репозиторий Git и сделать первоначальный коммит
- [ ] T003 Настроить `docker-compose.yml` для сервисов `backend`, `frontend` и `postgres`
- [ ] T004 Создать первоначальный файл `.env` с переменными-заполнителями для `SECRET_KEY`, `DATABASE_URL`, `API_UNP_URL`, `POSTGRES_USER`, `POSTGRES_PASSWORD`, `POSTGRES_DB`
- [ ] T005 Создать `backend/main.py` для точки входа приложения FastAPI
- [ ] T006 Создать `frontend/lib/main.dart` для точки входа приложения Flutter

## Фаза 2: Основополагающая

### Цель
Реализовать основные компоненты инфраструктуры, включая подключение к базе данных, аутентификацию пользователей и контроль доступа на основе ролей, которые являются предварительными условиями для всех пользовательских историй.

### Задачи
- [ ] T007 Реализовать подключение к базе данных и управление сессиями в `backend/app/db/database.py`
- [ ] T008 Создать модели SQLAlchemy для `User`, `Client`, `Product`, `Discount`, `PromoCard`, `AuditLog` в `backend/app/models/`
- [ ] T009 Реализовать схемы Pydantic для `User`, `Client`, `Product`, `Discount`, `PromoCard` (базовая, создание, обновление) в `backend/app/schemas/`
- [ ] T010 Реализовать логику аутентификации пользователей (хеширование паролей, генерация токенов JWT) в `backend/app/core/security.py`
- [ ] T011 Реализовать конечную точку FastAPI для входа пользователя (`/token`) в `backend/app/api/v1/endpoints/auth.py`
- [ ] T012 Реализовать зависимость для проверки токена JWT и получения текущего пользователя в `backend/app/api/deps.py`
- [ ] T013 Реализовать вспомогательные функции/декораторы контроля доступа на основе ролей (RBAC) в `backend/app/core/rbac.py`
- [ ] T014 Реализовать конечную точку FastAPI для получения текущего пользователя (`/users/me`) в `backend/app/api/v1/endpoints/users.py`

## Фаза 3: Пользовательская история 1 - Гость - Просмотр сведений о промо-карте (P1)

### Цель
Разрешить неаутентифицированным пользователям сканировать QR-код и просматривать статус и сведения о промо-карте.

### Критерии независимого тестирования
- Действительный QR-код отображает правильную информацию о карте (статус, отправитель, продукт, скидка, срок действия, рекламный текст).
- Недействительный/истекший/погашенный QR-код отображает соответствующий статус и сообщение.

### Задачи
- [ ] T015 [US1] Реализовать конечную точку FastAPI для получения PromoCard по QR-серийному номеру (`/promo-cards/{qr_serial}`) в `backend/app/api/v1/endpoints/promo_cards.py`
- [ ] T016 [US1] Реализовать экран Flutter для публичного сканирования QR и отображения в `frontend/lib/screens/public_promo_card_view.dart`
- [ ] T017 [US1] Реализовать сервис Flutter для вызова бэкенд API для получения сведений о промо-карте в `frontend/lib/api/promo_card_api.dart`

## Фаза 4: Пользовательская история 2 - Менеджер по продажам - Привязка промо-карты (P2)

### Цель
Предоставить менеджерам по продажам возможность привязывать новые промо-карты к клиентам, включая поиск УНП и сохранение данных.

### Критерии независимого тестирования
- Менеджер по продажам может успешно привязать новую карту с действительным УНП клиента, датами, продуктом и сканированием QR.
- Недействительный УНП предотвращает сохранение карты и отображает сообщение об ошибке.

### Задачи
- [ ] T018 [US2] Реализовать сервис интеграции с внешним API УНП в `backend/app/services/unp_api.py`
- [ ] T019 [US2] Реализовать конечную точку FastAPI для создания PromoCard (`/promo-cards`) в `backend/app/api/v1/endpoints/promo_cards.py`
- [ ] T020 [US2] Реализовать экран Flutter для менеджера по продажам для ввода УНП клиента, дат, продукта и сканирования QR в `frontend/lib/screens/sales_link_promo_card.dart`
- [ ] T021 [US2] Реализовать сервис Flutter для вызова бэкенд API для поиска УНП и создания промо-карты в `frontend/lib/api/sales_api.dart`

## Фаза 5: Пользовательская история 3 - Менеджер по продажам - Погашение карты (P2)

### Цель
Разрешить менеджерам по продажам отмечать промо-карту как погашенную и при необходимости корректировать срок ее действия.

### Критерии независимого тестирования
- Менеджер по продажам может успешно погасить активную промо-карту и обновить ее статус в БД.
- Попытка погасить уже погашенную карту отображает соответствующее сообщение.

### Задачи
- [ ] T022 [US3] Реализовать конечную точку FastAPI для погашения PromoCard (`/promo-cards/{qr_serial}/redeem`) в `backend/app/api/v1/endpoints/promo_cards.py`
- [ ] T023 [US3] Реализовать экран Flutter для менеджера по продажам для сканирования и погашения карты в `frontend/lib/screens/sales_redeem_promo_card.dart`

## Фаза 6: Пользовательская история 4 - Менеджер по продажам - Список выданных карт (P3)

### Цель
Предоставить менеджерам по продажам список всех выданных промо-карт с возможностью поиска и фильтрации.

### Критерии независимого тестирования
- Список отображает все выданные карты с правильными данными.
- Функции поиска и фильтрации работают должным образом.

### Задачи
- [ ] T024 [US4] Реализовать конечную точку FastAPI для получения списка PromoCards с поиском/фильтрацией (`/promo-cards`) в `backend/app/api/v1/endpoints/promo_cards.py`
- [ ] T025 [US4] Реализовать экран Flutter для отображения списка PromoCards с поиском/фильтрацией в `frontend/lib/screens/sales_list_promo_cards.dart`

## Фаза 7: Пользовательская история 5 - Менеджер по продажам - Управление константами (P3)

### Цель
Предоставить менеджерам по продажам возможность управлять рекламными константами, такими как продукты и скидки.

### Критерии независимого тестирования
- Менеджер по продажам может успешно выполнять операции CRUD с продуктами и скидками.

### Задачи
- [ ] T026 [US5] Реализовать конечные точки FastAPI CRUD для продуктов (`/products`) в `backend/app/api/v1/endpoints/products.py`
- [ ] T027 [US5] Реализовать конечные точки FastAPI CRUD для скидок (`/discounts`) в `backend/app/api/v1/endpoints/discounts.py`
- [ ] T028 [US5] Реализовать экраны Flutter для менеджера по продажам для управления продуктами и скидками в `frontend/lib/screens/sales_manage_constants.dart`

## Фаза 8: Пользовательская история 6 - Менеджер сервисного центра - Список выданных карт и управление скидками (P3)

### Цель
Разрешить менеджерам сервисного центра просматривать выданные карты и устанавливать скидки, специфичные для сервиса, для первоначальных получателей карт.

### Критерии независимого тестирования
- Менеджер сервисного центра может просматривать список выданных карт.
- Менеджер сервисного центра может успешно установить период скидки сервисного центра для карты.

### Задачи
- [ ] T029 [US6] Реализовать конечную точку FastAPI для установки скидки сервисного центра (`/promo-cards/{qr_serial}/service-discount`) в `backend/app/api/v1/endpoints/promo_cards.py`
- [ ] T030 [US6] Реализовать экран Flutter для менеджера сервисного центра для просмотра карт и управления скидками в `frontend/lib/screens/cto_manage_discounts.dart`

## Заключительная фаза: Полировка и сквозные проблемы

### Цель
Обеспечить надежность, тщательное тестирование и готовность приложения к развертыванию, удовлетворяя нефункциональным требованиям.

### Задачи
- [ ] T031 Реализовать комплексное ведение журнала и обработку ошибок на бэкенде и фронтенде
- [ ] T032 Реализовать конфигурацию конвейера CI/CD для автоматизированного тестирования и развертывания
- [ ] T033 Написать комплексные модульные и интеграционные тесты для всех сервисов и конечных точек бэкенда
- [ ] T034 Написать комплексные модульные и виджет-тесты для всех компонентов и экранов фронтенда
- [ ] T035 Развернуть в промежуточной среде и выполнить сквозное тестирование
- [ ] T036 Реализовать аудит-логирование для всех критических действий пользователя в `backend/app/services/audit_log.py`

## Зависимости

- Фаза 1 должна быть завершена до Фазы 2.
- Фаза 2 должна быть завершена до любой фазы пользовательской истории.
- Фазы пользовательских историй могут быть реализованы параллельно, если это позволяют зависимости, но обычно следуют порядку приоритета.

## Примеры параллельного выполнения

- **Пользовательская история 1 (Просмотр гостем)**: Конечная точка бэкенда (T015) и пользовательский интерфейс фронтенда (T016, T017) могут разрабатываться параллельно после основополагающей фазы.
- **Пользовательская история 2 (Привязка менеджером по продажам)**: Интеграция бэкенда с УНП (T018) и конечная точка создания PromoCard (T019) могут разрабатываться параллельно с пользовательским интерфейсом фронтенда (T020, T021).

## Стратегия реализации

Принять подход "MVP в первую очередь", сосредоточившись на предоставлении Пользовательской истории 1 (Гость - Просмотр сведений о промо-карте) в качестве первоначального функционального приращения. Последующие пользовательские истории будут реализованы инкрементально, отдавая приоритет историям P2 перед историями P3. Каждая пользовательская история будет разрабатываться с соответствующим бэкенд API, пользовательским интерфейсом фронтенда и тестами, обеспечивая независимую тестируемость и непрерывную интеграцию. Сквозные проблемы, такие как комплексное ведение журнала, CI/CD и полное тестовое покрытие, будут решены на заключительной фазе.
