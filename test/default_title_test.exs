defmodule DefaultTitleTest do
  use ExUnit.Case
  doctest DefaultTitle

  test "default title" do
    assert title_for(nil, nil) == "AppName"
  end

  test "basic titles" do
    assert title_for(TagController, :index)  == "Tag List | AppName"
    assert title_for(TagController, :edit)   == "Editing Tag | AppName"
    assert title_for(TagController, :update) == "Editing Tag | AppName"
    assert title_for(TagController, :show)   == "Viewing Tag | AppName"
    assert title_for(TagController, :create) == "Create New Tag | AppName"
    assert title_for(TagController, :foobar) == "Tag | AppName"
  end

  test "overriding resource name" do
    defmodule MisnamedTagController do
      def __title_resource_name, do: "Tag"
    end

    assert title_for(MisnamedTagController, :edit) == "Editing Tag | AppName"
  end

  test "specifying options" do
    assert title_for(TagController, :index, separator: "-")     == "Tag List - AppName"
    assert title_for(TagController, :index, suffix: "Foo inc.") == "Tag List | Foo inc."
    assert title_for(TagController, :index, suffix: :none)      == "Tag List"
  end

  defp title_for(controller, action, options \\ []) do
    conn = conn(controller, action)

    DefaultTitle.default_title(conn, options)
  end

  defp conn(controller, action) do
    %Plug.Conn{}
    |> Plug.Conn.put_private(:phoenix_endpoint, AppName.Endpoint)
    |> put_private_if_not_nil(:phoenix_controller, controller)
    |> put_private_if_not_nil(:phoenix_action, action)
  end

  defp put_private_if_not_nil(conn, _, nil),
    do: conn
  defp put_private_if_not_nil(conn, key, value),
    do: Plug.Conn.put_private(conn, key, value)
end
