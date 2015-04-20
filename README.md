# Phoenix Takes Flight - Chat

## Set Up

1. `$ git clone git@github.com:chrismccord/phoenix_takes_flight.git chat`
2. `$ cd chat`
3. `$ mix deps.get`
4. `$ npm install`
5. Configure your postgres credentials in `dev.exs` and `test.exs`

  ```elixir
  # Configure your database
  config :chat, Chat.Repo,
    adapter: Ecto.Adapters.Postgres,
    username: "postgres",
    password: "postgres",
    database: "chat_dev"
  ```
6. Create your dev and test database `$ mix ecto.create`
7. Run the migrations `$ mix ecto.migrate`
8. Start Phoenix endpoint with `$ mix phoenix.server`

Now you can visit `localhost:4000` from your browser, and if you receive the following output you're all set!

```console
$ mix phoenix.server
[info] Running Chat.Endpoint with Cowboy on port 4000 (http)
19 Apr 22:02:20 - info: compiled 4 files into 2 files in 537ms
```
