# Quickstart: PromoLink Web Application

This guide provides the basic steps to get the PromoLink application running locally for development.

## Prerequisites

- Docker and Docker Compose
- A modern web browser

## Running the Application

1.  **Clone the repository**:
    ```bash
    git clone <repository-url>
    cd PromoLink
    ```

2.  **Create the `.env` file**:
    Create a `.env` file in the root of the project and add the following environment variables:

    ```env
    # Backend settings
    SECRET_KEY=your-secret-key
    DATABASE_URL=postgresql://user:password@postgres:5432/promolink
    API_UNP_URL=https://grp.nalog.gov.by/grp/rest-api

    # PostgreSQL settings
    POSTGRES_USER=user
    POSTGRES_PASSWORD=password
    POSTGRES_DB=promolink
    ```

3.  **Build and run the application with Docker Compose**:
    ```bash
    docker-compose up --build
    ```

4.  **Access the application**:
    -   The frontend will be available at `http://localhost:8080`.
    -   The backend API will be available at `http://localhost:8000`.
    -   The API documentation (Swagger UI) will be at `http://localhost:8000/docs`.

## Running Tests

-   **Backend tests**:
    ```bash
    docker-compose exec backend pytest
    ```

-   **Frontend tests**:
    ```bash
    docker-compose exec frontend flutter test
    ```

## Русский перевод

# Быстрый старт: Веб-приложение PromoLink

Это руководство содержит основные шаги для запуска приложения PromoLink локально для разработки.

## Предварительные требования

- Docker и Docker Compose
- Современный веб-браузер

## Запуск приложения

1.  **Клонировать репозиторий**:
    ```bash
    git clone <repository-url>
    cd PromoLink
    ```

2.  **Создать файл `.env`**:
    Создайте файл `.env` в корне проекта и добавьте следующие переменные окружения:

    ```env
    # Настройки бэкенда
    SECRET_KEY=ваш-секретный-ключ
    DATABASE_URL=postgresql://user:password@postgres:5432/promolink
    API_UNP_URL=https://grp.nalog.gov.by/grp/rest-api

    # Настройки PostgreSQL
    POSTGRES_USER=user
    POSTGRES_PASSWORD=password
    POSTGRES_DB=promolink
    ```

3.  **Собрать и запустить приложение с помощью Docker Compose**:
    ```bash
    docker-compose up --build
    ```

4.  **Доступ к приложению**:
    -   Фронтенд будет доступен по адресу `http://localhost:8080`.
    -   Бэкенд API будет доступен по адресу `http://localhost:8000`.
    -   Документация API (Swagger UI) будет доступна по адресу `http://localhost:8000/docs`.

## Запуск тестов

-   **Тесты бэкенда**:
    ```bash
    docker-compose exec backend pytest
    ```

-   **Тесты фронтенда**:
    ```bash
    docker-compose exec frontend flutter test
    ```
