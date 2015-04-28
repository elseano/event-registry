defmodule EventRegistry.Repo.Migrations.CreateEvent do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string
      add :data, :json

      timestamps updated_at: false
    end
  end
end
