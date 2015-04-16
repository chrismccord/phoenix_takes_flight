defmodule Chat.Message do
  use Chat.Web, :model

  schema "messages" do
    field :body, :string
    field :user_id, :integer
    field :room_id, :string

    timestamps
  end

  @required_fields ~w(body room_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ nil) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
