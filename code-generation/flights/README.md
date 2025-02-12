# Code Generation

Of course, one of the core activities of a software engineer is to generate new code. In this exercise, we will look at building the code we need to deserialization the complex JSON response found in [response.json](./src/serialization/booking/fixture/response.json) into a set of Rust structs.

Normally building serialization objects like this for a complex JSON payload that doesn't have an Open API specification is hard, error prone work, and in a world without AI we could reasonably expect that it would take several days.

With Github Copilot however, we now can quickly generate those data structures.

1. Open [flights.rs](./src/serialization/booking/flights.rs). This should be empty. We would like to generate the implementation here for these Rust structures.
2. Open Github Copilot chat and drag and drop `response.json` onto the chat input box. Then change the model to Claude 3.5 Sonnet (which I have found works better for these tasks than GPT-4o), and prompt Github Copilot with:

"Please implement Rust structs that decode the JSON objects in response.json using the serde deserialization library. The structs should idiomatic Rust (use snake_casing, etc.)"

3. This should generate idiomatic Rust structs. Accept these changes to flights.rs. We obviously want some way to validate these structs are correct of course, so let's generate some tests:

"Please add tests that use the fixture in fixture/response.json to test deseralization of these structs."

4. Run the tests in a command line at the root of the `flights` directory:

```
$ cargo test
```

5. We will probably find here that although Github Copilot has taken a task that usually takes a day and makes it a 10 minute job, that we will still need to intervene manually to fix test cases where it might might hallucinate the wrong values from the JSON file.

6. What we have seen here is how development is becoming more of a conversation that we have with the computer as a pair programmer.

7. We can continue from here and experiment on having it generate database tables from our structures by opening [up.sql](./migrations/20250206002301_add_tables.up.sql), dragging over the newly created flights.rs file and prompting:

"Create PostgreSQL database tables for these Rust structs"
