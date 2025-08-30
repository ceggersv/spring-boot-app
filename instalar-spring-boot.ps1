# Script de instalación automática para Spring Boot
# Ejecutar como administrador

Write-Host "=== Instalador Automático para Spring Boot ===" -ForegroundColor Green
Write-Host "Este script instalará Java 17 y Maven automáticamente" -ForegroundColor Yellow
Write-Host ""

# Verificar si ya están instalados
$javaInstalled = $false
$mavenInstalled = $false

try {
    $javaVersion = java -version 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Java ya está instalado:" -ForegroundColor Green
        Write-Host $javaVersion[0] -ForegroundColor Cyan
        $javaInstalled = $true
    }
} catch {
    Write-Host "✗ Java no está instalado" -ForegroundColor Red
}

try {
    $mavenVersion = mvn -version 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Maven ya está instalado:" -ForegroundColor Green
        Write-Host $mavenVersion[0] -ForegroundColor Cyan
        $mavenInstalled = $true
    }
} catch {
    Write-Host "✗ Maven no está instalado" -ForegroundColor Red
}

Write-Host ""

if ($javaInstalled -and $mavenInstalled) {
    Write-Host "¡Todo está listo! Puedes ejecutar la aplicación Spring Boot." -ForegroundColor Green
    Write-Host ""
    Write-Host "Comandos para ejecutar:" -ForegroundColor Yellow
    Write-Host "  mvn clean compile" -ForegroundColor Cyan
    Write-Host "  mvn spring-boot:run" -ForegroundColor Cyan
    exit 0
}

# Instalar Chocolatey si no está disponible
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Instalando Chocolatey..." -ForegroundColor Yellow
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    Write-Host "✓ Chocolatey instalado" -ForegroundColor Green
} else {
    Write-Host "✓ Chocolatey ya está instalado" -ForegroundColor Green
}

# Instalar Java si no está instalado
if (-not $javaInstalled) {
    Write-Host "Instalando Java 17..." -ForegroundColor Yellow
    choco install openjdk17 -y
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Java 17 instalado" -ForegroundColor Green
        
        # Configurar JAVA_HOME
        $javaPath = Get-ChildItem "C:\Program Files\OpenJDK" -Directory | Sort-Object Name -Descending | Select-Object -First 1
        if ($javaPath) {
            $env:JAVA_HOME = $javaPath.FullName
            [Environment]::SetEnvironmentVariable("JAVA_HOME", $javaPath.FullName, "Machine")
            Write-Host "✓ JAVA_HOME configurado: $($javaPath.FullName)" -ForegroundColor Green
        }
    } else {
        Write-Host "✗ Error al instalar Java" -ForegroundColor Red
        exit 1
    }
}

# Instalar Maven si no está instalado
if (-not $mavenInstalled) {
    Write-Host "Instalando Maven..." -ForegroundColor Yellow
    choco install maven -y
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Maven instalado" -ForegroundColor Green
    } else {
        Write-Host "✗ Error al instalar Maven" -ForegroundColor Red
        exit 1
    }
}

Write-Host ""
Write-Host "=== Instalación Completada ===" -ForegroundColor Green
Write-Host ""

# Refrescar variables de entorno
Write-Host "Refrescando variables de entorno..." -ForegroundColor Yellow
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# Verificar instalación
Write-Host "Verificando instalación..." -ForegroundColor Yellow
Write-Host ""

try {
    $javaVersion = java -version 2>&1
    Write-Host "✓ Java:" -ForegroundColor Green
    Write-Host $javaVersion[0] -ForegroundColor Cyan
} catch {
    Write-Host "✗ Error al verificar Java" -ForegroundColor Red
}

try {
    $mavenVersion = mvn -version 2>&1
    Write-Host "✓ Maven:" -ForegroundColor Green
    Write-Host $mavenVersion[0] -ForegroundColor Cyan
} catch {
    Write-Host "✗ Error al verificar Maven" -ForegroundColor Red
}

Write-Host ""
Write-Host "=== ¡Listo para usar! ===" -ForegroundColor Green
Write-Host ""
Write-Host "Ahora puedes ejecutar la aplicación Spring Boot:" -ForegroundColor Yellow
Write-Host "  1. mvn clean compile" -ForegroundColor Cyan
Write-Host "  2. mvn spring-boot:run" -ForegroundColor Cyan
Write-Host ""
Write-Host "La aplicación estará disponible en: http://localhost:8080" -ForegroundColor Yellow
Write-Host ""

# Preguntar si quiere ejecutar la aplicación
$response = Read-Host "¿Quieres ejecutar la aplicación ahora? (s/n)"
if ($response -eq "s" -or $response -eq "S" -or $response -eq "si" -or $response -eq "Si") {
    Write-Host "Compilando la aplicación..." -ForegroundColor Yellow
    mvn clean compile
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Compilación exitosa" -ForegroundColor Green
        Write-Host "Ejecutando la aplicación..." -ForegroundColor Yellow
        Write-Host "Presiona Ctrl+C para detener la aplicación" -ForegroundColor Cyan
        mvn spring-boot:run
    } else {
        Write-Host "✗ Error en la compilación" -ForegroundColor Red
    }
}
