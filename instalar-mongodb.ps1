# Script para instalar MongoDB en Windows
# Ejecutar como Administrador

Write-Host "=== Instalador de MongoDB para Windows ===" -ForegroundColor Green

# Verificar si MongoDB ya está instalado
try {
    $mongoVersion = mongod --version 2>$null
    if ($mongoVersion) {
        Write-Host "MongoDB ya está instalado:" -ForegroundColor Yellow
        Write-Host $mongoVersion -ForegroundColor Cyan
        Write-Host "Saltando instalación..." -ForegroundColor Yellow
        exit 0
    }
} catch {
    Write-Host "MongoDB no está instalado, procediendo con la instalación..." -ForegroundColor Yellow
}

# Instalar MongoDB usando winget
Write-Host "Instalando MongoDB..." -ForegroundColor Green
try {
    winget install MongoDB.Server
    if ($LASTEXITCODE -eq 0) {
        Write-Host "MongoDB instalado exitosamente!" -ForegroundColor Green
    } else {
        Write-Host "Error al instalar MongoDB con winget" -ForegroundColor Red
        Write-Host "Intentando método alternativo..." -ForegroundColor Yellow
    }
} catch {
    Write-Host "Error con winget, intentando método alternativo..." -ForegroundColor Yellow
}

# Método alternativo: Descargar e instalar manualmente
Write-Host "Descargando MongoDB Community Server..." -ForegroundColor Green
$mongoUrl = "https://fastdl.mongodb.org/windows/mongodb-windows-x86_64-6.0.14-signed.msi"
$downloadPath = "$env:TEMP\mongodb-installer.msi"

try {
    Invoke-WebRequest -Uri $mongoUrl -OutFile $downloadPath
    Write-Host "Descarga completada. Instalando..." -ForegroundColor Green
    
    # Instalar MongoDB
    Start-Process msiexec.exe -Wait -ArgumentList '/i', $downloadPath, '/quiet', '/norestart'
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "MongoDB instalado exitosamente!" -ForegroundColor Green
    } else {
        Write-Host "Error durante la instalación" -ForegroundColor Red
        exit 1
    }
} catch {
    Write-Host "Error al descargar MongoDB: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

# Crear directorio de datos
Write-Host "Creando directorio de datos..." -ForegroundColor Green
$dataDir = "C:\data\db"
if (!(Test-Path $dataDir)) {
    New-Item -ItemType Directory -Path $dataDir -Force | Out-Null
    Write-Host "Directorio de datos creado: $dataDir" -ForegroundColor Green
}

# Crear archivo de configuración
Write-Host "Creando archivo de configuración..." -ForegroundColor Green
$configDir = "C:\Program Files\MongoDB\Server\6.0\bin"
$configFile = "$configDir\mongod.cfg"

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

processManagement:
  windowsService:
    serviceName: MongoDB
    displayName: MongoDB
    description: MongoDB Database Server
"@

try {
    if (!(Test-Path "C:\data\log")) {
        New-Item -ItemType Directory -Path "C:\data\log" -Force | Out-Null
    }
    
    $configContent | Out-File -FilePath $configFile -Encoding UTF8
    Write-Host "Archivo de configuración creado: $configFile" -ForegroundColor Green
} catch {
    Write-Host "Error al crear archivo de configuración: $($_.Exception.Message)" -ForegroundColor Red
}

# Instalar como servicio de Windows
Write-Host "Instalando MongoDB como servicio de Windows..." -ForegroundColor Green
try {
    & "$configDir\mongod.exe" --config "$configFile" --install
    if ($LASTEXITCODE -eq 0) {
        Write-Host "MongoDB instalado como servicio exitosamente!" -ForegroundColor Green
        
        # Iniciar el servicio
        Start-Service MongoDB
        Write-Host "Servicio MongoDB iniciado!" -ForegroundColor Green
    } else {
        Write-Host "Error al instalar MongoDB como servicio" -ForegroundColor Red
    }
} catch {
    Write-Host "Error al instalar servicio: $($_.Exception.Message)" -ForegroundColor Red
}

# Limpiar archivo temporal
if (Test-Path $downloadPath) {
    Remove-Item $downloadPath -Force
}

Write-Host "=== Instalación completada ===" -ForegroundColor Green
Write-Host "MongoDB debería estar ejecutándose en: mongodb://localhost:27017" -ForegroundColor Cyan
Write-Host "Para verificar, ejecuta: mongosh" -ForegroundColor Cyan
Write-Host "Para detener el servicio: Stop-Service MongoDB" -ForegroundColor Cyan
Write-Host "Para iniciar el servicio: Start-Service MongoDB" -ForegroundColor Cyan

# Verificar instalación
Write-Host "Verificando instalación..." -ForegroundColor Green
try {
    $mongoVersion = mongod --version 2>$null
    if ($mongoVersion) {
        Write-Host "MongoDB está funcionando correctamente!" -ForegroundColor Green
        Write-Host $mongoVersion -ForegroundColor Cyan
    }
} catch {
    Write-Host "No se pudo verificar la versión de MongoDB" -ForegroundColor Yellow
}
