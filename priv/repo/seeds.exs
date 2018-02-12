# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Eathub.Repo.insert!(%Eathub.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Eathub.Repo
alias Eathub.Accounts.User
alias Eathub.Recipes.Recipe
alias Eathub.Recipes.Step
alias Eathub.Recipes.Ingredient

user = Repo.insert!(%User{display_name: "user", password: "pass", email: "email", language: "language", avatar: "avatar", website: "web", provider: "provider"})
recipe = Repo.insert!(%Recipe{title: "titulo", description: "description", main_image: "main image", serves: 1, time: 1, notes: "notas", language: "lengua", user: user})
step_1 = Repo.insert!(%Step{text: "paso 1", image: "image", position: 0, recipe: recipe})
step_2 = Repo.insert!(%Step{text: "paso 2", image: "image 2", position: 1, recipe: recipe})
ingredient_1 = Repo.insert!(%Ingredient{text: "tomate", position: 0, recipe: recipe})
ingredient_2 = Repo.insert!(%Ingredient{text: "pimienta", position: 1, recipe: recipe})
