defmodule WmDevForumWeb.LiveDataChannel do
  use WmDevForumWeb, :channel

  def join("live_data:lobby", payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (live_data:lobby).
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  # to brodcast the message.
  def handle_in("question-added", payload, socket) do
    broadcast(socket, "question-added", payload)
    {:noreply, socket}
  end

  # to brodcast the answer-marked-correct messages
  def handle_in("answer-marked-correct", payload, socket) do
    broadcast(socket, "answer-marked-correct", payload)
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
