require("luasnip/loaders/from_vscode").lazy_load()

local present, cmp = pcall(require, "cmp")

if not present then
  return
end

local function border(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

local kind_icons = {
  Compitlot = "",
  Namespace = "",
  Text = " ",
  Method = " ",
  Function = " ",
  Constructor = " ",
  Field = "ﰠ ",
  Variable = " ",
  Class = "ﴯ ",
  Interface = " ",
  Module = " ",
  Property = "ﰠ ",
  Unit = "塞 ",
  Value = " ",
  Enum = " ",
  Keyword = " ",
  Snippet = " ",
  Color = " ",
  File = " ",
  Reference = " ",
  Folder = " ",
  EnumMember = " ",
  Constant = " ",
  Struct = "פּ ",
  Event = " ",
  Operator = " ",
  TypeParameter = " ",
  Table = "",
  Object = " ",
  Tag = "",
  Array = "[]",
  Boolean = " ",
  Number = " ",
  Null = "ﳠ",
  String = " ",
  Calendar = "",
  Watch = " ",
  Package = "",
} -- kind_icons end here

local options = {
  window = {
    completion = {
      border = border("CmpBorder"), -- border color for completion window
      winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None", -- "CursorLine:PmenuSel,Search:None",
    },
    documentation = {
      border = border("CmpDocBorder"), -- border color for documentation window (same as completion window)
    },
  },
  snippet = {
    expand = function(args) -- expand snippet with arguments (args is a table) 
      require("luasnip").lsp_expand(args.body) -- expand snippet with lsp_expand function 
    end,
  },
  formatting = {
    format = function(_, vim_item)
      vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- add kind icon to vim item
      return vim_item
    end,
  },
  mapping = {
    ["<C-h>"] = cmp.mapping.select_prev_item(),
    ["<C-l>"] = cmp.mapping.select_next_item(),
    ["<C-j>"] = cmp.mapping.scroll_docs(-4),
    ["<C-k>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-s>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require("luasnip").expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
      else
        fallback()
      end
    end, {
        "i",
        "s",
      }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
      else
        fallback()
      end
    end, {
        "i",
        "s",
      }),
  },
  sources = {
    { name = "copilot", group_index = 2 }, -- group index 2 is for copilot
    { name = "lsp", group_index = 1 }, -- group index 1 is for lsp
    { name = "vscode", group_index = 1 }, -- group index 1 is for vscode

    { name = "luasnip" }, -- luasnip is the default source
    { name = "nvim_lsp" }, -- nvim_lsp is the default source
    { name = "buffer" }, -- buffer is the default source
    { name = "nvim_lua" },
    { name = "path" },
  },
}
vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {fg ="#6CC644"})
cmp.setup(options)
