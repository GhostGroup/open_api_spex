defmodule OpenApiSpec.Plug.RedocUITest do
  use ExUnit.Case

  alias OpenApiSpex.Plug.RedocUI

  @opts RedocUI.init(path: "/ui")

  test "renders csrf token" do
    # token = Plug.CSRFProtection.get_csrf_token()

    # conn = Plug.Test.conn(:get, "/ui")
    # conn = RedocUI.call(conn, @opts)
    # assert conn.resp_body =~ ~r[pathname.+?/ui]
    # assert String.contains?(conn.resp_body, token)
  end
end
