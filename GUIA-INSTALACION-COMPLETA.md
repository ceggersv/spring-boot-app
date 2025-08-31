# 🚀 Guía Completa de Instalación y Configuración
## Spring Boot + MongoDB + Java 17

### 📋 **Requisitos Previos**
- Windows 10/11
- PowerShell (ejecutar como Administrador)
- Conexión a Internet para descargas

---

## 🔧 **PASO 1: Instalación de Java 17**

### 1.1 Verificar si Java ya está instalado
```powershell
java -version
```

### 1.2 Si no está instalado, instalar Java 17
```powershell
# Opción 1: Usar winget (recomendado)
winget install Oracle.JDK.17

# Opción 2: Descarga manual desde Oracle
# Ir a: https://www.oracle.com/java/technologies/downloads/#java17
# Descargar: Windows x64 Installer
```

### 1.3 Verificar la instalación
```powershell
java -version
# Debe mostrar: java version "17.0.x" 2025-xx-xx LTS
```

---

## 🗄️ **PASO 2: Instalación de MongoDB**

### 2.1 Verificar si MongoDB ya está instalado
```powershell
mongod --version
```

### 2.2 Si no está instalado, ejecutar el script de instalación
```powershell
# Navegar al directorio del proyecto
cd C:\Users\lenovo\camunda-mtec\spring-boot-mongo-app

# Ejecutar script de instalación
.\instalar-mongodb.ps1
```

### 2.3 Crear directorios necesarios
```powershell
# Crear directorio de datos
New-Item -ItemType Directory -Path "C:\data\db" -Force

# Crear directorio de logs
New-Item -ItemType Directory -Path "C:\data\log" -Force
```

### 2.4 Crear archivo de configuración de MongoDB
```powershell
# Crear archivo mongod.cfg en el directorio del proyecto
$configContent = @"
# MongoDB Configuration File
systemLog:
  destination: file
  path: C:\data\log\mongod.log
  logAppend: true

storage:
  dbPath: C:\data\db

net:
  bindIp: 127.0.0.1
  port: 27017
"@

$configContent | Out-File -FilePath "mongod.cfg" -Encoding UTF8
```

---

## 📦 **PASO 3: Instalación de Maven**

### 3.1 Verificar si Maven ya está instalado
```powershell
mvn -version
```

### 3.2 Si no está instalado, instalar Maven
```powershell
# Crear directorio para Maven
New-Item -ItemType Directory -Path "C:\maven" -Force

# Descargar Maven 3.9.6
Invoke-WebRequest -Uri "https://archive.apache.org/dist/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.zip" -OutFile "C:\maven\maven.zip"

# Extraer Maven
Expand-Archive -Path "C:\maven\maven.zip" -DestinationPath "C:\maven" -Force
```

---

## ⚙️ **PASO 4: Configuración de Variables de Entorno**

### 4.1 Configurar PATH temporalmente (para la sesión actual)
```powershell
# Agregar Java, MongoDB y Maven al PATH
$env:PATH += ";C:\Program Files\Java\jdk-17\bin;C:\Program Files\MongoDB\Server\8.0\bin;C:\maven\apache-maven-3.9.6\bin"
```

### 4.2 Verificar que todo esté funcionando
```powershell
# Verificar Java
java -version

# Verificar MongoDB
mongod --version

# Verificar Maven
mvn -version
```

---

## 🚀 **PASO 5: Iniciar Servicios**

### 5.1 Iniciar MongoDB (Primer PowerShell)
```powershell
# Configurar PATH
$env:PATH += ";C:\Program Files\MongoDB\Server\8.0\bin"

# Iniciar MongoDB en segundo plano
mongod --config mongod.cfg
```

### 5.2 Verificar que MongoDB esté ejecutándose
```powershell
# Verificar puerto 27017
Get-NetTCPConnection -LocalPort 27017 -ErrorAction SilentlyContinue
```

---

## 🏗️ **PASO 6: Compilar y Ejecutar la Aplicación**

### 6.1 Navegar al directorio del proyecto
```powershell
cd C:\Users\lenovo\camunda-mtec\spring-boot-mongo-app
```

### 6.2 Configurar PATH (Segundo PowerShell)
```powershell
$env:PATH += ";C:\Program Files\Java\jdk-17\bin;C:\Program Files\MongoDB\Server\8.0\bin;C:\maven\apache-maven-3.9.6\bin"
```

### 6.3 Compilar el proyecto
```powershell
mvn clean package -DskipTests
```

### 6.4 Ejecutar la aplicación
```powershell
java -jar target\demo-0.0.1-SNAPSHOT.jar
```

### 6.5 Verificar que la aplicación esté ejecutándose
```powershell
# Verificar puerto 8082
Get-NetTCPConnection -LocalPort 8082 -ErrorAction SilentlyContinue
```

---

## 🧪 **PASO 7: Probar la Aplicación**

### 7.1 Probar endpoint de usuarios (Tercer PowerShell)
```powershell
# Configurar PATH
$env:PATH += ";C:\Program Files\Java\jdk-17\bin;C:\Program Files\MongoDB\Server\8.0\bin;C:\maven\apache-maven-3.9.6\bin"

# Obtener todos los usuarios
Invoke-WebRequest -Uri "http://localhost:8082/api/usuarios" -Method GET

# Crear un usuario
$usuario = @{
    nombre = "Juan"
    apellido = "Pérez"
    email = "juan.perez@test.com"
    password = "123456"
    telefono = "123456789"
    direccion = "Calle Test 123"
} | ConvertTo-Json

Invoke-WebRequest -Uri "http://localhost:8082/api/usuarios" -Method POST -Body $usuario -ContentType "application/json"
```

---

## 🔧 **PASO 8: Configuración Permanente (Opcional)**

### 8.1 Agregar al PATH del sistema (permanente)
```powershell
# Agregar al PATH del usuario
[Environment]::SetEnvironmentVariable("PATH", $env:PATH + ";C:\Program Files\Java\jdk-17\bin;C:\Program Files\MongoDB\Server\8.0\bin;C:\maven\apache-maven-3.9.6\bin", "User")

# Reiniciar PowerShell para aplicar cambios
```

### 8.2 Crear scripts de inicio automático
```powershell
# Script para iniciar MongoDB
$mongoScript = @"
# Iniciar MongoDB
cd C:\Users\lenovo\camunda-mtec\spring-boot-mongo-app
mongod --config mongod.cfg
"@

$mongoScript | Out-File -FilePath "iniciar-mongodb.ps1" -Encoding UTF8

# Script para iniciar Spring Boot
$springScript = @"
# Iniciar Spring Boot
cd C:\Users\lenovo\camunda-mtec\spring-boot-mongo-app
java -jar target\demo-0.0.1-SNAPSHOT.jar
"@

$springScript | Out-File -FilePath "iniciar-spring-boot.ps1" -Encoding UTF8
```

---

## 📊 **PASO 9: Monitoreo y Debugging**

### 9.1 Verificar procesos en ejecución
```powershell
# Ver procesos de Java
Get-Process java -ErrorAction SilentlyContinue

# Ver procesos de MongoDB
Get-Process mongod -ErrorAction SilentlyContinue
```

### 9.2 Verificar puertos en uso
```powershell
# Ver puerto MongoDB (27017)
Get-NetTCPConnection -LocalPort 27017 -ErrorAction SilentlyContinue

# Ver puerto Spring Boot (8082)
Get-NetTCPConnection -LocalPort 8082 -ErrorAction SilentlyContinue
```

### 9.3 Ver logs de la aplicación
- **MongoDB logs**: `C:\data\log\mongod.log`
- **Spring Boot logs**: Consola donde ejecutaste `java -jar`

---

## 🎯 **PASO 10: Verificación Final**

### 10.1 Checklist de verificación
- [ ] Java 17 instalado y funcionando
- [ ] MongoDB instalado y ejecutándose en puerto 27017
- [ ] Maven instalado y funcionando
- [ ] Spring Boot compilado y ejecutándose en puerto 8082
- [ ] API respondiendo correctamente
- [ ] Base de datos MongoDB conectada
- [ ] Usuarios se pueden crear y consultar

### 10.2 URLs de la aplicación
- **Aplicación**: http://localhost:8082
- **API Usuarios**: http://localhost:8082/api/usuarios
- **MongoDB**: mongodb://localhost:27017

---

## 🚨 **Solución de Problemas Comunes**

### Problema: "java no se reconoce como comando"
**Solución**: Configurar PATH correctamente
```powershell
$env:PATH += ";C:\Program Files\Java\jdk-17\bin"
```

### Problema: "mongod no se reconoce como comando"
**Solución**: Configurar PATH de MongoDB
```powershell
$env:PATH += ";C:\Program Files\MongoDB\Server\8.0\bin"
```

### Problema: "mvn no se reconoce como comando"
**Solución**: Configurar PATH de Maven
```powershell
$env:PATH += ";C:\maven\apache-maven-3.9.6\bin"
```

### Problema: Puerto 8080 ocupado
**Solución**: Cambiar puerto en `application.properties`
```properties
server.port=8082
```

### Problema: Error de conexión a MongoDB
**Solución**: Verificar que MongoDB esté ejecutándose
```powershell
Get-NetTCPConnection -LocalPort 27017
```

---

## 📚 **Recursos Adicionales**

- **Documentación Spring Boot**: https://spring.io/projects/spring-boot
- **Documentación MongoDB**: https://docs.mongodb.com/
- **MongoDB Compass**: https://www.mongodb.com/try/download/compass
- **Java 17 Documentation**: https://docs.oracle.com/en/java/javase/17/

---

## 🎉 **¡Felicidades!**

Tu aplicación Spring Boot con MongoDB está completamente configurada y funcionando. Ahora puedes:

- ✅ Crear, leer, actualizar y eliminar usuarios
- ✅ Conectar desde aplicaciones frontend
- ✅ Desarrollar nuevas funcionalidades
- ✅ Escalar la aplicación según tus necesidades

**¡Disfruta desarrollando con Spring Boot y MongoDB!** 🚀
