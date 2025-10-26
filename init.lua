-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.g.mapleader = " "

vim.opt.clipboard = "unnamedplus"

function RunCurrentFile()
    local file = vim.fn.expand("%:p")       -- full path
    local filename = vim.fn.expand("%:t:r") -- filename without extension
    local ext = vim.fn.expand("%:e")        -- file extension
    local cmd = ""
  
    if ext == "c" then
      cmd = string.format("gcc '%s' -o /tmp/%s && /tmp/%s", file, filename, filename)
    elseif ext == "cpp" then
      cmd = string.format("g++ '%s' -o /tmp/%s && /tmp/%s", file, filename, filename)
    elseif ext == "py" then
      cmd = string.format("python3 '%s'", file)
    elseif ext == "js" then
      cmd = string.format("node '%s'", file)
    elseif ext == "asm" then
      -- detect architecture: 32 or 64
      local format = vim.fn.input("Assemble as (elf32/elf64): ", "elf64")
      local arch_flag = (format == "elf32") and "-m elf_i386" or ""
      cmd = string.format(
        "nasm -f %s '%s' -o /tmp/%s.o && ld %s /tmp/%s.o -o /tmp/%s && /tmp/%s",
        format,
        file,
        filename,
        arch_flag,
        filename,
        filename,
        filename
      )
    else
      vim.notify("Unsupported file type: " .. ext, vim.log.levels.ERROR)
      return
    end
  
    -- Run inside floating terminal using toggleterm
    require("toggleterm.terminal").Terminal
      :new({
        cmd = cmd,
        direction = "float",
        close_on_exit = false,
        hidden = true,
        cwd = vim.fn.getcwd(),
      })
      :toggle()
  end
  
