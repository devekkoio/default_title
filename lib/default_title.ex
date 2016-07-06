defmodule DefaultTitle do
  def default_title(%Plug.Conn{} = conn, opts \\ []) when is_list(opts) do
    suffix    = opts[:suffix] || default_app_title(conn)
    separator = Keyword.get(opts, :separator, "|")

    action = action_name(conn)
    resource = conn |> controller_module() |> resource_name()

    title = make_title(action, resource)

    title_with_suffix(title, separator, suffix)
  end

  defp title_with_suffix(title, _separator, :none),
    do: to_string(title)
  defp title_with_suffix(nil, _separator, suffix),
    do: to_string(suffix)
  defp title_with_suffix(title, separator, suffix),
    do: "#{title} #{separator} #{suffix}"

  defp make_title(nil, _),
    do: nil
  defp make_title(:index, resource),
    do: "#{resource} List"
  defp make_title(:create, resource),
    do: "Create New #{resource}"
  defp make_title(:edit, resource),
    do: "Editing #{resource}"
  defp make_title(:update, resource),
    do: "Editing #{resource}"
  defp make_title(:show, resource),
    do: "Viewing #{resource}"
  defp make_title(_, resource),
    do: resource

  defp resource_name(nil),
    do: nil
  defp resource_name(module) do
    case read_resource_name(module) do
      nil ->
        module
        |> Module.split
        |> List.last
        |> to_string
        |> String.replace_suffix("Controller", "")
      item ->
        item
    end
  end

  defp read_resource_name(module) do
    if function_exported?(module, :__title_resource_name, 0) do
      module.__title_resource_name
    end
  end

  # Returns a default suffix, based on the endpoint module’s root
  defp default_app_title(conn) do
    case endpoint_module(conn) do
      nil ->
        nil
      module ->
        [endpoint | _] = Module.split(module)
        endpoint
    end
  end

  # Phoenix.Controller exposes these functions,
  # but they raise if unset, which we avoid here.
  defp action_name(conn),
    do: conn.private[:phoenix_action]
  defp controller_module(conn),
    do: conn.private[:phoenix_controller]
  defp endpoint_module(conn),
    do: conn.private[:phoenix_endpoint]
end
