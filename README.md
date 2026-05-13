# Enterprise Inventory Management System

Sistema empresarial de gestión de inventario desarrollado con Ruby on Rails, enfocado en calidad de software, observabilidad, DevSecOps y automatización de pruebas.

## Descripción

Este proyecto busca implementar un sistema moderno de inventario para pequeñas empresas con capacidades empresariales como:

- Gestión de productos
- Control de stock
- Historial de movimientos
- Auditoría
- API REST documentada
- Dashboard administrativo
- Seguridad granular basada en permisos
- Observabilidad completa
- CI/CD automatizado
- Testing full stack

---

## Tecnologías

### Backend

- Ruby on Rails
- PostgreSQL
- Sidekiq
- Redis

### Seguridad

- Keycloak
- OAuth2
- JWT
- Roles
- Permissions
- Scopes

### Observabilidad

- OpenTelemetry
- Grafana Alloy
- Prometheus
- Tempo
- Loki
- Grafana
- Alertmanager

### Calidad y Testing

- RSpec
- FactoryBot
- Capybara
- Playwright
- Testcontainers
- OWASP ZAP
- k6

### DevOps

- Docker
- Docker Compose
- GitHub Actions
- Jenkins
- SonarQube

---

## Funcionalidades

### Gestión de productos

- Crear productos
- Editar productos
- Eliminar productos
- Listar productos
- Búsqueda
- Paginación
- Filtros
- Ordenamiento

### Control de inventario

- Entrada de productos
- Salida de productos
- Ajustes de stock
- Alertas por stock mínimo
- Historial de movimientos
- Auditoría

### Dashboard

Incluye:

- Productos críticos
- Productos más vendidos
- Historial reciente
- Métricas operacionales
- Estado del sistema

### API empresarial

Endpoints disponibles:

- CRUD productos
- Consulta de inventario
- Movimientos de stock
- Reportes

Documentación disponible mediante:

- Swagger/OpenAPI

---

## Modelo de permisos

El sistema utiliza un modelo de autorización granular.

Permisos mínimos:

| Módulo | Permiso |
|----------|-------------|
| Productos | product:view |
| Productos | product:manage |
| Stock | stock:view |
| Stock | stock:manage |
| Reportes | report:view |
| Seguridad | user:manage |
| Auditoría | audit:view |

Los accesos son validados por permisos individuales y no únicamente por roles.

---

## Arquitectura

```txt
Client
   ↓
Rails Application
   ↓
Authentication Layer
(Keycloak + JWT)
   ↓
Application Services
   ↓
PostgreSQL
   ↓
OpenTelemetry
   ↓
Alloy
   ↓
Prometheus / Loki / Tempo
   ↓
Grafana
```

---

## Configuración local

### Requisitos

- Ruby >= 3.4
- Rails >= 8
- PostgreSQL
- Redis
- Docker
- Docker Compose

### Instalación

Clonar repositorio:

```bash
git clone https://github.com/NelcidoRafaelDiazDelgado/Store.git

cd Store
```

Instalar dependencias:

```bash
bundle install
```

Crear variables de entorno:

```bash
cp .env.example .env
```

Configurar base de datos:

```bash
rails db:create
rails db:migrate
rails db:seed
```

Ejecutar aplicación:

```bash
bin/dev
```

---

## Docker

Levantar servicios:

```bash
docker compose up -d
```

Servicios incluidos:

- Rails
- PostgreSQL
- Redis
- Keycloak
- Prometheus
- Loki
- Tempo
- Grafana
- Alloy

---

## Testing

Ejecutar pruebas unitarias:

```bash
bundle exec rspec
```

Pruebas E2E:

```bash
npx playwright test
```

Pruebas de rendimiento:

```bash
k6 run tests/load.js
```

Pruebas de seguridad:

```bash
owasp-zap-baseline.py
```

---

## Observabilidad

Métricas monitoreadas:

- CPU
- Memoria
- Throughput
- Error rate
- Latencia
- Database pool

Logs:

- traceId
- spanId
- correlationId
- usuario
- endpoint

Trazas:

- Requests
- Base de datos
- Servicios externos
- Errores distribuidos

---

## Pipeline CI/CD

### GitHub Actions

Pipeline:

- Build
- Unit tests
- Integration tests
- API tests
- E2E tests
- Security scan
- Coverage
- Docker build

### Jenkins

Pipeline visual completo con:

- Build
- Test
- Quality Gates
- Deploy
- Monitoring

---

## Convenciones

### Conventional commits

Ejemplos:

```bash
feat: add inventory dashboard

fix: resolve stock calculation issue

refactor: simplify authentication service
```

### Estrategia de ramas

```txt
main
develop
feature/*
fix/*
hotfix/*
```

---

## Equipo

Integrantes:

- Nelcido Diaz
- Stanley Gomez

---

## Licencia

MIT
