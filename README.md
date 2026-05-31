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
# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...




Como correr el proyecto: 

1. Instalar extension de devcontainers en vscode




Sistema de Autenticacion



1. El sistema va a estar corriendo en dos puertos distintos: 3000 (hogar) y 8080 (keycloak)

2. Abre el navegador a http://localhost:8080 y alli va a ver una pagina de login para el realm "master". 
- El combo de usuario/contrasena que hay que usar es: admin/admin

2. Crear un Nuevo Realm 

    Haz clic en el dropdown de realms (arriba a la izquierda donde dice "master")
    Haz clic en "Create Realm"
    Nombre: rails-dev
    Haz clic en "Create"
    Ahora estarás en el realm rails-dev

3. Crear un Nuevo Cliente: "rails-app"

    En el menú izquierdo, ve a "Clients"

    Haz clic en "Create client"
    - Client ID: rails-app
    
    Haz clic en "Next"

    Activa:
    - Client authentication (encendido)
    - Authorization (encendido)

    Haz clic en "Next" y luego "Save"

4. Configurar el Cliente: Capítulo "Settings"
    En la página del cliente rails-app, ve a la pestaña "Settings"
    Configuración necesaria:

    - Root URL: http://localhost:3000
    - Valid Redirect URIs: http://localhost:3000/*, http://localhost:3000/auth/openid_connect/callback
    - Valid Post Logout Redirect URIs:http://localhost:3000/*, http://localhost:3000/
    - Web Origins: http://localhost:3000
    - Haz clic en "Save"

5. Obtener el Client Secret
    Ve a la pestaña "Credentials"
    Copia el "Client secret"
    Actualiza tu archivo .env.local:

    KEYCLOAK_CLIENT_ID=rails-app
    KEYCLOAK_CLIENT_SECRET=<tu_client_secret_aqui> (se puede ver en la configuracion del cliente)
    KEYCLOAK_REALM=rails-dev
    KEYCLOAK_SITE=http://keycloak:8080
    KEYCLOAK_REDIRECT_URI=http://localhost:3000/auth/openid_connect/callback

6. Crear un Nuevo Usuario
    En el menú izquierdo, ve a "Users"
    Haz clic en "Add user"
    Username: testuser
    Email: testuser@example.com
    Activa: Email verified
    Haz clic en "Create"

    Establecer contraseña:
    - Ve a la pestaña "Credentials"
    - Haz clic en "Set password"
    - Password: password123 (o lo que prefieras)
    - Confirm password: igual
    - Desactiva: ⬜ Temporary (para que no pida cambiar contraseña)
    - Haz clic en "Set password"
    
    
    Asignar rol (opcional):

        Ve a la pestaña "Role mapping"
        Haz clic en "Assign role"
        Selecciona roles como user o admin si los necesitas (se puede crear mas con tiempo)


7. Configurar Scopes (importante para OpenID Connect)

    En el cliente rails-app, ve a la pestaña "Client scopes"
    Asegúrate de que tengas:
    - openid
    - email
    - profile

8. Realizar el Login desde localhost:3000
    Abre tu aplicación Rails en http://localhost:3000

    Haz clic en "Login with Keycloak"

    Serás redirigido a http://localhost:8080/realms/rails-dev/protocol/openid-connect/auth

    Ingresa las credenciales:
    - Username: testuser
    - Password: password123

    Haz clic en "Sign In"

    Se te pedirá que confirmes el acceso (haz clic en "Yes")
    Serás redirigido de vuelta a http://localhost:3000 y verás: "Hello, testuser!"

9. Logout
    En tu aplicación, haz clic en "Logout"
    Serás redirigido a Keycloak para cerrar sesión
    Luego regresarás a http://localhost:3000
    Verás "You are not signed in." nuevamente
# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...




Como correr el proyecto: 

1. Instalar extension de devcontainers en vscode




Sistema de Autenticacion



1. El sistema va a estar corriendo en dos puertos distintos: 3000 (hogar) y 8080 (keycloak)

2. Abre el navegador a http://localhost:8080 y alli va a ver una pagina de login para el realm "master". 
- El combo de usuario/contrasena que hay que usar es: admin/admin

2. Crear un Nuevo Realm 

    Haz clic en el dropdown de realms (arriba a la izquierda donde dice "master")
    Haz clic en "Create Realm"
    Nombre: rails-dev
    Haz clic en "Create"
    Ahora estarás en el realm rails-dev

3. Crear un Nuevo Cliente: "rails-app"

    En el menú izquierdo, ve a "Clients"

    Haz clic en "Create client"
    - Client ID: rails-app
    
    Haz clic en "Next"

    Activa:
    - Client authentication (encendido)
    - Authorization (encendido)

    Haz clic en "Next" y luego "Save"

4. Configurar el Cliente: Capítulo "Settings"
    En la página del cliente rails-app, ve a la pestaña "Settings"
    Configuración necesaria:

    - Root URL: http://localhost:3000
    - Valid Redirect URIs: http://localhost:3000/*, http://localhost:3000/auth/openid_connect/callback
    - Valid Post Logout Redirect URIs:http://localhost:3000/*, http://localhost:3000/
    - Web Origins: http://localhost:3000
    - Haz clic en "Save"

5. Obtener el Client Secret
    Ve a la pestaña "Credentials"
    Copia el "Client secret"
    Actualiza tu archivo .env.local:

    KEYCLOAK_CLIENT_ID=rails-app
    KEYCLOAK_CLIENT_SECRET=<tu_client_secret_aqui> (se puede ver en la configuracion del cliente)
    KEYCLOAK_REALM=rails-dev
    KEYCLOAK_SITE=http://keycloak:8080
    KEYCLOAK_REDIRECT_URI=http://localhost:3000/auth/openid_connect/callback

6. Crear un Nuevo Usuario
    En el menú izquierdo, ve a "Users"
    Haz clic en "Add user"
    Username: testuser
    Email: testuser@example.com
    Activa: Email verified
    Haz clic en "Create"

    Establecer contraseña:
    - Ve a la pestaña "Credentials"
    - Haz clic en "Set password"
    - Password: password123 (o lo que prefieras)
    - Confirm password: igual
    - Desactiva: ⬜ Temporary (para que no pida cambiar contraseña)
    - Haz clic en "Set password"
    
    
    Asignar rol (opcional):

        Ve a la pestaña "Role mapping"
        Haz clic en "Assign role"
        Selecciona roles como user o admin si los necesitas (se puede crear mas con tiempo)


7. Configurar Scopes (importante para OpenID Connect)

    En el cliente rails-app, ve a la pestaña "Client scopes"
    Asegúrate de que tengas:
    - openid
    - email
    - profile

8. Realizar el Login desde localhost:3000
    Abre tu aplicación Rails en http://localhost:3000

    Haz clic en "Login with Keycloak"

    Serás redirigido a http://localhost:8080/realms/rails-dev/protocol/openid-connect/auth

    Ingresa las credenciales:
    - Username: testuser
    - Password: password123

    Haz clic en "Sign In"

    Se te pedirá que confirmes el acceso (haz clic en "Yes")
    Serás redirigido de vuelta a http://localhost:3000 y verás: "Hello, testuser!"

9. Logout
    En tu aplicación, haz clic en "Logout"
    Serás redirigido a Keycloak para cerrar sesión
    Luego regresarás a http://localhost:3000
    Verás "You are not signed in." nuevamente





Pruebas Unitarias con Keycloak:

Para probar las pruebas unitarias de Keycloak y averiguar que los endpoints de acceso estan controlados por rol, hay que 


La base de datos es de postgres pero es una separada a la de produccion para que no interfiere con los datos que ya estan en la de produccion.

Para realizar las pruebas unitarias del middleware de keycloak, ejecuta:

bundle install (para averiguar si todo esta instalado)

rails test test/middleware/keycloak_middleware_test.rb -v (para realizar las pruebas)

