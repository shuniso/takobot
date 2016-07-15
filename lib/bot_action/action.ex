defmodule BotAction.Action do

    def hear("lgtm", message, slack) do
        Misc.Lgtm.get
        |> send_message(message.channel, slack)
    end

    def hear("cat", message, slack) do
        Misc.Cat.get
        |> send_message(message.channel, slack)
    end
    def hear("猫", message, slack) do
        Misc.Cat.get
        |> send_message(message.channel, slack)
    end
    def hear("ねこ", message, slack) do
        Misc.Cat.get
        |> send_message(message.channel, slack)
    end

    def hear("zen", message, slack) do
        Misc.Zen.get
        |> send_message(message.channel, slack)
    end
    def hear("excuse", message, slack) do
        Misc.Excuse.get
        |> send_message(message.channel, slack)
    end

    def hear("bus", message, slack) do
        keisei(message, slack)
        tobus(message, slack)
    end
    def hear("バス", message, slack) do
        keisei(message, slack)
        tobus(message, slack)
    end

    def keisei(message, slack) do
        Misc.Capture.get_keisei
        |> Misc.Gyazo.up
        |> send_message(message.channel, slack)
    end

    def tobus(message, slack) do
        Misc.Capture.get_tobus
        |> Misc.Gyazo.up
        |> send_message(message.channel, slack)
    end

    def kisho(message, slack) do
        Misc.Capture.get_kisho
        |> Misc.Gyazo.up
        |> send_message(message.channel, slack)
    end

    def hear("ame", message, slack), do: ame(message, slack)
    def hear("雨", message, slack), do: ame(message, slack)
    def hear("tenki", message, slack), do: kisho(message, slack)
    def hear("天気", message, slack), do: kisho(message, slack)

    def hear("ping", message, slack) do
        Slack.send_ping([], slack)
        send_message("pong", message.channel, slack)
    end

    def hear("raw", message, slack) do
        %{
          type: "message",
          text: "ooo",
          channel: message.channel
        }
        |> Poison.encode!
        |> send_raw(slack)
    end

    def ame(message, slack) do
        Misc.Capture.get_ame
        |> Misc.Gyazo.up
        |> send_message(message.channel, slack)
    end

    def bus(message, slack) do
        Misc.Capture.get_bus
        |> Misc.Gyazo.up
        |> send_message(message.channel, slack)
    end

    def sale(message, slack) do
        Misc.Capture.get_sale
        |> Misc.Gyazo.up
        |> send_message(message.channel, slack)
    end

    def hear(_, _, _) do end

    def respond(_, _, _) do end

    defp send_message(text, channel, slack) do
        IO.puts "send message: " <> text
        Slack.send_message(text, channel, slack)
    end

    defp send_raw(json, slack) do
        IO.inspect json
        Slack.send_raw(json, slack)
    end

    def direct(_, message, slack) do
         send_message("(direct)", message.channel, slack)
    end

    def direct(_, _, _) do end
end
