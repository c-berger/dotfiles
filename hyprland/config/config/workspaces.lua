-- Workspace rules wiki https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- Add your workspace rules here. Increment the workspace number as you go. Do not have duplicate workspaces.
-- hl.workspace_rule({ workspace = "name:gaming", monitor = PRIMARY_MONITOR, default = true })
-- hl.workspace_rule({ workspace = "1", monitor = MONITOR1, default = true, persistent = true })
-- hl.workspace_rule({ workspace = "2", monitor = MONITOR1, default = true, persistent = true })
-- hl.workspace_rule({ workspace = "3", monitor = MONITOR1, default = true, persistent = true })
-- hl.workspace_rule({ workspace = "4", monitor = MONITOR1, default = true, persistent = true })
-- hl.workspace_rule({ workspace = "5", monitor = MONITOR1, default = true, persistent = true })
-- hl.workspace_rule({ workspace = "6", monitor = MONITOR1, default = true, persistent = true })

-- For other layouts such as scrolling, see example below
-- hl.workspace_rule({ workspace = "1", monitor = MONITOR1, default = true, persistent = true, layout = scroling })

-- Launch the password manager when an empty "passwords" special workspace is created.
-- Replaces the deprecated `on_created_empty` workspace rule.
hl.on("workspace.created", function(ws)
	if not ws.is_empty or ws.name ~= "special:passwords" then
		return
	end
	hl.exec_cmd(PASSWORD_MANAGER, { workspace = "special:passwords silent" })
end)
