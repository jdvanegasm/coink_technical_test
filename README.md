# coink_technical_test - English
### Backend developer technical test for Coink: a startup fintech.
### Prueba tecnica de desarrollador Backend para coink: una startup financiera.

# Proyect Structure
## Branches:
You are going to find three branches: main, documentation and development.
Time ago I where working the database scripts into a dedicated branch but it wasnt really necessary so I decided to merge it with development.

## Folders:
You will find three principal folders wich are: 
- coink_api: API source Folder (We will review it in a moment)
- docs: Entity Relationship Diagram and into "api_test_images" some images of the API testing
- scripts:
-   database setup script called "coink_db_setup.sql", it contains the whole database creation script
-   database integrity test into "coink_db_integrity_test.sql", its just some insertions and queries to check constrains and keys integrity
-   database population data into "coink_test_data.sql"
-   database stored procedures script called "coink_stored_procedures.sql", you have to check that there is no other stored procedures related with the database before you run it.
-   database stored procedures testing into "coink_sp_test.sql"

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
# Specifications and settings files
Ignoring the core project api files that the command "dotnet new webapi -n MyAPI" creates, there is just 3 really important configuration archives to get the server and the API up:
1. Program.cs
2. appsettings.json
3. launchSettings.json
You have into coink_api folder the first one and the last one but not the second one because of environment variables, then Im going to leave you the template so you can run the project.

### appsettings.json
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
