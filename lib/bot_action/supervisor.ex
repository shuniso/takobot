defmodule BotAction.Supervisor do

  def start_link(opts \\ []) do
    Task.Supervisor.start_link(opts)
  end

  def start_action(supervisor, command, trigger, message, slack) do
    IO.puts "start_action"
    # Slackのプロセスから呼ばれ、このSupervisor配下に新しいプロセスを作成する。
    # Task.Supervisorの子プロセスの戦略は `simple_one_for_one` になり、動的に追加できる。
    # クラッシュ時は再起動されない
    Task.Supervisor.start_child(supervisor, fn ->
      IO.puts "start_child"
      case command do
        :respond -> BotAction.Action.respond(trigger, message, slack)
        :hear -> BotAction.Action.hear(trigger, message, slack)
        :direct ->
          BotAction.Action.direct(trigger, message, slack)
          BotAction.Action.hear(trigger, message, slack)
      end
    end)
  end

end
