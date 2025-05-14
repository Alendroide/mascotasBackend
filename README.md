# Para el correcto funcionamiento de la app, es necesario que tenga las siguientes variables en .env
--- bash

DATABASE_URL="mysql://root@localhost:3306/mydb"
EXPIRES="1w"
SECRET="secret"
PORT=3000

---

# Cuentas
La base de datos cuenta con 3 cuentas, cuyos e-mails y contraseñas son los siguientes:
--- json
[
    {
        "email": "alendroideyt@gmail.com",
        "password": "hola1234"
    },
    {
        "email": "pepe@gmail.com",
        "password": "hola1234"
    },
    {
        "email": "kesito@gmail.com",
        "password": "hola1234"
    }
]

---