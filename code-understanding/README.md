# Key Pattern: Github Copilot for Code Understanding

Let's imagine we are a new developer to the Kubernetes project and we've been asked to make a contribution to the project. We believe that we need to edit the file `server.go` but we want to learn more about the implementation there before we proceed.

Before AI, we would have reserved a day or two to sit down and read the code in depth and perhaps step our way through the code to see how it works in practice.

With Github Copilot, we can now have a super experienced pair programmer that we can have a conversation with about this code.

1. Open [server.go](./server.go) and prompt Github Copilot:

"At a high level, what functionality does this file provide?"

Github Copilot should talk you through a list of critical functions that this implementation provides that gives us a good high level overview of the implementation.

2. Let's say that we have been asked to work on the `run` function in `server.go`, so let's focus in ask Github Copilot about that:

"Give me an explanation of how the run function works"

Github Copilot should talk you through a simple flow for how the implementation works that helps you understand the overall implementation.
