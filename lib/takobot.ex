defmodule Takobot do
    use Application

    def start(_type, _args) do
        Takobot.Supervisor.start_link
    end
end
