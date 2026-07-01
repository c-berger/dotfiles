-- Add additional filetypes to NeoVim
vim.filetype.add({
  filename = {
    ["Jenkinsfile"] = "groovy", -- recognize "Jenkinsfile" as Groovy script.
  },
  pattern = {
    ["Jenkinsfile.*"] = "groovy", -- recognize "Jenkinsfile.*" as Groovy script.
    [".vscode/*.json"] = "jsonc", --
  },
})
