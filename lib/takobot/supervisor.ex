defmodule Takobot.Supervisor do
    use Supervisor

    def start_link(opts \\ []) do
        Supervisor.start_link(__MODULE__, :ok, opts)
    end

    # Define alias of process name
    @bot_name Takobot.Bot
    @action_sup_name BotAction.Supervisor
    def init(:ok) do
        children = [
            supervisor(BotAction.Supervisor, [[name: @action_sup_name]]),
            worker(Takobot.Bot, [get_api_key, [name: @bot_name, sup_action: @action_sup_name]]),
            worker(Proxy.HttpLocal, [])
        ]
        supervise(children, strategy: :one_for_one)
    end

    def get_api_key() do
        # Get API Token of Slack.
        system_key = case Mix.env do
            :dev -> "DEVBOT_SLACK_TOKEN"
            :prod -> "TAKOBOT_SLACK_TOKEN"
        end

        case Application.get_env(:takobot, :api_key) do
          nil -> System.get_env(system_key)
          s -> s # 結果をsに束縛して、sを返す的な意味
        end
    end

end
