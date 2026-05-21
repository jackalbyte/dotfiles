local M = {}

function M.setup()
  local loaded, dap = pcall(require, "dap")
  if not loaded then
    return
  end

  dap.adapters.php = {
    type = "executable",
    command = "node",
    args = { os.getenv("HOME") .. "/.debug/vscode-php-debug/out/phpDebug.js" }
  }

  dap.configurations.php = {
    {
      type = "php",
      request = "launch",
      name = "Listen for Xdebug",
      port = 9003,
      pathMappings = {
        ["/var/www/html"] = "${workspaceFolder}"
      }
    }
  }

end

return M
