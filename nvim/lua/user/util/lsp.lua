local M = {}

M.print_r = function(data)
	-- cache of tables already printed, to avoid infinite recursive loops
	local tablecache = {}
	local buffer = ""
	local padder = "    "

	local function _print_r(d, depth)
		local t = type(d)
		local str = tostring(d)
		if t == "table" then
			if tablecache[str] then
				-- table already dumped before, so we dont
				-- dump it again, just mention it
				buffer = buffer .. "<" .. str .. ">\n"
			else
				tablecache[str] = (tablecache[str] or 0) + 1
				buffer = buffer .. "(" .. str .. ") {\n"
				for k, v in pairs(d) do
					buffer = buffer .. string.rep(padder, depth + 1) .. "[" .. k .. "] => "
					_print_r(v, depth + 1)
				end
				buffer = buffer .. string.rep(padder, depth) .. "}\n"
			end
		elseif t == "number" then
			buffer = buffer .. "(" .. t .. ") " .. str .. "\n"
		else
			buffer = buffer .. "(" .. t .. ') "' .. str .. '"\n'
		end
	end
	_print_r(data, 0)
	return buffer
end

M.setup_servers = function(servers)
	local lspconfig = require("lspconfig")
	local lsp_handler = require('user.src.lsp-handler')

	-- loop through the required packages
	for _, server in pairs(servers) do
		opts = {
			-- getting "on_attach" and capabilities from handlers
			on_attach = lsp_handler.on_attach,
			capabilities = lsp_handler.capabilities,
		}

		-- get the server name
		server = vim.split(server, "@")[1]

		-- pass them to lspconfig
		lspconfig[server].setup(opts)
	end

	-- vim.notify(require('user.util.lsp').print_r(servers))
end

return M
