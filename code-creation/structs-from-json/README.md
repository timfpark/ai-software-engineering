# Code Creation

One of the core activities of a software engineer is to generate new code. In this exercise, we will build the code needed to deserialize the complex JSON response found in [response.json](./src/serialization/booking/fixture/response.json) into a set of Rust structs.

Normally, building serialization objects like this for a complex JSON payload that doesn't have an Open API specification is hard, error-prone work. In a world without AI, we could reasonably expect that it would take several days.

With GitHub Copilot, however, we can quickly generate those data structures.

1. Open [flights.rs](./src/serialization/booking/flights.rs). This file should be empty. We would like to generate the implementation here for these Rust structures.
2. Open GitHub Copilot chat and drag and drop `response.json` onto the chat input box. Then change the model to Claude 3.5 Sonnet (which I have found works better for these tasks than GPT-4o), and prompt GitHub Copilot with:

   ```
   Please implement Rust structs that decode the JSON objects in response.json using the serde deserialization library. The structs should be idiomatic Rust (use snake_casing, etc.).
   ```

3. This should generate Rust structs that can decode this JSON response. However, this doesn't need to be the end of our journey. We can continue our conversation with AI to create the PostgreSQL tables we need to persist these structs. Open [20250206002301_add_tables.up.sql](./migrations/20250206002301_add_tables.up.sql), a SQLX database migration script, and use the following prompt to...
