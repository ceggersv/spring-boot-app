# Guía de Instalación para Spring Boot

## Requisitos Previos

Para ejecutar esta aplicación Spring Boot, necesitas instalar:

1. **Java Development Kit (JDK) 17 o superior**
2. **Apache Maven 3.6 o superior**

## Paso 1: Instalar Java (JDK)

### Opción A: Descarga Manual
1. Ve a [Oracle JDK](https://www.oracle.com/java/technologies/downloads/) o [OpenJDK](https://adoptium.net/)
2. Descarga JDK 17 o superior para Windows x64
3. Ejecuta el instalador y sigue las instrucciones
4. **IMPORTANTE**: Anota la ruta de instalación (ej: `C:\Program Files\Java\jdk-17`)

### Opción B: Usando Chocolatey (Recomendado)
```powershell
# Instalar Chocolatey primero (ejecutar como administrador)
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Instalar Java
choco install openjdk17
```

### Opción C: Usando Scoop
```powershell
# Instalar Scoop primero
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
irm get.scoop.sh | iex

# Instalar Java
scoop install openjdk17
```

## Paso 2: Configurar Variables de Entorno

### Configurar JAVA_HOME
1. Abre "Variables de entorno del sistema" (Win + R, escribir `sysdm.cpl`)
2. Click en "Variables de entorno..."
3. En "Variables del sistema", click "Nueva..."
4. Nombre de la variable: `JAVA_HOME`
5. Valor de la variable: Ruta donde instalaste Java (ej: `C:\Program Files\Java\jdk-17`)
6. Click "Aceptar"

### Agregar Java al PATH
1. En la misma ventana, busca la variable "Path" en "Variables del sistema"
2. Click "Editar..."
3. Click "Nuevo..."
4. Agrega: `%JAVA_HOME%\bin`
5. Click "Aceptar" en todas las ventanas

### Verificar la instalación
Abre una **nueva** ventana de PowerShell y ejecuta:
```powershell
java -version
javac -version
echo $env:JAVA_HOME
```

## Paso 3: Instalar Maven

### Opción A: Descarga Manual
1. Ve a [Apache Maven](https://maven.apache.org/download.cgi)
2. Descarga el archivo binario (apache-maven-3.9.x-bin.zip)
3. Extrae en `C:\Program Files\Apache\maven`
4. Configura la variable de entorno `MAVEN_HOME` apuntando a esta carpeta
5. Agrega `%MAVEN_HOME%\bin` al PATH

### Opción B: Usando Chocolatey
```powershell
choco install maven
```

### Opción C: Usando Scoop
```powershell
scoop install maven
```

### Verificar la instalación
```powershell
mvn -version
```

## Paso 4: Ejecutar la Aplicación

Una vez que tengas Java y Maven instalados:

### 1. Navegar al proyecto
```powershell
cd "C:\Users\lenovo\camunda-mtec\spring-boot-app"
```

### 2. Compilar el proyecto
```powershell
mvn clean compile
```

### 3. Ejecutar la aplicación
```powershell
mvn spring-boot:run
```

### 4. Verificar que funcione
- La aplicación estará disponible en: http://localhost:8080
- Health check: http://localhost:8080/api/usuarios/health
- Consola H2: http://localhost:8080/h2-console

## Solución de Problemas

### Error: "java no se reconoce como comando"
- Verifica que JAVA_HOME esté configurado correctamente
- Verifica que `%JAVA_HOME%\bin` esté en el PATH
- Reinicia la ventana de PowerShell

### Error: "mvn no se reconoce como comando"
- Verifica que MAVEN_HOME esté configurado correctamente
- Verifica que `%MAVEN_HOME%\bin` esté en el PATH
- Reinicia la ventana de PowerShell

### Error de puerto en uso
- Cambia el puerto en `src/main/resources/application.properties`
- O termina procesos que usen el puerto 8080

### Error de permisos
- Ejecuta PowerShell como administrador
- Verifica permisos en la carpeta del proyecto

## Comandos Útiles

```powershell
# Ver variables de entorno
echo $env:JAVA_HOME
echo $env:MAVEN_HOME
echo $env:PATH

# Limpiar y compilar
mvn clean compile

# Ejecutar tests
mvn test

# Empaquetar la aplicación
mvn clean package

# Ejecutar con perfil específico
mvn spring-boot:run -Dspring.profiles.active=dev
```

## Recursos Adicionales

- [Documentación oficial de Spring Boot](https://spring.io/projects/spring-boot)
- [Guía de Maven](https://maven.apache.org/guides/)
- [Documentación de Java](https://docs.oracle.com/en/java/)
