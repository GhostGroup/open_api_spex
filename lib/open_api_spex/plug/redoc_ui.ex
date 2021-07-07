defmodule OpenApiSpex.Plug.RedocUI do
  @moduledoc """
  Module plug that serves RedocUI.
  """

  @behaviour Plug

  @html """
  <!DOCTYPE html>
  <html lang="en">
  <head>
  <meta charset="UTF-8">
  <title>ReDoc</title>
  <!-- needed for adaptive design -->
  <meta charset="utf-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://fonts.googleapis.com/css?family=Montserrat:300,400,700|Roboto:300,400,700" rel="stylesheet">

  <!--
  ReDoc doesn't change outer page styles
  -->
  <style>
  body {
  margin: 0;
  padding: 0;
  }
  </style>
  </head>
  <body>
  <script>
    window.onload = function() {
    const apiSpecUrl = new URL(window.location);
    pathname = "<%= path %>";
     function specUrl() { return apiSpecUrl + pathname; };
  </script>
  <h1>SpecUrl: <script>specUrl();</script></h1>
  <redoc spec-url='http://petstore.swagger.io/v2/swagger.json'></redoc>
  <script src="https://cdn.jsdelivr.net/npm/redoc@next/bundles/redoc.standalone.js"> </script>
  </body>
  </html>
  """

  @impl Plug
  def init(path: path), do: %{path: path}

  @impl Plug
  def call(conn, %{path: path}) do
    csrf_token = Plug.CSRFProtection.get_csrf_token()
    html = render(path, csrf_token)

    conn
    |> Plug.Conn.put_resp_content_type("text/html")
    |> Plug.Conn.send_resp(200, html)
  end

  require EEx
  EEx.function_from_string(:defp, :render, @html, [:path, :csrf_token])
end
