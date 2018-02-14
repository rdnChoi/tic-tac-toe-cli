defmodule TextClient.Display do
  alias TextClient.Player

  def board(%Player{tally: %{board_state: board_state}} = game) do
    board_state
    |> nil_to_num()
    |> draw_board()

    game
  end

  # def nil_to_num(board_state, 9), do: board_state
  def nil_to_num(board_state) do
    board_state
    |> Map.to_list()
    |> nil_replacer()
    |> map_merger()
  end

  def nil_replacer(board_state_list) do
    empty_slots = for { slot, value } <- board_state_list, is_nil(value), into: %{}, do: { slot, nil_to_string(slot) }
    filled_slots = for { slot, value } <- board_state_list, value != nil, into: %{}, do:  { slot, value }

    { empty_slots, filled_slots }
  end

  def map_merger({ empty_slots, filled_slots}) do
    Map.merge(empty_slots, filled_slots)
  end

  defp nil_to_string(:r1c1), do: to_string(1)
  defp nil_to_string(:r1c2), do: to_string(2)
  defp nil_to_string(:r1c3), do: to_string(3)
  defp nil_to_string(:r2c1), do: to_string(4)
  defp nil_to_string(:r2c2), do: to_string(5)
  defp nil_to_string(:r2c3), do: to_string(6)
  defp nil_to_string(:r3c1), do: to_string(7)
  defp nil_to_string(:r3c2), do: to_string(8)
  defp nil_to_string(:r3c3), do: to_string(9)

  def draw_board(%{r1c1: a, r1c2: b, r1c3: c, r2c1: d, r2c2: e, r2c3: f, r3c1: g, r3c2: h, r3c3: i}) do
    board = 
    """
         |     |     
      #{a}  |  #{b}  |  #{c}
     ____|_____|____
         |     |  
      #{d}  |  #{e}  |  #{f}   
     ____|_____|____
         |     |  
      #{g}  |  #{h}  |  #{i}
         |     |     
    """
    IO.puts(board)
  end
end