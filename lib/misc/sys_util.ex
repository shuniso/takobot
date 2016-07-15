defmodule Misc.SysUtil do

  def get_current() do
    {d, 0} = System.cmd "pwd", []
    String.replace d, "\n", ""
  end

end
