# Instalación y Configuración de MongoDB

Este documento te guía a través de la instalación y configuración de MongoDB para el proyecto Spring Boot.

## 🚀 Instalación Rápida (Recomendado)

### Opción 1: Usar el Script Automático
1. **Ejecutar como Administrador** el archivo `instalar-mongodb.ps1`
2. El script instalará MongoDB automáticamente
3. Configurará MongoDB como servicio de Windows

```powershell
# Ejecutar como Administrador
.\instalar-mongodb.ps1
```

### Opción 2: Instalación Manual con winget
```powershell
winget install MongoDB.Server
```

### Opción 3: Usar Docker (Alternativa)
```bash
docker run -d -p 27017:27017 --name mongodb mongo:latest
```

## 📋 Prerrequisitos

- Windows 10/11
- PowerShell ejecutado como Administrador
- Conexión a Internet para descargar MongoDB

## 🔧 Configuración Manual

### 1. Crear Directorios de Datos
```powershell
# Crear directorio para la base de datos
New-Item -ItemType Directory -Path "C:\data\db" -Force

# Crear directorio para logs
New-Item -ItemType Directory -Path "C:\data\log" -Force
```

### 2. Archivo de Configuración
Crear `C:\Program Files\MongoDB\Server\6.0\bin\mongod.cfg`:

```yaml
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

processManagement:
  windowsService:
    serviceName: MongoDB
    displayName: MongoDB
    description: MongoDB Database Server
```

### 3. Instalar como Servicio
```powershell
# Navegar al directorio de MongoDB
cd "C:\Program Files\MongoDB\Server\6.0\bin"

# Instalar como servicio
.\mongod.exe --config "C:\Program Files\MongoDB\Server\6.0\bin\mongod.cfg" --install

# Iniciar el servicio
Start-Service MongoDB
```

## ✅ Verificación de la Instalación

### 1. Verificar Servicio
```powershell
# Verificar estado del servicio
Get-Service MongoDB

# Verificar que esté ejecutándose
Get-Service MongoDB | Where-Object {$_.Status -eq "Running"}
```

### 2. Probar Conexión
```powershell
# Conectar a MongoDB
mongosh

# O usar el cliente legacy
mongo
```

### 3. Verificar Puerto
```powershell
# Verificar que el puerto 27017 esté abierto
netstat -an | findstr 27017
```

## 🛠️ Comandos Útiles

### Gestión del Servicio
```powershell
# Iniciar MongoDB
Start-Service MongoDB

# Detener MongoDB
Stop-Service MongoDB

# Reiniciar MongoDB
Restart-Service MongoDB

# Ver estado
Get-Service MongoDB
```

### Conexión a la Base de Datos
```powershell
# Conectar a MongoDB
mongosh

# Conectar a base de datos específica
mongosh "mongodb://localhost:27017/usuarios_db"

# Conectar con autenticación
mongosh "mongodb://usuario:password@localhost:27017/usuarios_db"
```

### Operaciones Básicas en MongoDB
```javascript
// Listar bases de datos
show dbs

// Usar base de datos
use usuarios_db

// Listar colecciones
show collections

// Insertar documento de prueba
db.usuarios.insertOne({
    nombre: "Usuario",
    apellido: "Prueba",
    email: "test@test.com",
    password: "123456"
})

// Consultar documentos
db.usuarios.find()

// Contar documentos
db.usuarios.countDocuments()
```

## 🔍 Solución de Problemas

### Error: Puerto 27017 ya está en uso
```powershell
# Ver qué proceso está usando el puerto
netstat -ano | findstr 27017

# Terminar el proceso (reemplazar PID con el número real)
taskkill /PID <PID> /F
```

### Error: Servicio no inicia
```powershell
# Ver logs del servicio
Get-EventLog -LogName Application -Source "MongoDB" -Newest 10

# Verificar permisos en directorios
icacls "C:\data\db" /grant "NT AUTHORITY\NetworkService":(OI)(CI)F
icacls "C:\data\log" /grant "NT AUTHORITY\NetworkService":(OI)(CI)F
```

### Error: MongoDB no responde
```powershell
# Reiniciar el servicio
Restart-Service MongoDB

# Verificar logs
Get-Content "C:\data\log\mongod.log" -Tail 20
```

## 📊 Monitoreo

### Verificar Uso de Recursos
```powershell
# Ver uso de CPU y memoria
Get-Process mongod

# Ver uso de disco
Get-WmiObject -Class Win32_LogicalDisk | Select-Object DeviceID, Size, FreeSpace
```

### Logs de MongoDB
```powershell
# Ver logs en tiempo real
Get-Content "C:\data\log\mongod.log" -Wait

# Ver últimas 50 líneas
Get-Content "C:\data\log\mongod.log" -Tail 50
```

## 🚀 Próximos Pasos

1. **Verificar que MongoDB esté ejecutándose** en el puerto 27017
2. **Probar la conexión** usando `mongosh`
3. **Ejecutar la aplicación Spring Boot** con `mvn spring-boot:run`
4. **Verificar que la aplicación se conecte** a MongoDB

## 📞 Soporte

Si encuentras problemas durante la instalación:

1. Verifica que estés ejecutando PowerShell como Administrador
2. Revisa los logs en `C:\data\log\mongod.log`
3. Verifica que no haya conflictos de puertos
4. Asegúrate de que los directorios tengan permisos correctos

## 🔗 Enlaces Útiles

- [Documentación oficial de MongoDB](https://docs.mongodb.com/)
- [MongoDB Community Server](https://www.mongodb.com/try/download/community)
- [MongoDB Compass (GUI)](https://www.mongodb.com/try/download/compass)
