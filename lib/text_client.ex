defmodule TextClient do

  defdelegate start(), to: TextClient.Player

end
