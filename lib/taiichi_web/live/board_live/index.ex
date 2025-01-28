defmodule TaiichiWeb.BoardLive.Index do
  use TaiichiWeb, :live_view

  alias Taiichi.Kanban
  alias Taiichi.Kanban.Board

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :boards, Kanban.list_boards())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Board")
    |> assign(:board, Kanban.get_board!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Board")
    |> assign(:board, %Board{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Boards")
    |> assign(:board, nil)
  end

  #   defp apply_action(socket, :run, params) do
  #     IO.puts("**** RUN ****")
  #     dbg(params)

  #     socket =
  #       socket
  #       |> assign(:page_title, "Listing Boards - RUN")
  #       |> assign(:board, nil)

  #     if connected?(socket) do
  #       ECSx.ClientEvents.add(params, :start_sim)
  #       #   :timer.send_interval(50, :load_player_info)
  #     end

  #     socket
  #   end

  @impl true
  @spec handle_info(
          {TaiichiWeb.BoardLive.FormComponent, {:saved, any()}},
          Phoenix.LiveView.Socket.t()
        ) :: {:noreply, Phoenix.LiveView.Socket.t()}
  def handle_info({TaiichiWeb.BoardLive.FormComponent, {:saved, board}}, socket) do
    {:noreply, stream_insert(socket, :boards, board)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    board = Kanban.get_board!(id)
    {:ok, _} = Kanban.delete_board(board)

    {:noreply, stream_delete(socket, :boards, board)}
  end

  def handle_event("run", %{"board_id" => id}, socket) do
    if connected?(socket) do
      ECSx.ClientEvents.add(%{board_id: id}, :start_sim)
      #   :timer.send_interval(50, :load_player_info)
    end

    {:noreply, socket}
  end
end
