defmodule ViberexExample.Server do
  use Viberex.Server

  @times %{
    "London" => 0,
    "Tokyo" => 9,
    "Moscow" => 3
  }

  def handle_callback(%{"event" => "conversation_started", "user" => user}) do
    welcome_message = %{
      text: "Hello, #{user["name"]}",
      type: "text"
    }
    {:reply, welcome_message}
  end

  def handle_callback(%{"event" => "message"} = event) do
    spawn(fn ->
      match_command(event)
    end)
    :noreply
  end

  def handle_callback(_), do: :noreply

  defp match_command(%{"message" => message, "sender" => sender}) do
    answer =
      case String.split(message["text"]) do
        ["time", city] ->
          get_time(city)

        _ ->
          "What?"
      end

    response_message = %{
      text: answer,
      type: "text",
      receiver: sender["id"]
    }
    Viberex.send_message(response_message)
  end

  defp get_time(city) do
    case Map.get(@times, city) do
      offset when is_integer(offset) ->
        city_time =
          DateTime.utc_now()
          |> DateTime.to_unix()
          |> Kernel.+(offset * 3600)
          |> DateTime.from_unix!()
          |> DateTime.to_iso8601()

        "The time in #{city} is #{city_time}"

      _ ->
        "I don't know what time it is in #{city}"
    end
  end

end
