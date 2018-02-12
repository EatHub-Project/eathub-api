defmodule EathubWeb.V1.UserView do
  use EathubWeb, :view
  alias EathubWeb.V1.UserView

  attributes [:id, :display_name, :language, :avatar, :website]
end
