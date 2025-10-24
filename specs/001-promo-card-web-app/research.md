# Research Document: PromoLink Web Application

## Phase 0: Outline & Research

This document outlines the research findings for the technical dependencies and integrations for the PromoLink web application.

### 1. Backend Dependencies Best Practices (FastAPI, SQLAlchemy, Pydantic)

- **FastAPI**:
    - **Project Structure**: Use a modular structure with `routers` for endpoints, `crud` for database operations, `schemas` for Pydantic models, and `models` for SQLAlchemy models. This is reflected in the chosen project structure.
    - **Dependencies**: Use FastAPI's dependency injection system for managing database sessions and authentication.
    - **Async**: Use `async def` for all endpoints to leverage FastAPI's asynchronous capabilities.
    - **Error Handling**: Implement custom exception handlers for handling application-specific errors.
- **SQLAlchemy**:
    - **Session Management**: Use a middleware or a dependency to manage the lifecycle of database sessions (`SessionLocal`).
    - **Alembic**: Use Alembic for database migrations to manage schema changes.
    - **Asynchronous Operations**: Use `AsyncSession` and `create_async_engine` for non-blocking database operations.
- **Pydantic**:
    - **Data Validation**: Use Pydantic schemas for request and response data validation and serialization.
    - **Settings Management**: Use Pydantic's `BaseSettings` for managing application settings from environment variables.

### 2. Frontend Dependencies Best Practices (Flutter, Riverpod, Dio)

- **Flutter**:
    - **Project Structure**: Organize the project by feature, with each feature having its own `screens`, `widgets`, and `providers`.
    - **Routing**: Use a routing package like `go_router` for declarative routing.
    - **Styling**: Maintain a consistent theme and style guide.
- **Riverpod**:
    - **State Management**: Use Riverpod for state management. Prefer `FutureProvider` and `StreamProvider` for handling asynchronous data.
    - **Provider Scope**: Use provider scopes to manage the lifecycle of state.
- **Dio**:
    - **API Client**: Create a dedicated API client class that encapsulates Dio's functionality.
    - **Interceptors**: Use interceptors for logging, error handling, and adding authentication tokens to requests.

### 3. Integration Patterns (External UNP API)

- **API Client**: Create a dedicated service in the backend to interact with the `https://grp.nalog.gov.by/grp/rest-api`.
- **Error Handling**: Implement robust error handling for API downtime, timeouts, and invalid responses.
- **Caching**: Consider caching the responses from the UNP API to reduce latency and reliance on the external service. A time-to-live (TTL) of 24 hours for each UNP seems reasonable.
- **Data Mapping**: Create Pydantic schemas to validate and map the data received from the external API to the application's data model.

### 4. Security Best Practices (JWT, passlib)

- **JWT**:
    - **Token Generation**: Generate JWTs upon successful login with user ID and role in the payload.
    - **Token Expiration**: Set a reasonable expiration time for tokens (e.g., 15 minutes for access tokens, 7 days for refresh tokens).
    - **Token Validation**: Use a dependency to validate the token on protected endpoints.
- **passlib**:
    - **Password Hashing**: Use `passlib.context.CryptContext` to hash and verify passwords with bcrypt.

### 5. Infrastructure Best Practices (Docker, Nginx)

- **Docker**:
    - **Multi-stage builds**: Use multi-stage builds for creating smaller and more secure Docker images.
    - **Docker Compose**: Use Docker Compose for local development to orchestrate the `backend`, `frontend`, and `postgres` services.
- **Nginx**:
    - **Reverse Proxy**: Use Nginx as a reverse proxy in production to serve the frontend and proxy requests to the backend.
    - **HTTPS**: Configure Nginx to handle HTTPS traffic and terminate SSL.

## Русский перевод

# Документ исследования: Веб-приложение PromoLink

## Фаза 0: Обзор и исследование

Этот документ описывает результаты исследования технических зависимостей и интеграций для веб-приложения PromoLink.

### 1. Лучшие практики для зависимостей бэкенда (FastAPI, SQLAlchemy, Pydantic)

- **FastAPI**:
    - **Структура проекта**: Используйте модульную структуру с `routers` для конечных точек, `crud` для операций с базой данных, `schemas` для моделей Pydantic и `models` для моделей SQLAlchemy. Это отражено в выбранной структуре проекта.
    - **Зависимости**: Используйте систему внедрения зависимостей FastAPI для управления сессиями базы данных и аутентификацией.
    - **Асинхронность**: Используйте `async def` для всех конечных точек, чтобы использовать асинхронные возможности FastAPI.
    - **Обработка ошибок**: Реализуйте пользовательские обработчики исключений для обработки ошибок, специфичных для приложения.
- **SQLAlchemy**:
    - **Управление сессиями**: Используйте промежуточное ПО или зависимость для управления жизненным циклом сессий базы данных (`SessionLocal`).
    - **Alembic**: Используйте Alembic для миграций базы данных для управления изменениями схемы.
    - **Асинхронные операции**: Используйте `AsyncSession` и `create_async_engine` для неблокирующих операций с базой данных.
- **Pydantic**:
    - **Проверка данных**: Используйте схемы Pydantic для проверки и сериализации данных запросов и ответов.
    - **Управление настройками**: Используйте `BaseSettings` Pydantic для управления настройками приложения из переменных окружения.

### 2. Лучшие практики для зависимостей фронтенда (Flutter, Riverpod, Dio)

- **Flutter**:
    - **Структура проекта**: Организуйте проект по функциям, при этом каждая функция имеет свои `screens`, `widgets` и `providers`.
    - **Маршрутизация**: Используйте пакет маршрутизации, такой как `go_router`, для декларативной маршрутизации.
    - **Стилизация**: Поддерживайте согласованную тему и руководство по стилю.
- **Riverpod**:
    - **Управление состоянием**: Используйте Riverpod для управления состоянием. Предпочитайте `FutureProvider` и `StreamProvider` для обработки асинхронных данных.
    - **Область действия провайдера**: Используйте области действия провайдера для управления жизненным циклом состояния.
- **Dio**:
    - **API-клиент**: Создайте выделенный класс API-клиента, который инкапсулирует функциональность Dio.
    - **Перехватчики**: Используйте перехватчики для ведения журнала, обработки ошибок и добавления токенов аутентификации к запросам.

### 3. Шаблоны интеграции (Внешний API УНП)

- **API-клиент**: Создайте выделенный сервис на бэкенде для взаимодействия с `https://grp.nalog.gov.by/grp/rest-api`.
- **Обработка ошибок**: Реализуйте надежную обработку ошибок для простоя API, тайм-аутов и неверных ответов.
- **Кэширование**: Рассмотрите возможность кэширования ответов от API УНП, чтобы уменьшить задержку и зависимость от внешнего сервиса. Время жизни (TTL) в 24 часа для каждого УНП кажется разумным.
- **Сопоставление данных**: Создайте схемы Pydantic для проверки и сопоставления данных, полученных от внешнего API, с моделью данных приложения.

### 4. Лучшие практики безопасности (JWT, passlib)

- **JWT**:
    - **Генерация токенов**: Генерируйте JWT при успешном входе в систему с идентификатором пользователя и ролью в полезной нагрузке.
    - **Срок действия токена**: Установите разумное время истечения срока действия токенов (например, 15 минут для токенов доступа, 7 дней для токенов обновления).
    - **Проверка токена**: Используйте зависимость для проверки токена на защищенных конечных точках.
- **passlib**:
    - **Хеширование паролей**: Используйте `passlib.context.CryptContext` для хеширования и проверки паролей с помощью bcrypt.

### 5. Лучшие практики инфраструктуры (Docker, Nginx)

- **Docker**:
    - **Многоступенчатые сборки**: Используйте многоступенчатые сборки для создания меньших и более безопасных образов Docker.
    - **Docker Compose**: Используйте Docker Compose для локальной разработки для оркестровки сервисов `backend`, `frontend` и `postgres`.
- **Nginx**:
    - **Обратный прокси**: Используйте Nginx в качестве обратного прокси в продакшене для обслуживания фронтенда и проксирования запросов к бэкенду.
    - **HTTPS**: Настройте Nginx для обработки трафика HTTPS и завершения SSL.
