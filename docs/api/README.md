# TaskManager API Documentation

## Mock Server URL
(https://de1479a5-3290-4d09-96c6-1d421cd7855e.mock.pstmn.io)

## Endpoints
### Authentication & Users
- `POST /auth/register` - регистрация нового пользователя
- `POST /auth/login` - вход в систему

### Accounts Management
- `GET /accounts` - получить все учётные записи
- `GET /accounts/{id}` - получить конкретную учётную запись
- `POST /accounts` - создать новую учётную запись
- `PATCH /tasks/:id` - обновить задачу
- `DELETE /tasks/:id` - удалить задачу

### Security & Password Tools


## Examples
### Login
Name: Success - Login
URL: {{base_url}}/auth/login?username=avsiny
Error - Invalid credentials
URL: {{base_url}}/auth/login?username=avsiny1
### Get All Tasks
