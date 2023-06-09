# Spring Boot Liquibase Application

## Background

The example projects demonstrates how to use Spring Boot in combination with Liquibase to manage database change sets.
This application can run as part of a build process or as an executable jar.

## Running using liquibase CLI
```
liquibase --changelog-file={changelogfile} --url={url} update
```

For example:
```
liquibase --changelog-file=db/changelog/changelog.xml --url=jdbc:postgresql://localhost:5432/wierd_arts update-sql
````
### Useful cli commands
```
liquibase tag version1
liquibase --changelog-file=db/changelog/changelog.xml update-sql
liquibase --changelog-file=db/changelog/changelog.xml rollback-sql version1
liquibase --changelog-file=db/changelog/changelog.xml rollback version1
```

### Not so useful cli commands
```
liquibase --changelog-file=db/changelog/changelog.xml db-doc mychangelogDocs
```

## Running as a Maven Build

This can be helpful as part of your build process during development. Doing a Maven compile with the liquibase profile
active along with the required arguments:
```
mvn compile -Pliquibase -DdbUrl=[dbUrl] -DdbUser=[dbUser] -DdbPwd=[dbPwd] -DdropFirst==[dropFirst]
```

For example:
```
mvn compile -Pliquibase -DdbUrl=jdbc:postgresql://localhost:5432/postgres -DdbUser=postgres -DdbPwd=postgres -DdropFirst=true
````

## Running as an Executable JAR

When it comes time to go to production, and an installation needs to happen, running as an executable JAR can be a good
option.

1. Package the application

```
mvnw package
```

1. Run the application with the required arguments

```
java -jar spring-boot-liquibase-1.0-SNAPSHOT.jar --dbUrl=[dbUrl] --dbUser=[dbUser] --dbPwd=[dbPwd] --dropFirst=[dropFirst]
```

For example:

```
java -jar target/spring-boot-liquibase-1.0-SNAPSHOT.jar --dbUrl=jdbc:postgresql://localhost:5432/test_db --dbUser=postgres --dbPwd=postgres --dropFirst=true
```

## Database Change Log Tables

This example uses a PostgreSQL database. After the liquibase changes have run two tables will exist in the public
schema:

1. **databasechangelog** - A log of all the liquibase change sets run
1. **databasechangeloglock** - A table that is checked to get a lock to avoid multiple liquibase instances happening
   at the same time

Liquibase creates these tables.

## Organizing Liquibase Change Set

The application looks at what change sets are in resources/liquibase/master.xml.
This application has a simple schema.xml and table.xml for loading schema and table change sets. This could be expanded
to have alter scripts, indexing scripts, or whatever you need for your database change sets. How you want to organize
those files is entirely up to you. Just know that master.xml is the entry point for all changes.

## Using Other Databases

It's simple to use other databases besides PostgreSQL with this application. In the pom.xml locate the PostgreSQL
database driver runtime dependency. Replace that with the database driver you need.

```xml
<!--Provided, Runtime, and Optional Dependencies Below-->
<dependency>
    <groupId>org.postgresql</groupId>
    <artifactId>postgresql</artifactId>
    <scope>runtime</scope>
</dependency>
```

## Best Practices
Validating a Rollback
To ensure safe and predictable rollbacks, test the rollback in a development environment. A complete test cycle should include:
- Deploy the changes to the database then validate that they were deployed.
- Roll back the changes, validate the changes were undone, and the database was brought back to the previous state.
- Redeploy all changes to the database.


The final step of redeploying the changes to the database is to verify that the rollback did not miss changes that would impact a future deployment. 