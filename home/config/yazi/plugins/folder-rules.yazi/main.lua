local function setup()
  ps.sub("cd", function()
    local cwd = tostring(cx.active.current.cwd)
    if string.find(cwd, "fedex") then
      os.execute('nu -c "source ~/.custom_nu/.hosts_config.nu; swap_config normal_config fedex_config" > /dev/null 2>&1')
    else
      os.execute('nu -c "source ~/.custom_nu/.hosts_config.nu; swap_config fedex_config normal_config" > /dev/null 2>&1')
    end
  end)
end

return { setup = setup }
