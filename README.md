# Sample Full Stack Application
## Table of Contents:
1. [Project Details](#project-details)
2. [Express API](#express-api)
3. [Video Sample](#video)
## Project Details
### Front-End:
- iOS Application 
- Framework: SwiftUI and Swift
- MVVM Architecture

### Back-End:
- HTTP CRUD REST API created with Node.js & Express (TypeScript)
- JSON Web Tokens
- Database: MySQL
- MVC Architecture

# Express API
URL: ```http://127.0.0.1:1234```

## /auth/login (POST)
### Body parameters (JSON):
```JSON
{
    "username": "some-username",
    "password": "some-password"
}
```
### Returns:
```TS
{
    status_code: Int,
    token: String
}
```

## /auth/register (POST)
### Body parameters (JSON):
```JSON
{
    "username": "some-username",
    "password": "some-password",
    "location": "some, location"
}
```
### Returns:
```TS
{
    status_code: Int,
    token: String
}
```

## /user (POST)
### Body parameters (JSON):
```JSON
{
    "token": "abcdefgh12345"
}
```
### Returns:
```TS
{
    user_id: Int,
    username: String,
    location: String
}
```

## REST API Errors Returns
```TS
{
    status_code: Int,
    message: String
}
```

# Video

https://user-images.githubusercontent.com/73256760/180339731-01f3416a-54ea-402f-86fe-2ad84113ad80.mov



