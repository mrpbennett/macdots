return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    ---
    dashboard = {
      enabled = true,
      example = "compact_files",
      preset = {
        header = [[
 __         ______     ______     __  __     __   __   __     __    __    
/\ \       /\  __ \   /\___  \   /\ \_\ \   /\ \ / /  /\ \   /\ "-./  \   
\ \ \____  \ \  __ \  \/_/  /__  \ \____ \  \ \ \'/   \ \ \  \ \ \-./\ \  
 \ \_____\  \ \_\ \_\   /\_____\  \/\_____\  \ \__|    \ \_\  \ \_\ \ \_\ 
  \/_____/   \/_/\/_/   \/_____/   \/_____/   \/_/      \/_/   \/_/  \/_/ 
        ]],
      },
    },
    ---
    dim = {
      enabled = true,
    },
    ---
    image = {
      enabled = true,
    },
    ---
    picker = {
      sources = {
        explorer = {
          ignored = true,
          hidden = true,
        },
      },
    },
    ---
  },
  ---
}
