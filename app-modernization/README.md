# Application Modernization

In this example we will walk through using Github Copilot to accelerate
migratation of a very old legacy Motif X11 application to a modern
React web application.

## Legacy Application

1. Open [tic-tac-toe.c](./motif/tic-tac-toe.c) in VSCode.
2. This is a Motif X11 application that implements a basic Tic Tac Toe application. Understand the code better using Github Copilot:

```
Explain what user interface this application provides to the user"
```

## React Application

1. This repo has a simple [create react application](https://create-react-app.dev) template for a React web application.
2. We would like to have Github Copilot use the Motif application as a guide to create the same functionality in React.
3. Open [App.js](./react/src/App.js) and the Github Copilot chat side panel and drag the motif/tic-tac-toe.c file over to the input text box and provide the following prompt:

```
Using the Motif implementation in tic-tac-toe.c as a guide, implement the same user interface in App.js"
```

4. Github Copilot will analyze the files and emit new implementations for both App.js and App.css. Open these files and apply the implementations.

5. From the command line, enter the react directory, and execute:

```
$ npm install
$ npm start
```

6. A window will open that exposes a simple Tic Tac Toe interface.
