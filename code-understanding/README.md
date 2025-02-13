# Using AI to Accelerate Code Understanding

Imagine you are a new developer to the Kubernetes project and you've been asked to make a contribution. You believe that you need to edit the file `server.go`, but you want to learn more about its implementation before proceeding.

Before AI, you would have reserved a day or two to sit down, read the code in depth, and perhaps step through the code to see how it works in practice.

With GitHub Copilot, you now have a super experienced pair programmer that you can converse with about this code.

## Steps to Understand and Refactor Code with GitHub Copilot

1. **Get a High-Level Overview**

   Open [server.go](./server.go) in VSCode and prompt GitHub Copilot:

   ```
   At a high level, what functionality does this file provide?
   ```

   GitHub Copilot will talk you through a list of critical functions that this implementation provides, giving you a good high-level overview of the implementation.

2. **Understand a Specific Function**

   Let's say you have been asked to work on the `run` function in `server.go`. Focus in and ask GitHub Copilot:

   ```
   Give me an explanation of how the run function works.
   ```

   GitHub Copilot will talk you through a simple flow of how the implementation works, helping you understand the overall implementation.

3. **Refactor a Large Function**

   You've been asked to simplify the very large `run` function. You can ask GitHub Copilot for its ideas with:

   ```
   Refactor the run function to be simpler by breaking out key chunks of code into separate functions. Only break out a function if the function would contain significant amounts of code.
   ```

   GitHub Copilot will suggest a refactoring of the `run` function that makes it simpler and easier to understand.
