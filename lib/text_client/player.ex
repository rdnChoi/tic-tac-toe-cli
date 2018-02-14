defmodule TextClient.Player do
  alias TextClient.{Display, Prompter, Mover}
  
  def start() do
    welcome_message()
    Prompter.symbol_select()
    |> Prompter.symbol_validator()
    |> Prompter.atomizer()
    |> TicTacToe.new_game()
    |> play()
  end

  def welcome_message() do
    Mix.Shell.IO.cmd("clear")
    IO.puts("Welcome to TicTacToe!\n")
  end

  def play(%{ status: { :game_won, winner }, player: winner } = game) do
    Mix.Shell.IO.cmd("clear")
    Display.board(game)
    IO.puts("Congratulations! You WON!!")
  end

  def play(%{ status: { :game_won, winner }, comp: winner } = game) do
    Mix.Shell.IO.cmd("clear")
    Display.board(game)
    IO.puts("Game Over... You lost.")
  end

  def play(%{ status: { :draw, _ } } = game) do
    Mix.Shell.IO.cmd("clear")
    Display.board(game)
    IO.puts("DRAW! No Winner...")
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
end