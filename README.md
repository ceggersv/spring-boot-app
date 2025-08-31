# Aplicación Spring Boot - Gestión de Usuarios

Esta es una aplicación Spring Boot completa que demuestra la implementación de una API REST para la gestión de usuarios con base de datos H2 y JPA.

## Características

- **Spring Boot 3.2.0** con Java 17
- **API REST** completa con operaciones CRUD
- **Base de datos H2** en memoria
- **JPA/Hibernate** para persistencia
- **Validación** de datos con Bean Validation
- **Manejo de errores** robusto
- **CORS** habilitado para desarrollo frontend

## Estructura del Proyecto

```
src/
├── main/
│   ├── java/
│   │   └── com/example/demo/
│   │       ├── DemoApplication.java          # Clase principal
│   │       ├── controller/
│   │       │   └── UsuarioController.java   # Controlador REST
│   │       ├── service/
│   │       │   └── UsuarioService.java      # Lógica de negocio
│   │       ├── repository/
│   │       │   └── UsuarioRepository.java   # Repositorio JPA
│   │       └── model/
│   │           └── Usuario.java             # Entidad JPA
│   └── resources/
│       ├── application.properties           # Configuración
│       └── data.sql                         # Datos iniciales
└── test/
    └── java/
        └── com/example/demo/                # Tests unitarios
```

## Requisitos

- Java 17 o superior
- Maven 3.6 o superior

## Instalación y Ejecución

### 1. Clonar y navegar al proyecto
```bash
cd spring-boot-app
```

### 2. Compilar el proyecto
```bash
mvn clean compile
```

### 3. Ejecutar la aplicación
```bash
mvn spring-boot:run
```

### 4. Verificar que esté funcionando
La aplicación estará disponible en: http://localhost:8080

## Endpoints de la API

### Usuarios
- `GET /api/usuarios` - Obtener todos los usuarios
- `GET /api/usuarios/{id}` - Obtener usuario por ID
- `GET /api/usuarios/buscar?nombre={nombre}` - Buscar usuarios por nombre
- `POST /api/usuarios` - Crear nuevo usuario
- `PUT /api/usuarios/{id}` - Actualizar usuario existente
- `DELETE /api/usuarios/{id}` - Eliminar usuario

### Health Check
- `GET /api/usuarios/health` - Verificar estado de la aplicación

### Consola H2
- `GET /h2-console` - Acceder a la consola de base de datos H2

## Ejemplo de Uso

### Crear un usuario
```bash
curl -X POST http://localhost:8080/api/usuarios \
  -H "Content-Type: application/json" \
  -d '{
    "nombre": "Nuevo Usuario",
    "email": "nuevo@email.com",
    "password": "password123"
  }'
```

### Obtener todos los usuarios
```bash
curl http://localhost:8080/api/usuarios
```

### Buscar usuarios por nombre
```bash
curl "http://localhost:8080/api/usuarios/buscar?nombre=Juan"
```

## Base de Datos

La aplicación utiliza H2 como base de datos en memoria. Los datos se recrean cada vez que se inicia la aplicación.

**Configuración H2:**
- URL: `jdbc:h2:mem:testdb`
- Usuario: `sa`
- Contraseña: `password`
- Consola: http://localhost:8080/h2-console

## Desarrollo

### Agregar nuevas entidades
1. Crear la clase modelo en `src/main/java/com/example/demo/model/`
2. Crear el repositorio en `src/main/java/com/example/demo/repository/`
3. Crear el servicio en `src/main/java/com/example/demo/service/`
4. Crear el controlador en `src/main/java/com/example/demo/controller/`

### Ejecutar tests
```bash
mvn test
```

### Empaquetar la aplicación
```bash
mvn clean package
```

## Tecnologías Utilizadas

- **Spring Boot** - Framework principal
- **Spring Data JPA** - Persistencia de datos
- **H2 Database** - Base de datos en memoria
- **Hibernate** - ORM
- **Bean Validation** - Validación de datos
- **Maven** - Gestión de dependencias

## Contribución

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.
