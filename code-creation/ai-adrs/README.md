# Architectural Decision Records with AI

One of the key mechanisms many engineering teams use to work and capture architectural and design decisions is the "Architectural Decision Record", which captures the conversation and outcome.

We can use Github Copilot to more quickly build these decision records and essentially act as another
software engineer in the project in terms of providing additional ideas to consider in a space.

To see how this works, create a new ADR in this directory, 001-frontend-framework.md. Let's assume we are a team that is building a frontend web application and we want to choose a framework.

1. Copy the contents of `000-template.md` and place it in `001-frontend-framework.md` such that we have the structure of the ADR we'd like.

2. Prompt Github Copilot in chat with the following:

   ```
   We are an engineering team that is building a single page web application. Please fill out this architectural decision record with some of the key frameworks we should be considering and make a recommendation.
   ```

3. Github Copilot will enumerate a set of frontend frameworks and provide some pros and cons for both. The team can then review and edit this feedback just like it was produced by another member of the development team.
