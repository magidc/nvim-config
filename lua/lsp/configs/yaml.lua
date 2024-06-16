return {
  "someone-stole-my-name/yaml-companion.nvim",
  dependencies = {
      { "neovim/nvim-lspconfig" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
  },
  local cfg = require("yaml-companion").setup {
    -- Built in file matchers
    builtin_matchers = {
      -- Detects Kubernetes files based on content
      kubernetes = { enabled = true },
      cloud_init = { enabled = true }
    },
    -- Additional schemas available in Telescope picker
    schemas = {
      {
        name = "Kubernetes 1.22.4",
        uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.22.4-standalone-strict/all.json",
      },
      {
        url = 'https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json',
        name = 'Argo CD Application',
        fileMatch = 'argocd-application.yaml'
      },
      {
        name = "SealedSecret",
        uri = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/bitnami.com/sealedsecret_v1alpha1.json"
      },
      -- schemas below are automatically loaded, but added
      -- them here so that they show up in the statusline
      {
        name = "Kustomization",
        uri = "https://json.schemastore.org/kustomization.json"
      },
      {
        name = "GitHub Workflow",
        uri = "https://json.schemastore.org/github-workflow.json"
      },
    },

    -- Add any options here, or leave empty to use the default settings
    lspconfig = {
      cmd = { "yaml-language-server" }
      settings= {
        yaml = {
          validate = true,
          schemaStore = {
            enable = false,
            url = ""
          },
        -- schemas from store, matched by filename
        -- loaded automatically
        schemas = require('schemastore').yaml.schemas {
          select = {
            'kustomization.yaml',
            'GitHub Workflow',
          }
        }        
      }
    },
  }
  require("lspconfig")["yamlls"].setup(cfg)
  require("telescope").load_extension("yaml_schema")
  require("yaml-companion").open_ui_select()
}
