# 🚀 Spring Boot MongoDB Application

[![Java](https://img.shields.io/badge/Java-17-orange.svg)](https://openjdk.java.net/projects/jdk/17/)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.2.0-green.svg)](https://spring.io/projects/spring-boot)
[![MongoDB](https://img.shields.io/badge/MongoDB-8.0-blue.svg)](https://www.mongodb.com/)
[![Maven](https://img.shields.io/badge/Maven-3.9.6-red.svg)](https://maven.apache.org/)

Una aplicación completa de **Spring Boot** con integración **MongoDB** que implementa un sistema de gestión de usuarios con API REST.

## ✨ **Características**

- 🔐 **API REST completa** para gestión de usuarios
- 🗄️ **Integración con MongoDB** para persistencia de datos
- ✅ **Validación de datos** con Bean Validation
- 🔍 **Búsquedas avanzadas** por múltiples criterios
- 🌐 **CORS configurado** para aplicaciones frontend
- 📊 **Logging detallado** para debugging
- 🚀 **Arquitectura en capas** (Controller, Service, Repository, Model)

## 🏗️ **Arquitectura del Proyecto**

```
src/
├── main/
│   ├── java/com/example/demo/
│   │   ├── controller/     # Controladores REST
│   │   ├── service/        # Lógica de negocio
│   │   ├── repository/     # Acceso a datos
│   │   ├── model/          # Entidades de dominio
│   │   └── DemoApplication.java
│   └── resources/
│       ├── application.properties      # Configuración principal
│       ├── application-dev.properties  # Configuración de desarrollo
│       └── mongod.cfg                 # Configuración de MongoDB
```

## 🛠️ **Tecnologías Utilizadas**

- **Backend**: Spring Boot 3.2.0
- **Base de Datos**: MongoDB 8.0
- **Java**: JDK 17 LTS
- **Build Tool**: Maven 3.9.6
- **Validación**: Bean Validation (Jakarta)
- **Logging**: Logback

## 📋 **Requisitos del Sistema**

- **Sistema Operativo**: Windows 10/11
- **Java**: JDK 17 o superior
- **MongoDB**: 8.0 o superior
- **Maven**: 3.9.6 o superior
- **Memoria RAM**: Mínimo 4GB (recomendado 8GB)
- **Espacio en Disco**: Mínimo 2GB libre

## 🚀 **Instalación y Configuración**

### **Instalación Rápida**

1. **Clonar el repositorio**
   ```bash
   git clone https://github.com/TU_USUARIO/spring-boot-mongo-app.git
   cd spring-boot-mongo-app
   ```

2. **Ejecutar script de instalación**
   ```powershell
   .\instalar-mongodb.ps1
   ```

3. **Configurar variables de entorno**
   ```powershell
   $env:PATH += ";C:\Program Files\Java\jdk-17\bin;C:\Program Files\MongoDB\Server\8.0\bin;C:\maven\apache-maven-3.9.6\bin"
   ```

4. **Compilar y ejecutar**
   ```powershell
   mvn clean package -DskipTests
   java -jar target\demo-0.0.1-SNAPSHOT.jar
   ```

### **Instalación Manual**

Para una instalación paso a paso detallada, consulta la **[Guía Completa de Instalación](GUIA-INSTALACION-COMPLETA.md)**.

## 🧪 **Uso de la API**

### **Endpoints Disponibles**

| Método | Endpoint | Descripción |
|--------|----------|-------------|
| `GET` | `/api/usuarios` | Obtener todos los usuarios |
| `GET` | `/api/usuarios/{id}` | Obtener usuario por ID |
| `GET` | `/api/usuarios/email/{email}` | Buscar usuario por email |
| `GET` | `/api/usuarios/nombre/{nombre}` | Buscar usuarios por nombre |
| `GET` | `/api/usuarios/apellido/{apellido}` | Buscar usuarios por apellido |
| `GET` | `/api/usuarios/activos` | Obtener solo usuarios activos |
| `POST` | `/api/usuarios` | Crear nuevo usuario |
| `PUT` | `/api/usuarios/{id}` | Actualizar usuario existente |
| `DELETE` | `/api/usuarios/{id}` | Eliminar usuario |
| `PATCH` | `/api/usuarios/{id}/deactivate` | Desactivar usuario |

### **Ejemplos de Uso**

#### **Crear un Usuario**
```bash
curl -X POST http://localhost:8082/api/usuarios \
  -H "Content-Type: application/json" \
  -d '{
    "nombre": "Juan",
    "apellido": "Pérez",
    "email": "juan.perez@ejemplo.com",
    "password": "123456",
    "telefono": "123456789",
    "direccion": "Calle Principal 123"
  }'
```

#### **Obtener Todos los Usuarios**
```bash
curl http://localhost:8082/api/usuarios
```

#### **Buscar por Email**
```bash
curl http://localhost:8082/api/usuarios/email/juan.perez@ejemplo.com
```

## 📊 **Modelo de Datos**

### **Entidad Usuario**
```json
{
  "id": "string (ObjectId)",
  "nombre": "string (2-50 caracteres)",
  "apellido": "string (2-50 caracteres)",
  "email": "string (único, formato válido)",
  "password": "string (mínimo 6 caracteres)",
  "telefono": "string (opcional)",
  "direccion": "string (opcional)",
  "activo": "boolean (por defecto: true)"
}
```

### **Validaciones**
- **nombre/apellido**: Obligatorio, 2-50 caracteres
- **email**: Obligatorio, formato válido, único en la base de datos
- **password**: Obligatorio, mínimo 6 caracteres
- **telefono/direccion**: Opcionales

## 🔧 **Configuración**

### **Puertos por Defecto**
- **Spring Boot**: 8082
- **MongoDB**: 27017

### **Base de Datos**
- **Nombre**: `usuarios_db`
- **Colección**: `usuarios`

### **Cambiar Configuración**
Edita `src/main/resources/application.properties`:
```properties
# Cambiar puerto
server.port=8083

# Cambiar base de datos
spring.data.mongodb.database=mi_base_datos
```

## 🚨 **Solución de Problemas**

### **Problemas Comunes**

| Problema | Solución |
|----------|----------|
| Puerto 8080 ocupado | Cambiar a puerto 8082 en `application.properties` |
| MongoDB no conecta | Verificar que MongoDB esté ejecutándose en puerto 27017 |
| Java no encontrado | Configurar PATH: `$env:PATH += ";C:\Program Files\Java\jdk-17\bin"` |
| Maven no encontrado | Configurar PATH: `$env:PATH += ";C:\maven\apache-maven-3.9.6\bin"` |

### **Logs y Debugging**
- **MongoDB logs**: `C:\data\log\mongod.log`
- **Spring Boot logs**: Consola de ejecución
- **Nivel de logging**: Configurado en `application.properties`

## 🤝 **Contribuir**

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📝 **Licencia**

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

## 👨‍💻 **Autor**

**Tu Nombre** - [tu-email@ejemplo.com](mailto:tu-email@ejemplo.com)

## 🙏 **Agradecimientos**

- [Spring Boot](https://spring.io/projects/spring-boot) por el framework
- [MongoDB](https://www.mongodb.com/) por la base de datos
- [Apache Maven](https://maven.apache.org/) por la herramienta de build

---

⭐ **Si este proyecto te fue útil, ¡dale una estrella en GitHub!**
