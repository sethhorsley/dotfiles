return {
  {
    "alker0/chezmoi.vim",
    lazy = false,
    init = function()
      -- This option is required.
      vim.g["chezmoi#use_tmp_buffer"] = true
      -- add other options here if needed.
    end,
  },
  {
    "bkad/CamelCaseMotion",
    commit = "de439d7c06cffd0839a29045a103fe4b44b15cdc",
    lazy = true,
    -- event = { 'CursorHold', 'CursorHoldI', 'CursorMoved', 'CursorMovedI' },
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
  },
}
