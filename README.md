# **Coink Technical Test - English**
### Backend Developer Technical Test for Coink: A Fintech Startup.
This repository contains the backend technical test for Coink, a financial technology startup.

---

# Proyect Structure
## Branches:
The repository contains three main branches:
1. **main**: The primary branch.
2. **documentation**: Dedicated to project documentation.
3. **development**: Used for ongoing development work.

Previously, database scripts were managed in a separate branch. However, this was deemed unnecessary, and those changes were merged into the `development` branch.

---

## **Folders**
The project includes three principal folders:

1. **coink_api**: 
   - Contains the API source code. This folder will be discussed in detail later.

2. **docs**: 
   - Includes the **Entity-Relationship Diagram (ERD)**.
   - Contains API testing images within the `api_test_images` subfolder.

3. **scripts**:
   - **`coink_db_setup.sql`**: The main database creation script.
   - **`coink_db_integrity_test.sql`**: Script for testing database constraints and key integrity through insertions and queries.
   - **`coink_test_data.sql`**: Script for populating the database with test data.
   - **`coink_stored_procedures.sql`**: Contains all stored procedures for the database. Ensure there are no duplicate procedures before running it.
   - **`coink_sp_test.sql`**: Script for testing stored procedures functionality.

---

### DISCLAIMER
If you are using **DBeaver**, it is recommended to set up the database name directly in the PostgreSQL connection. This is necessary because **DBeaver** does not support commands like `\c coink_db` to switch between databases and perform operations on a newly created schema or database.
### Steps to Follow
1. Configure the PostgreSQL connection to point directly to the database you want to use (`coink_db`).
2. Comment out the lines related to creating and dropping the database in the script to avoid conflicts with DBeaver:

```postgresql
   --- drop database if exist coink_db;
   --- create database coink_db;
```

3. Once connected to the database, you can execute the following operations and the whole script will run well:

```postgresql
	drop schema if exists public cascade;
	create schema public
```
### Additional Notes
If you use a client that supports the `\c` command, such as `psql`, the original script will work
``` postgresql
drop database if exist coink_db;
create database coink_db;

\c coink_db;

drop schema if exist public cascade;
create schema public;
```
---

# **Specifications and Configuration Files**
Apart from the core project files generated by running the command `dotnet new webapi -n MyAPI`, there are three essential configuration files needed to run the server and API:
1. **Program.cs**
2. **appsettings.json**
3. **launchSettings.json**

The first and third files are already present in the **coink_api** folder. However, the **appsettings.json** file is excluded due to environment variable considerations. Below is a template to set up the project:

---

### **appsettings.json Template**
To run the project, create an `appsettings.json` file in the **coink_api** folder with the following structure:
```json
{
  "Logging": {
    "LogLevel": {
      "Default": "Information",
      "Microsoft.AspNetCore": "Warning"
    }
  },
  "AllowedHosts": "*",
  
  "ConnectionStrings": {
    "DefaultConnection": "Host=localhost;Database=coink_db;Username=your_username;Password=your_password"
  }
}
```

Replace `your_username` and `your_password` with your PostgreSQL credentials.

---

# API source
I developed this project thinking in a layered architecture to can keep separated the responsibilities, however, you will find some elements of other patterns or architecture, so this is a pretty quick review:
#### **1. bin**
- **Description**: Automatically generated during the build process.
- **Contents**: Compiled files like `.dll` and `.exe`.
- **Usage**: Managed by .NET; no need for manual changes here.

---

#### **2. Common**
- **Description**: Contains shared utilities or classes used across multiple layers of the project.
- **Typical Contents**:
  - Classes like `ServiceResult` for standardized responses.
  - Global constants or enumerations.

---

#### **3. Controllers**
- **Description**: Handles incoming HTTP requests.
- **Contents**:
  - **`LocationController.cs`**: Handles requests related to countries, regions, and municipalities.
  - **`UsersController.cs`**: Manages user-related operations.
- **Responsibility**:
  - Acts as the entry point for the client (e.g., Postman or Swagger) and delegates work to the service layer.

---

#### **4. Data**
- **Description**: Contains database-related classes.
- **Contents**:
  - **`ApplicationDbContext.cs`**: Defines how the app interacts with the database using Entity Framework.
- **Responsibility**:
  - Configures tables, relationships, and other database settings.

---

#### **5. DTOs (Data Transfer Objects)**
- **Description**: Defines simplified models used to transfer data between layers.
- **Contents**:
  - Files like **`CountryDto.cs`**, **`MunicipalityDto.cs`**, **`RegionDto.cs`**, **`UserByLocationDto.cs`**.
- **Responsibility**:
  - Acts as a lightweight structure to exchange data between layers without exposing the database models directly.
  - Reduces coupling between the database and upper layers.

---

#### **6. Middleware**
- **Description**: Contains custom components for request and response handling.
- **Contents**:
  - **`ExceptionMiddleware.cs`**: Globally handles unhandled exceptions and provides consistent responses to clients.
- **Responsibility**:
  - Centralizes error handling.
  - Adds features like logging or authorization for every request.

---

#### **7. Models**
- **Description**: Represents the database tables as classes.
- **Contents**:
  - Classes like **`Country.cs`**, **`Region.cs`**, **`User.cs`**, etc.
- **Responsibility**:
  - Mirrors the database schema.
  - Used in `ApplicationDbContext` for database interaction.

---

#### **8. obj**
- **Description**: Temporary files created during the build process.
- **Contents**:
  - Intermediate files used by the .NET compiler.
- **Usage**: Similar to `bin`, this is managed automatically and requires no manual intervention.

---

#### **9. Properties**
- **Description**: Contains configuration files related to the assembly.
- **Contents**:
  - **`launchSettings.json`**: Defines local development settings like ports and profiles.
- **Usage**: Used for local debugging and testing configurations.

---

#### **10. Services**
- **Description**: Contains business logic and service implementations.
- **Contents**:
  - **Interfaces**: **`ILocationService.cs`**, **`IUserService.cs`**.
  - **Implementations**: **`LocationService.cs`**, **`UserService.cs`**.
- **Responsibility**:
  - Implements logic for handling core operations (e.g., user registration, location validation).
  - Acts as the intermediary between controllers and data.

---

#### **11. Root Files**
- **`appsettings.json`**: Global configuration file for the project (e.g., database connection strings).
- **`coink_api.csproj`**: Project configuration file used by .NET during compilation.
- **`Program.cs`**: The entry point of the application; configures services and middleware during startup.

---
# **Prueba Tecnica de Coink - Español**
### Prueba técnica de Backend Developer para Coink: Una startup fintech.
Este repositorio contiene la prueba técnica de backend para Coink, una startup de tecnología financiera.

---

# Estructura del Proyecto
## Ramas:
El repositorio contiene tres ramas principales:
1. **main**: La rama principal.
2. **documentation**: Dedicada a la documentación del proyecto.
3. **development**: Utilizada para el trabajo de desarrollo en curso.

Anteriormente, los scripts de base de datos se gestionaban en una rama separada. Sin embargo, lo consideré innecesario y esos cambios fueron fusionados en la rama `development`.

---

## **Carpetas**
El proyecto incluye tres carpetas principales:

1. **coink_api**: 
   - Contiene el código fuente de la API. Esta carpeta se detallará más adelante.

2. **docs**: 
   - Incluye el **Diagrama de Entidad-Relación (ERD)**.
   - Contiene imágenes de prueba de la API en la subcarpeta `api_test_images`.

3. **scripts**:
   - **`coink_db_setup.sql`**: El script principal para crear la base de datos.
   - **`coink_db_integrity_test.sql`**: Script para probar las restricciones de la base de datos y la integridad de las claves mediante inserciones y consultas.
   - **`coink_test_data.sql`**: Script para poblar la base de datos con datos de prueba.
   - **`coink_stored_procedures.sql`**: Contiene todos los procedimientos almacenados para la base de datos. Asegúrate de que no haya procedimientos duplicados antes de ejecutarlo.
   - **`coink_sp_test.sql`**: Script para probar la funcionalidad de los procedimientos almacenados.

---

### Advertencia!
Si estás utilizando **DBeaver**, recomiendo configurar el nombre de la base de datos directamente en la conexión de PostgreSQL. Esto es necesario porque **DBeaver** no soporta comandos como `\c coink_db` para cambiar entre bases de datos y realizar operaciones en un esquema o base de datos recién creada.

### Pasos a seguir
1. Configura la conexión de PostgreSQL para apuntar directamente a la base de datos que deseas usar (`coink_db`).
2. Comenta las líneas relacionadas con la creación y eliminación de la base de datos en el script para evitar conflictos con DBeaver:

```postgresql
   --- drop database if exist coink_db;
   --- create database coink_db;
```
3. Una vez conectado a la base de datos, puedes ejecutar las siguientes operaciones y todo el script se ejecutará correctamente:
```postgresql
	drop schema if exists public cascade;
	create schema public
```
### Nota:
Si utilizas un cliente que soporte el comando `\c`, como `psql`, el script original funcionará:

```postgresql
drop database if exist coink_db;
create database coink_db;

\c coink_db;

drop schema if exist public cascade;
create schema public;
```
# **Especificaciones y Archivos de Configuración**
Aparte de los archivos principales del proyecto generados al ejecutar el comando `dotnet new webapi -n MyAPI`, hay tres archivos prioritarios para levantar el servidor y la API:
1. **Program.cs**
2. **appsettings.json**
3. **launchSettings.json**

El primero y el tercero ya están presentes en la carpeta **coink_api**. Sin embargo, el archivo **appsettings.json** está excluido debido a consideraciones sobre variables de entorno. A continuación, se muestra una plantilla para configurar el proyecto:

---

### **Plantilla de appsettings.json**
Para ejecutar el proyecto, crea un archivo `appsettings.json` en la carpeta **coink_api** con la siguiente estructura:

```json
{
  "Logging": {
    "LogLevel": {
      "Default": "Information",
      "Microsoft.AspNetCore": "Warning"
    }
  },
  "AllowedHosts": "*",
  
  "ConnectionStrings": {
    "DefaultConnection": "Host=localhost;Database=coink_db;Username=your_username;Password=your_password"
  }
}
```

Reemplaza `your_username` y `your_password` con tus credenciales de PostgreSQL.

---

# Fuente de la API
Desarrollé este proyecto pensando en una arquitectura por capas para mantener separadas las responsabilidades. Sin embargo, encontrarás algunos elementos de otros patrones o arquitecturas, así que esta es una revisión rápida:

#### **1. bin**
- **Descripción**: Generado automáticamente durante el proceso de compilación.
- **Contenido**: Archivos compilados como `.dll` y `.exe`.
- **Uso**: Gestionado por .NET; no es necesario realizar cambios manuales aquí.

---

#### **2. Common**
- **Descripción**: Contiene utilidades o clases compartidas usadas en varias capas del proyecto.
- **Contenido típico**:
  - Clases como `ServiceResult` para respuestas estandarizadas.
  - Constantes globales o enumeraciones.

---

#### **3. Controllers**
- **Descripción**: Maneja las solicitudes HTTP entrantes.
- **Contenido**:
  - **`LocationController.cs`**: Maneja las solicitudes relacionadas con países, regiones y municipios.
  - **`UsersController.cs`**: Administra operaciones relacionadas con usuarios.
- **Responsabilidad**:
  - Actúa como el punto de entrada para el cliente (por ejemplo, Postman o Swagger) y delega el trabajo a la capa de servicios.

---

#### **4. Data**
- **Descripción**: Contiene las clases relacionadas con la base de datos.
- **Contenido**:
  - **`ApplicationDbContext.cs`**: Define cómo la aplicación interactúa con la base de datos utilizando Entity Framework.
- **Responsabilidad**:
  - Configura tablas, relaciones y otros ajustes de la base de datos.

---

#### **5. DTOs (Objetos de Transferencia de Datos)**
- **Descripción**: Define modelos simplificados usados para transferir datos entre capas.
- **Contenido**:
  - Archivos como **`CountryDto.cs`**, **`MunicipalityDto.cs`**, **`RegionDto.cs`**, **`UserByLocationDto.cs`**.
- **Responsabilidad**:
  - Actúa como una estructura ligera para intercambiar datos entre capas sin exponer directamente los modelos de la base de datos.
  - Reduce el acoplamiento entre la base de datos y las capas superiores.

---

#### **6. Middleware**
- **Descripción**: Contiene componentes personalizados para el manejo de solicitudes y respuestas.
- **Contenido**:
  - **`ExceptionMiddleware.cs`**: Maneja globalmente las excepciones no controladas y proporciona respuestas consistentes a los clientes.
- **Responsabilidad**:
  - Centraliza el manejo de errores.
  - Agrega características como logging o autorización para cada solicitud.

---

#### **7. Models**
- **Descripción**: Representa las tablas de la base de datos como clases.
- **Contenido**:
  - Clases como **`Country.cs`**, **`Region.cs`**, **`User.cs`**, etc.
- **Responsabilidad**:
  - Refleja el esquema de la base de datos.
  - Usado en `ApplicationDbContext` para la interacción con la base de datos.

---

#### **8. obj**
- **Descripción**: Archivos temporales creados durante el proceso de compilación.
- **Contenido**:
  - Archivos intermedios utilizados por el compilador de .NET.
- **Uso**: Similar a `bin`, esto se gestiona automáticamente y no requiere intervención manual.

---

#### **9. Properties**
- **Descripción**: Contiene archivos de configuración relacionados con el ensamblaje.
- **Contenido**:
  - **`launchSettings.json`**: Define configuraciones de desarrollo local, como puertos y perfiles.
- **Uso**: Usado para configuraciones de depuración y pruebas locales.

---

#### **10. Services**
- **Descripción**: Contiene la lógica de negocio e implementaciones de servicios.
- **Contenido**:
  - **Interfaces**: **`ILocationService.cs`**, **`IUserService.cs`**.
  - **Implementaciones**: **`LocationService.cs`**, **`UserService.cs`**.
- **Responsabilidad**:
  - Implementa la lógica para manejar operaciones clave (por ejemplo, registro de usuarios, validación de ubicaciones).
  - Actúa como el intermediario entre los controladores y los datos.

---

#### **11. Archivos raíz**
- **`appsettings.json`**: Archivo de configuración global del proyecto (por ejemplo, cadenas de conexión de la base de datos).
- **`coink_api.csproj`**: Archivo de configuración del proyecto utilizado por .NET durante la compilación.
- **`Program.cs`**: El punto de entrada de la aplicación; configura servicios y middleware durante el inicio.
