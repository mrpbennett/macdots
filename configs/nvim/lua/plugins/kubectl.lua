return {
  {
    "ramilito/kubectl.nvim",
    version = "2.*",
    -- build = 'cargo build --release',
    dependencies = "saghen/blink.download",
    opts = {
      -- Add your kubectl.nvim options here
      -- For example:
      -- auto_refresh = { enabled = true, interval = 300 },
      -- namespace = "default",
      -- etc.
    },
    cmd = { "Kubectl", "Kubectx", "Kubens" },
    keys = {
      { "<leader>k8", '<cmd>lua require("kubectl").toggle()<cr>' },
      { "<C-k>", "<Plug>(kubectl.kill)", ft = "k8s_*" },
      { "7", "<Plug>(kubectl.view_nodes)", ft = "k8s_*" },
      { "8", "<Plug>(kubectl.view_overview)", ft = "k8s_*" },
      { "<C-t>", "<Plug>(kubectl.view_top)", ft = "k8s_*" },
    },
  },
}
