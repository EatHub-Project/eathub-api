defmodule EathubWeb.ErrorViewTest do
  use EathubWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders 404.json" do
    assert render(EathubWeb.ErrorView, "404.json-api", []) ==
           %{"errors" => [%{code: 404, title: "Page not found"}], "jsonapi" => %{"version" => "1.0"}}
  end

  test "render 500.json" do
    assert render(EathubWeb.ErrorView, "500.json-api", []) ==
           %{"errors" => [%{code: 500, title: "Internal Server Error"}], "jsonapi" => %{"version" => "1.0"}}
  end

  test "render any other" do
    assert render(EathubWeb.ErrorView, "505.json-api", []) ==
           %{"errors" => [%{code: 505, title: "Internal Server Error"}], "jsonapi" => %{"version" => "1.0"}}
  end
end
