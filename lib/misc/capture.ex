defmodule Misc.Capture do

  def get_scripts(file) do
    Application.get_env(:takobot, :scripts_dir) <> file
  end

  def get_ame() do
    {path, _} = System.cmd(get_scripts("/ame.sh"), [])
    path
  end

  def get_kisho() do
    {path, _} = System.cmd(get_scripts("/kisho.sh"), [])
    path
  end

  def get_keisei() do
    {path, _} = System.cmd(get_scripts("/keisei.sh"), [])
    path
  end

  def get_tobus() do
    {path, _} = System.cmd(get_scripts("/tobus.sh"), [])
    path
  end

  def get_sale() do
    {path, _} = System.cmd(get_scripts("/sale.sh"), [])
    path
  end

  def get_berc() do
    {path, _} = System.cmd(get_scripts("/berc.sh"), [])
    path
  end

  def get_scripts(script_file) do
    {path, _} = System.cmd(get_scripts(script_file), [])
    path
  end

end
