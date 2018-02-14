defmodule TextClient.Mover do
  alias TextClient.Player
  
  def player_move({game, move}) do
    TicTacToe.player_make_move(game.game_pid, move)
    
    Player.refresh_game(game.game_pid)
  end

  def comp_make_move(game) do
    TicTacToe.comp_make_move(game.game_pid)
    
    Player.refresh_game(game.game_pid)
  end

end