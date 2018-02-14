defmodule TextClient.Player do
  alias TextClient.{Display, Prompter, Mover}
  
  defstruct game_pid: nil,
            tally: %{}

  def start() do
    welcome_message()
      Prompter.symbol_select()
      |> Prompter.symbol_validator()
      |> Prompter.atomizer()
      |> TicTacToe.new_game()
      |> refresh_game()
      |> play()
  end

  def welcome_message() do
    Mix.Shell.IO.cmd("clear")
    IO.puts("Welcome to TicTacToe!\n")
  end

  def play(%{tally: %{status: { :game_won, winner }, player: winner }} = game) do
    end_with_message(game, "Congratulations! You WON!!")
  end
  
  def play(%{tally: %{status: { :game_won, winner }, comp: winner }} = game) do
    end_with_message(game, "Game Over... You lost.")
  end
  
  def play(%{tally: %{status: { :draw, _ } }} = game) do
    end_with_message(game, "DRAW! No Winner...")
  end

  def play(game) do
    Mix.Shell.IO.cmd("clear")
    game
    |> Display.board()
    |> Prompter.next_move()
    |> Mover.player_move()
    |> Mover.comp_make_move()
    |> play()
  end

  def refresh_game(game_pid) do
    %TextClient.Player{
      game_pid: game_pid,
      tally: TicTacToe.game_info(game_pid)
    }
  end

  def end_with_message(game, msg) do
    Mix.Shell.IO.cmd("clear")
    Display.board(game)
    IO.puts(msg)
    DynamicSupervisor.terminate_child(TicTacToe.DynamicSupervisor, game.game_pid)
  end

end