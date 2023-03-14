local ok, plugin = pcall(require, 'packer')
if not ok then
    return
end

plugin.startup(function(use)
    use { 'wbthomason/packer.nvim' }
    use { 'townk/vim-autoclose' }
    use { 'neovim/nvim-lspconfig', tag = 'v0.1.4' }
    use { 'hrsh7th/nvim-cmp' }
    use { 'hrsh7th/cmp-nvim-lsp' }
    use { 'saadparwaiz1/cmp_luasnip' }
end)
