use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :chat, Chat.Endpoint,
  secret_key_base: "5WDinXc/FIDpJ5tH5muhSzjvfJc0JaNJEpKbqQ8C7od11sP/4NPobrzPtQc7r+P/"

# Configure your database
config :chat, Chat.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "chat_prod"
