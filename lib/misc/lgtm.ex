defmodule Misc.Lgtm do

    def get do
        URI.encode(Application.get_env(:takobot, :lgtm_url))
        |> HTTPoison.get!
        |> process_get_response
    end

    def redirect_get(url) do
        URI.encode url
        |> HTTPoison.get!
        |> process_get_response
    end

    defp process_get_response(%{status_code: 200, body: body}) do
        body
        |> Floki.find("#imageUrl")
        |> Floki.attribute("value")
        |> hd
    end

    defp process_get_response(%{status_code: 302, headers: headers}) do
        {h, v} = Enum.filter(headers, fn {header, value} ->
            header == "Location"
        end)
        |> hd
        redirect_get v
    end

    defp process_get_response(res = %{status_code: _}) do
        IO.puts "response_err"
        IO.inspect res
    end

end
