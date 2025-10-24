# Implementation Plan: PromoLink Web Application

**Branch**: `001-promo-card-web-app` | **Date**: 2025-10-24 | **Spec**: [C:\Users\korotkevich\AI\PromoLink\specs\001-promo-card-web-app\spec.md]
**Input**: Feature specification from `/specs/001-promo-card-web-app/spec.md`

**Note**: This template is filled in by the `/speckit.plan` command. See `.specify/templates/commands/plan.md` for the execution workflow.

## Summary

This plan outlines the implementation of a B2B web platform for managing promotional QR-code cards. The backend will be a Python/FastAPI REST API with JWT authentication and a PostgreSQL database. The frontend will be a Dart/Flutter web application using Riverpod for state management and Dio for network requests. The entire infrastructure will be containerized using Docker.

## Technical Context

**Language/Version**: Python 3.11+, Dart 3.0+
**Primary Dependencies**: FastAPI, Uvicorn, SQLAlchemy, Pydantic, python-jose[cryptography], passlib[bcrypt] (backend); Flutter, Riverpod, Dio (frontend)
**Storage**: PostgreSQL 15+
**Testing**: pytest (backend), flutter_test (frontend)
**Target Platform**: Web (running in modern browsers)
**Project Type**: Web application (backend + frontend)
**Performance Goals**: API responses < 200ms p95; Page loads < 2s
**Constraints**: Secure JWT-based authentication and role-based access control (RBAC) must be strictly enforced. Integration with the external UNP API is a critical dependency.
**Scale/Scope**: Initial scope is for a single client with multiple users across different roles (sales, cto, admin). The system should be scalable to support more clients in the future.

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

- **[PASS]** The plan adheres to the specified technology stack (Python/FastAPI, Dart/Flutter, PostgreSQL).
- **[PASS]** The plan includes provisions for JWT authentication, password hashing, and HTTPS as required by the constitution.
- **[PASS]** The project structure aligns with the web application model (backend/frontend separation).
- **[PASS]** The plan includes unit testing for both backend and frontend.
- **[PASS]** The plan will produce design artifacts (data model, contracts) as required.

## Project Structure

### Documentation (this feature)

```text
specs/001-promo-card-web-app/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output (/speckit.plan command)
├── data-model.md        # Phase 1 output (/speckit.plan command)
├── quickstart.md        # Phase 1 output (/speckit.plan command)
├── contracts/           # Phase 1 output (/speckit.plan command)
└── tasks.md             # Phase 2 output (/speckit.tasks command - NOT created by /speckit.plan)
```

### Source Code (repository root)
```text
backend/
├── app/
│   ├── api/
│   ├── core/
│   ├── crud/
│   ├── db/
│   ├── models/
│   ├── schemas/
│   └── services/
├── tests/
└── main.py

frontend/
├── lib/
│   ├── api/
│   ├── models/
│   ├── providers/
│   ├── screens/
│   ├── widgets/
│   └── main.dart
└── test/
```

**Structure Decision**: Option 2: Web application was chosen as it clearly separates the backend and frontend concerns, which aligns with the specified technology stack and the overall architecture of the project.

## Complexity Tracking

> **Fill ONLY if Constitution Check has violations that must be justified**

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| (none)    |            |                                     |

## Русский перевод

# План реализации: Веб-приложение PromoLink

**Ветка**: `001-promo-card-web-app` | **Дата**: 2025-10-24 | **Спецификация**: [C:\Users\korotkevich\AI\PromoLink\specs\001-promo-card-web-app\spec.md]
**Входные данные**: Спецификация функции из `/specs/001-promo-card-web-app/spec.md`

**Примечание**: Этот шаблон заполняется командой `/speckit.plan`. См. `.specify/templates/commands/plan.md` для рабочего процесса выполнения.

## Резюме

Этот план описывает реализацию B2B веб-платформы для управления промо-карточками с QR-кодами. Бэкенд будет представлять собой REST API на Python/FastAPI с аутентификацией JWT и базой данных PostgreSQL. Фронтенд будет веб-приложением на Dart/Flutter с использованием Riverpod для управления состоянием и Dio для сетевых запросов. Вся инфраструктура будет контейнеризирована с использованием Docker.

## Технический контекст

**Язык/Версия**: Python 3.11+, Dart 3.0+
**Основные зависимости**: FastAPI, Uvicorn, SQLAlchemy, Pydantic, python-jose[cryptography], passlib[bcrypt] (бэкенд); Flutter, Riverpod, Dio (фронтенд)
**Хранилище**: PostgreSQL 15+
**Тестирование**: pytest (бэкенд), flutter_test (фронтенд)
**Целевая платформа**: Веб (работает в современных браузерах)
**Тип проекта**: Веб-приложение (бэкенд + фронтенд)
**Цели по производительности**: Ответы API < 200 мс p95; Загрузка страниц < 2 с
**Ограничения**: Должна строго соблюдаться безопасная аутентификация на основе JWT и контроль доступа на основе ролей (RBAC). Интеграция с внешним API УНП является критической зависимостью.
**Масштаб/Объем**: Начальный объем предназначен для одного клиента с несколькими пользователями с разными ролями (продажи, ЦТО, администратор). Система должна быть масштабируемой для поддержки большего числа клиентов в будущем.

## Проверка соответствия Конституции

*ВОРОТА: Должны пройти перед исследованием Фазы 0. Повторная проверка после проектирования Фазы 1.*

- **[ПРОЙДЕНО]** План соответствует указанному стеку технологий (Python/FastAPI, Dart/Flutter, PostgreSQL).
- **[ПРОЙДЕНО]** План включает положения для аутентификации JWT, хеширования паролей и HTTPS, как того требует конституция.
- **[ПРОЙДЕНО]** Структура проекта соответствует модели веб-приложения (разделение бэкенда и фронтенда).
- **[ПРОЙДЕНО]** План включает модульное тестирование как для бэкенда, так и для фронтенда.
- **[ПРОЙДЕНО]** План будет производить артефакты проектирования (модель данных, контракты) по мере необходимости.

## Структура проекта

### Документация (эта функция)

```text
specs/001-promo-card-web-app/
├── plan.md              # Этот файл (вывод команды /speckit.plan)
├── research.md          # Вывод Фазы 0 (команда /speckit.plan)
├── data-model.md        # Вывод Фазы 1 (команда /speckit.plan)
├── quickstart.md        # Вывод Фазы 1 (команда /speckit.plan)
├── contracts/           # Вывод Фазы 1 (команда /speckit.plan)
└── tasks.md             # Вывод Фазы 2 (команда /speckit.tasks - НЕ создается /speckit.plan)
```

### Исходный код (корень репозитория)

```text
backend/
├── app/
│   ├── api/
│   ├── core/
│   ├── crud/
│   ├── db/
│   ├── models/
│   ├── schemas/
│   └── services/
├── tests/
└── main.py

frontend/
├── lib/
│   ├── api/
│   ├── models/
│   ├── providers/
│   ├── screens/
│   ├── widgets/
│   └── main.dart
└── test/
```

**Решение по структуре**: Выбран Вариант 2: Веб-приложение, поскольку он четко разделяет задачи бэкенда и фронтенда, что соответствует указанному стеку технологий и общей архитектуре проекта.

## Отслеживание сложности

> **Заполнять ТОЛЬКО если в проверке Конституции есть нарушения, которые должны быть обоснованы**

| Нарушение | Почему необходимо | Более простая альтернатива отклонена, потому что |
|-----------|-------------------|-------------------------------------------------|
| (нет)     |                   |                                                 |
