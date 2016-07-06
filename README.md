# DefaultTitle

Creates automatic placeholder titles for a Phoenix app layout.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `default_title` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [
        {:default_title, "~> 0.0.1"},
      ]
    end
    ```

## Usage

Open your Phoenix application’s layout file and add the call to the title tag:

```eex
<title><%= assigns[:page_title] || DefaultTitle.default_title(@conn) %></title>
```

The following options are available as a keyword list in the second argument:

   * `separator:`

    *  String used to separate the page and app titles
    *  Defaults to `|`

   * `suffix:`

     * Application name shown after the page title
     * Automatically inferred from the endpoint name by default
     * Set to `:none` to disable
