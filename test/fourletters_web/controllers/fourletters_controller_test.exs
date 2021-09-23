defmodule FourlettersWeb.FourlettersControllerTest do
  use FourlettersWeb.ConnCase

  # test "GET /", %{conn: conn} do
  #   conn = get(conn, "/")
  #   assert html_response(conn, 200) =~ "4-letters.net"
  # end

  test "GET /?fourletters=test", %{conn: conn} do
    conn = get(conn, "/?fourletters=test")
    assert html_response(conn, 302) =~ "redirected"
    assert %{fourletters: "test"} = redirected_params(conn)
    assert redirected_to(conn) == "/test"
  end

end
