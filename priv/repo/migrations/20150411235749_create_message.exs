defmodule Chat.Repo.Migrations.CreateMessage do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :body, :text
      add :user_id, :integer
      add :room_id, :string

      timestamps
    end
    create index(:messages, [:user_id])
    create index(:messages, [:room_id])
  end
end
