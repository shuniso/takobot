defmodule Ul.Decompose do

    def get(text) do
        construct_uri(text)
        |> HTTPoison.get!()
        |> process_get_response
    end

    def construct_uri(text) do
        Application.get_env(:takobot, :ul_decompose) <> "?message=" <> text <> "&key=" <> Application.get_env(:takobot, :ul_key)
    end

    defp process_get_response(%{status_code: 200, body: body}) do
        body
        |> IO.inspect
        |> Floki.find("a")
        |> IO.inspect
        |> Floki.text
    end

    defp process_get_response(res = %{status_code: _}) do
        IO.puts "response_err"
        IO.inspect res
    end
end
