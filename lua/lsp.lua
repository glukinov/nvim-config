local ok, lspconfig = pcall(require, 'lspconfig')
if not ok then
    return
end

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local on_attach = function(client, buf)
    vim.api.nvim_buf_set_option(buf, 'omnifunc', 'v:lua.lsp.omnifunc')

    local bufopts = { noremap = true, silent = true, buffer = buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_filders())) end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = { debounce_text_changes = 150 }
local lsp_config = { on_attach = on_attach, flags = lsp_flags }

local ok, capabilities = pcall(require, 'cmp_nvim_lsp')
if ok then
    lsp_config.capabilities = capabilities.default_capabilities()
end

lspconfig['pylsp'].setup(lsp_config)

-----------------------------------------------------------------------------
-- CONFIGURE AUTOCOMPLETION PLUGIN
-----------------------------------------------------------------------------

local ok, cmp = pcall(require, 'cmp')
if not ok then
    return
end

local cmp_on_tab = function(fallback)
    if cmp.visible() then
        cmp.select_next_item()
    else
        fallback()
    end
end

local cmp_on_stab = function(fallback)
    if cmp.visible() then
        cmp.select_prev_item()
    else
        fallback()
    end
end

local cmp_mapping = {}
cmp_mapping['<C-u>'] = cmp.mapping.scroll_docs(-4)
cmp_mapping['<C-d>'] = cmp.mapping.scroll_docs(4)
cmp_mapping['<C-Space>'] = cmp.mapping.complete()
cmp_mapping['<CR>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true }
cmp_mapping['<Tab>'] = cmp.mapping(cmp_on_tab, { 'i', 's' })
cmp_mapping['<S-Tab>'] = cmp.mapping(cmp_on_stab, { 'i', 's' })

local cmp_sources = {}
table.insert(cmp_sources, { name = 'nvim_lsp' })

cmp.setup { mapping = cmp_mapping, sources = cmp_sources }
