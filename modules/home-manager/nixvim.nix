{
  config,
  pkgs,
  inputs,
  ...
}: let
  plugins = pkgs.vimPlugins;
in {
  imports = [
    inputs.nixvim.homeManagerModules.default
  ];
  programs.nixvim = {
    enable = true;

    globals.mapleader = " "; # Sets the leader key to space

    opts = {
      clipboard = "unnamedplus";
      number = true; # Show line numbers
      relativenumber = false; # Show relative line numbers
      shiftwidth = 2; # Tab width should be 2
      softtabstop = 2;
      smartindent = true;
      wrap = false;
      swapfile = false;
      backup = false;
      hlsearch = false;
      incsearch = true;
      termguicolors = true;
      scrolloff = 8;
      updatetime = 50;
    };

    #colorschemes.catppuccin.enable = true;
    plugins = {
      barbecue.enable = true;
      gitsigns.enable = true;
      telescope = {
        enable = true;
        keymaps = {
          "<leader>ff" = "find_files";
          "<leader>lg" = "live_grep";
        };
      };
      indent-blankline.enable = true;
      colorizer.enable = true;
      nvim-autopairs.enable = true;
      nix.enable = true;
      comment.enable = true;
      lualine = {
        enable = true;
      };
      startup = {
        enable = true;
        theme = "dashboard";
      };
      lsp = {
        enable = true;
        servers = {
          ts_ls.enable = true;
          lua_ls.enable = true;
          bashls.enable = true;
          rust_analyzer = {
            enable = true;
            installRustc = true;
            installCargo = true;
          };
          nixd.enable = true;
          html.enable = true;
          ccls.enable = true;
          cmake.enable = true;
          csharp_ls.enable = true;
          cssls.enable = true;
          gopls.enable = true;
          jsonls.enable = true;
          pyright.enable = true;
          tailwindcss.enable = true;
        };
      };
      lsp-lines.enable = true;
      treesitter = {
        enable = true;
        nixGrammars = true;
      };
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings.sources = [
          {name = "nvim_lsp";}
          {name = "path";}
          {name = "buffer";}
        ];
      };
      web-devicons.enable = true;
      yazi.enable = true;
    };

    extraPlugins = [plugins.telescope-file-browser-nvim];

    # FOR NEOVIDE
    extraConfigLua = ''
      vim.opt.guifont = "JetBrainsMono\\ NFM,Noto_Color_Emoji:h14"
      vim.g.neovide_cursor_animation_length = 0.05

      local colors = {
        blue   = '#89b4fa',
        cyan   = '#f9e2af',
        black  = '#1e1e2e',
        white  = '#cdd6f4',
        red    = '#f38ba8',
        violet = '#cba6f7',
        grey   = '#585b70',
      }

      local bubbles_theme = {
        normal = {
          a = { fg = colors.black, bg = colors.violet },
          b = { fg = colors.white, bg = colors.grey },
          c = { fg = colors.black, bg = colors.black },
        },

        insert = { a = { fg = colors.black, bg = colors.blue } },
        visual = { a = { fg = colors.black, bg = colors.cyan } },
        replace = { a = { fg = colors.black, bg = colors.red } },

        inactive = {
          a = { fg = colors.white, bg = colors.black },
          b = { fg = colors.white, bg = colors.black },
          c = { fg = colors.black, bg = colors.black },
        },
      }

      require('lualine').setup {
        options = {
          theme = bubbles_theme,
          component_separators = '|',
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = {
            { 'mode', separator = { left = '' }, right_padding = 2 },
          },
          lualine_b = { 'filename', 'branch' },
          lualine_c = { 'fileformat' },
          lualine_x = {},
          lualine_y = { 'filetype', 'progress' },
          lualine_z = {
            { 'location', separator = { right = '' }, left_padding = 2 },
          },
        },
        inactive_sections = {
          lualine_a = { 'filename' },
          lualine_b = {},
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = { 'location' },
        },
        tabline = {},
        extensions = {},
      }
    '';

    extraConfigVim = ''
      set noshowmode
      inoremap jj <ESC>
    '';

    keymaps = [
      {
        mode = "n";
        key = "<space>fb";
        action = ":Telescope file_browser<CR>";
        options.noremap = true;
      }
      {
        key = "<Tab>";
        action = ":bnext<CR>";
        options.silent = false;
      }
      {
        key = "<S-Tab>";
        action = ":bprev<CR>";
        options.silent = false;
      }
    ];
  };
}
