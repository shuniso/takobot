defmodule Misc.Gyazo do
    def get_path(name) do
        dir = Misc.SysUtil.get_current
        dir <> name
    end

    def get_token() do
        Application.get_env(:takobot, :gyazo_access_token)
    end

    def up(path) do
        s = "\"" <> path <> "\""
        HTTPoison.post!(Application.get_env(:takobot, :gyazo_upload_url),
        {:multipart, [
            {"access_token", get_token},
            {:file, path, {
                ["form-data"],
                [name: "\"imagedata\"", \
            filename: s]}, []}
        ]}
        )
        |> process_response
    end

    defp process_response(%{status_code: 200, body: body}) do
        body
        |> Poison.decode!
        |> get_url
    end

    defp get_url(%{"url" => url}) do
        IO.inspect url
    end

    defp process_response(res = %{status_code: _}) do
        IO.puts "response_err"
        IO.inspect res
    end

end
