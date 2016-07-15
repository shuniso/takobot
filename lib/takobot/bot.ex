defmodule Takobot.Bot do
  use Slack

  def handle_connect(%{channels: _, me: me, users: _, team: _}, state) do
    IO.puts "Connected as " <> get_bot_name me
    {:ok, state}
  end

  def get_bot_name(%{name: name}) do
    name
  end

  def handle_message(message = %{type: "message", text: _}, slack, state) do
    indicate_typing(message.channel, slack)
    IO.puts "handle: message"
    IO.inspect message
    # Slackからメッセージを受け取った時に呼ばれるコールバック

    # とりあえず、spaeceで区切ってるけど、ほんとはこれじゃだめね
    triggers = String.split(message.text, ~r{ |　})
    {cmd, trigger} =
      case String.starts_with?(message.channel, "D") do
        true -> case String.starts_with?(message.text, "<@#{slack.me.id}>: ") do
          # @bot名 ~ できたら :respond を渡してactionのプロセスを開始
          true -> {:direct, Enum.fetch!(triggers, 1)}
          # それ以外は :hear を渡して actionのプロセスを開始
          false -> {:direct, hd(triggers)}
        end
        false -> case String.starts_with?(message.text, "<@#{slack.me.id}>: ") do
          # @bot名 ~ できたら :respond を渡してactionのプロセスを開始
          true -> {:respond, Enum.fetch!(triggers, 1)}
          # それ以外は :hear を渡して actionのプロセスを開始
          false -> {:hear, hd(triggers)}
        end
    end
    BotAction.Supervisor.start_action(state[:sup_action], cmd, trigger, message, slack)
    {:ok, state}
  end

  def handle_message(%{type: "user_typing"}, slack, state) do
    IO.puts "handle: user typing"
    {:ok, state}
  end

  def handle_message(%{type: "presence_change"}, _slack, state) do
    IO.puts "handle: presence_change"
    {:ok, state}
  end

  def handle_message(_message, _slack, state) do
    {:ok, state}
  end

end
