defmodule Misc.Excuse do

    def get do
        HTTPoison.get!(Application.get_env(:takobot, :excuse_url))
        |> process_get_response
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
