defmodule TextClient.Prompter do
  alias TextClient.Display

  @slots [
    {"1", :r1c1}, {"2", :r1c2}, {"3", :r1c3},
    {"4", :r2c1}, {"5", :r2c2}, {"6", :r2c3},
    {"7", :r3c1}, {"8", :r3c2}, {"9", :r3c3}
  ] 

  def symbol_select() do
    IO.puts("Please select your symbol: [ x | o ]")
    IO.gets("")
  end

  def symbol_validator(symbol) when symbol in ["x\n", "o\n"], do: symbol
  def symbol_validator(_invalid_symbol) do
    IO.puts("Invalid Symbol. Please choose one of 'x' or 'o'.")
    IO.gets("")
    |> symbol_validator()
  end

  def atomizer(input) do
    input
    |> String.trim()
    |> String.to_atom()
  end

  def next_move(game) do
    IO.puts("Please enter your move:")
    IO.gets("")
    |> String.trim()
    |> next_move_validator(game)
  end

  defp next_move_validator(move, %{board_state: board_state} = game) do
    { empty_slots, _ } = Display.nil_replacer(board_state)
    
    empty_slots
    |> Map.values()
    |> Enum.any?(&(&1 == move))
    |> case do
      true ->
        move_to_slot(game, move)
      false -> 
        IO.puts("Invalid Selection. Please select an *available* number [1 - 9].")
        next_move(game)
    end
  end

  defp move_to_slot(game, move) do
    slot = for {num, slot} when num == move <- @slots, do: slot

    { game, List.first(slot) }
  end
end