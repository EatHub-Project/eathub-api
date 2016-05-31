ExUnit.start

Mix.Task.run "ecto.create", ~w(-r EathubApi.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r EathubApi.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(EathubApi.Repo)

