## Record Store Application

This repository contains an ASP.NET MVC application for a simple record store, showcasing basic CRUD (Create, Read, Update, Delete) operations to manage music records using SQL Server for database storage. It is mostly used for demonstrating how to deploy a web application on Azure.

### Prerequisites

- **.NET SDK**: Version 4.8 or higher (for ASP.NET MVC applications).
- **SQL Server**: SQL Server 2017 or newer.

### Installation

**Database Setup**

- Set up a new SQL Server database named `chinook`.
- Import data located at [SQL/chinook.sql](SQL/chinook.sql) into the database.

**Application Configuration**

Update the `<connectionStrings>` section at [WebApplication8/Web.config](WebApplication8/Web.config) with database server details. Replace placeholders such as `{sql_server}`, `{sql_server_username}`, and `{sql_server_password}` with the actual SQL Server configurations:
   ```
    <connectionStrings>
      <add name="ChinookEntities" connectionString="metadata=res://*/Models.Model1.csdl|res://*/Models.Model1.ssdl|res://*/Models.Model1.msl;provider=System.Data.SqlClient;provider connection string=&quot;data source=tcp:{sql_server},1433;initial catalog=chinook;User Id={sql_server_username};Password={sql_server_password};integrated security=False;MultipleActiveResultSets=True;App=EntityFramework&quot;" providerName="System.Data.EntityClient" />
    </connectionStrings>
   ```
