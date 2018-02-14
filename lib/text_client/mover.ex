defmodule TextClient.Mover do
  
  def player_move({game, move}) do
    TicTacToe.player_make_move(game, move)
  end

  def comp_make_move(game) do
    TicTacToe.comp_make_move(game)
  end

end