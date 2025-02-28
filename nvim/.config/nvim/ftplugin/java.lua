local mason_registry = require 'mason-registry'
local mason_jdtls = mason_registry.get_package 'jdtls'

require('jdtls').start_or_attach {
    cmd = { mason_jdtls:get_install_path() .. '/bin/jdtls' },
    root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
}
