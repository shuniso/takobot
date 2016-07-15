defmodule Proxy.HttpLocal do
  use Plug.Builder
  import Plug.Conn

  # webkit2pngで開くときに、URLエンコードの状態おかしくなるので
  # 間にプロキシかまして、その辺解決する為のワークアラウンド的なプロキシ
  @target "http://keiseibus.bus-navigation.jp"

  plug Plug.Logger
  plug :dispatch

  def start(_argv) do
    port = 40001
    IO.puts "Running Proxy with Cowboy on http://localhost:#{port}"
    Plug.Adapters.Cowboy.http __MODULE__, [], port: port
    :timer.sleep(:infinity)
  end

  def start_link() do
    {:ok, _} = start([])
  end

  def init(options) do
    options
  end

  def dispatch(conn, _opts) do
    url = check(conn) |> uri
    # Start a request to the client saying we will stream the body.
    # We are simply passing all req_headers forward.
    {:ok, client} = :hackney.request(:get, url, conn.req_headers, :stream, [])

    conn
    |> write_proxy(client)
    |> read_proxy(client)
  end

  # Reads the connection body and write it to the
  # client recursively.
  defp write_proxy(conn, client) do
    # Check Plug.Conn.read_body/2 docs for maximum body value,
    # the size of each chunk, and supported timeout values.
    case read_body(conn, []) do
      {:ok, body, conn} ->
        :hackney.send_body(client, body)
        conn
      {:more, body, conn} ->
        :hackney.send_body(client, body)
        write_proxy(conn, client)
    end
  end

  # Reads the client response and sends it back.
  defp read_proxy(conn, client) do
    {:ok, status, headers, client} = :hackney.start_response(client)
    {:ok, body} = :hackney.body(client)

    # Delete the transfer encoding header. Ideally, we would read
    # if it is chunked or not and act accordingly to support streaming.
    #
    # We may also need to delete other headers in a proxy.
    headers = List.keydelete(headers, "Transfer-Encoding", 0)

    %{conn | resp_headers: headers}
    |> send_resp(status, body)
  end

  defp uri(conn) do
    base = @target <> "/" <> Enum.join(conn.path_info, "/")
    case conn.query_string do
      "" -> base
      qs -> base <> "?" <> URI.decode(qs) #ここでなんとか
    end
  end

  defp check(conn) do
    case conn.host do
      "127.0.0.1" -> conn
      "localhost" -> conn
    end
  end

end
