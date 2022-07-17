local present, null_ls = pcall(require, "null-ls")
if not present then
  return
end
local b = null_ls.builtins
local sources = {
  b.formatting.clang_format.with({
    filetypes = { "c", "cpp", "h" },
  }), }
null_ls.setup({
  debug = true,
  sources = sources,
})
