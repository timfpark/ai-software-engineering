# Application Modernization

In this example we will walk through using Github Copilot to accelerate
migratation of a COBOL Mainframe application to a modern Java application.

## Legacy COBOL

1. Open [DBCBEX16.cbl](./cobol/DBCBEX16.cbl) in VSCode.
2. This is an COBOL application that implements a basic report from a DB2 table.
3. Let's ask Github Copilot what this COBOL application does:

```
Explain what this COBOL application does"
```

## Java

1. This repo has a simple maven based Java application.
2. We would like to have Github Copilot use the COBOL version of the report as a guide to create the same functionality in Java.
3. Open [App.java](./java/src/main/java/com/example/App.java) and the Github Copilot chat side panel and drag the `cobol/DBCBEX16.cbl` file over to the input text box and provide the following prompt:

```
Using the COBOL implementation in DBCBEX16.cbl as a guide, implement the same user interface in App.java"
```

4. Github Copilot will analyze the files and emit a new implementations for both App.java.
