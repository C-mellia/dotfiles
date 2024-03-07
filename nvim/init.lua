local path = os.getenv("HOME") .. "/.config/nvim/"
package.path = package.path .. ";" .. path .. "?.lua" .. ";" .. path .. "config/?.lua"

-- global config: config/global_conf
-- utils: util
require "variables"
require "plugins"
require "plug-config"
require "afterplug"
require "mappings"
require "autocmd"
