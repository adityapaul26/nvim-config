return {
  {
    "vyfor/cord.nvim",
    build = ":Cord update", -- This will download the necessary server component
    event = "VeryLazy", -- Load it after startup
    -- opts = {} -- You can add configuration options here if you want
  },
  {
    "isakbm/gitgraph.nvim",
    opts = {
      git_cmd = "git",
      symbols = {
        merge_commit = "",
        commit = "",
        merge_commit_end = "",
        commit_end = "",
      },
      format = {
        timestamp = "%H:%M:%S %d-%m-%Y",
        fields = { "hash", "timestamp", "author", "branch_name", "tag" },
      },
      hooks = {
        on_select_commit = function(commit)
          print("selected commit:", commit.hash)
        end,
        on_select_range_commit = function(from, to)
          print("selected range:", from.hash, to.hash)
        end,
      },
    },
    keys = {
      {
        "<leader>gl",
        function()
          require("gitgraph").draw({}, { all = true, max_count = 5000 })
        end,
        desc = "GitGraph - Draw",
      },
    },
    {
      "chentoast/marks.nvim",
      event = { "BufReadPre", "BufNewFile" },
      opts = {},
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      file_types = { "markdown", "Avante" },
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },
      heading = {
        sign = false,
        icons = {}, -- clear icons if you want a clean look
      },
    },
    ft = { "markdown", "norg", "rmd", "org" },
    config = function(_, opts)
      require("render-markdown").setup(opts)
      vim.keymap.set("n", "<leader>mt", require("render-markdown").toggle, { desc = "Toggle Render Markdown" })
    end,
  },
}
