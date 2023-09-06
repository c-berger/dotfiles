-- import comment plugin safely
local setup, comment = pcall(require, "Comment")
if not setup then
  print("Comment plugin not found!")
  return
end

-- enable comment
comment.setup()
