-- return {
--   cmd = { 'clangd' },
--   root_markers = { '.clangd', 'compile_commands.json' },
--   filetypes = { 'c', 'cpp' },
-- }

vim.lsp.config('clangd', {
root_markers = { '.clang-format', 'compile_commands.json' },
capabilities = {
  textDocument = {
    completion = {
      completionItem = {
        snippetSupport = true,
      }
    }
  }
}
})
