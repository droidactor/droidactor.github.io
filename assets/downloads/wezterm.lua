-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

config.clean_exit_codes = { 130 }

-- This is where you actually apply your config choices

-- config.color_scheme = 'One Dark (Gogh)' -- Alternative: use built-in theme
config.color_scheme = "Catppuccin Macchiato" -- Alternative: use built-in theme

-- Modern dark theme colors (similar to One Dark Pro / Tokyo Night)
config.colors = {
	-- 	foreground = "#abb2bf",
	-- 	background = "#1e2127",
	cursor_bg = "#61afef",
	cursor_border = "#61afef",
	cursor_fg = "#1e2127",
	-- 	selection_bg = "#3e4451",
	-- 	selection_fg = "#abb2bf",
	-- 	ansi = {
	-- 		"#282c34", -- black
	-- 		"#e06c75", -- red
	-- 		"#98c379", -- green
	-- 		"#e5c07b", -- yellow
	-- 		"#61afef", -- blue
	-- 		"#c678dd", -- magenta
	-- 		"#56b6c2", -- cyan
	-- 		"#abb2bf", -- white
	-- 	},
	-- 	brights = {
	-- 		"#5c6370", -- bright black
	-- 		"#e06c75", -- bright red
	-- 		"#98c379", -- bright green
	-- 		"#e5c07b", -- bright yellow
	-- 		"#61afef", -- bright blue
	-- 		"#c678dd", -- bright magenta
	-- 		"#56b6c2", -- bright cyan
	-- 		"#ffffff", -- bright white
	-- 	},
}

-- -- For example, changing the initial geometry for new windows:
-- config.initial_cols = 120
-- config.initial_rows = 28

-- Font configuration (popular Nerd Fonts)
-- Try these fonts in order of preference
-- Font configuration with Nerd Font
-- config.font = wezterm.font_with_fallback {
-- 	"JetBrainsMono NF",
-- 	"FiraCode NF",
-- 	"DejaVuSansM Nerd Font",
-- 	"Cascadia Code",
-- 	"Consolas",
-- }

config.font = wezterm.font("JetBrains Mono", { weight = "Light", italic = false })
--wezterm.font('JetBrains Mono')

-- Font size management
local current_font_size = 13
local min_font_size = 8
local max_font_size = 24

config.font_size = current_font_size
config.line_height = 1.0

config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false

config.window_decorations = "TITLE | RESIZE"
-- Optional: Enable transparency for a modern look (uncomment if desired)
-- config.window_background_opacity = 0.95
-- config.win32_system_backdrop = "Acrylic" -- Windows 11 acrylic effect

-- Scrollbar configuration
config.enable_scroll_bar = true
config.scrollback_lines = 30000
config.min_scroll_bar_height = "2cell"
config.colors.scrollbar_thumb = "#5c6370"

-- Git Bash 사용하는 경우
config.default_prog = { "C:\\Program Files\\Git\\bin\\bash.exe" }

-- Launch menu for shell selection
config.launch_menu = {
	{
		label = "Git Bash",
		args = { "C:\\Program Files\\Git\\bin\\bash.exe" },
	},
	{
		label = "Clean Git Bash",
		args = { "C:\\Program Files\\Git\\bin\\bash.exe", "--noprofile", "--norc", "-i" },
	},
	{
		-- /c/msys64/etc/profile 최상단에 HOME=/f/Home 추가
		-- /c/msys64/nsswitch.conf 의 db_home 라인 수정 (다음으로 overwrite)
		--   db_home: env windows cygwin desc
		label = "MSYS Git Bash",
		args = {
			"C:\\msys64\\usr\\bin\\env.exe",
			"-i", -- 깨끗한 환경에서 시작
			"HOME=/f/Home", -- 원하는 홈
			"MSYSTEM=MSYS", -- 순수 MSYS 셸 (원하면 MINGW64로)
			"CHERE_INVOKING=1", -- 현재 디렉터리 유지(원치 않으면 빼기)
			"COMSPEC=/c/windows/system32/cmd.exe",
			"/c/msys64/usr/bin/bash.exe",
			"--noprofile",
			"--norc", -- 프로파일이 HOME을 덮지 못하게 테스트
			-- "-lc",
			-- "echo $HOME; pwd; cygpath -w ~",
		},
	},
	-- Ultra Clean Git Bash: env를 비우고 rc도 모두 무시
	{
		label = "Ultra Clean Git Bash",
		args = {
			"C:\\Program Files\\Git\\usr\\bin\\env.exe",
			"-i",
			-- 최소한의 변수만 주고 싶다면 여기서 지정 가능 (없어도 됨)
			"HOME=/f/Tmp",
			"LANG=ko_KR.UTF-8",
			"LC_CTYPE=ko_KR.UTF-8",
			"LC_ALL=ko_KR.UTF-8",

			-- , "TERM=xterm-256color", "PATH=/usr/bin:/bin",

			"C:\\Program Files\\Git\\bin\\bash.exe",
			"--noprofile",
			"--norc",
			"-i",
		},
	},
	{
		label = "PowerShell",
		args = { "powershell.exe" },
	},
	{
		label = "Command Prompt",
		args = { "cmd.exe" },
	},
	{
		label = "WSL Ubuntu",
		args = { "wsl.exe", "-d", "Ubuntu" },
	},
}

-- Key bindings
local keys = {
	-- Show launcher menu
	{ key = "l", mods = "ALT", action = act.ShowLauncher },
	{ key = "n", mods = "CTRL|SHIFT", action = act.ShowLauncher },
	-- Clipboard operations
	{ key = "c", mods = "CTRL|SHIFT", action = act.CopyTo("Clipboard") },
	{ key = "Insert", mods = "CTRL", action = act.CopyTo("Clipboard") },
	{ key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") },
	{ key = "v", mods = "CTRL", action = act.PasteFrom("Clipboard") },
	{ key = "Insert", mods = "SHIFT", action = act.PasteFrom("Clipboard") },
	-- Clear scrollback (메모리 정리 / hang 회피)
	{ key = "k", mods = "CTRL|SHIFT", action = act.ClearScrollback("ScrollbackAndViewport") },
}

-- max fps (모니터 주사율 이상은 GPU 낭비. hang 완화 목적으로 낮춤)
config.max_fps = 120
config.animation_fps = 60
-- 상태바 업데이트 부하 완화
config.status_update_interval = 1000

-- Mouse configuration
config.selection_word_boundary = " \t\n{}[]()\"'`"
config.mouse_bindings = {
	-- Change the default click behavior so that it only selects
	-- text and doesn't open hyperlinks
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "NONE",
		action = act.CompleteSelection("ClipboardAndPrimarySelection"),
	},
	-- and make CTRL-Click open hyperlinks
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = act.OpenLinkAtMouseCursor,
	},
	-- Font size adjustment with Ctrl+Scroll
	{
		event = { Down = { streak = 1, button = { WheelUp = 1 } } },
		mods = "CTRL",
		action = wezterm.action_callback(function(window, pane)
			local current_config = window:get_config_overrides() or {}
			local current_size = current_config.font_size or current_font_size
			local new_size = math.min(current_size + 1, max_font_size)
			current_config.font_size = new_size
			window:set_config_overrides(current_config)
		end),
	},
	{
		event = { Down = { streak = 1, button = { WheelDown = 1 } } },
		mods = "CTRL",
		action = wezterm.action_callback(function(window, pane)
			local current_config = window:get_config_overrides() or {}
			local current_size = current_config.font_size or current_font_size
			local new_size = math.max(current_size - 1, min_font_size)
			current_config.font_size = new_size
			window:set_config_overrides(current_config)
		end),
	},
}

--[[
============================
Custom Configuration
============================
]]
--

-- Rounded or Square Style Tabs

-- change to square if you don't like rounded tab style
local tab_style = "square"

-- leader active indicator prefix
local leader_prefix = utf8.char(0x1f30a) -- ocean wave

--[[
============================
Colors
============================
--
-- color_scheme not sufficient in providing available colors
-- local colors = wezterm.color.get_builtin_schemes()[color_scheme]

]]
--

local color_scheme = "Catppuccin Macchiato"
config.color_scheme = color_scheme

-- color scheme colors for easy access
local scheme_colors = {
	catppuccin = {
		macchiato = {
			rosewater = "f4dbd6",
			flamingo = "f0c6c6",
			pink = "f5bde6",
			mauve = "c6a0f6",
			red = "ed8796",
			maroon = "ee99a0",
			peach = "#f5a97f",
			yellow = "#eed49f",
			green = "#a6da95",
			teal = "#8bd5ca",
			sky = "#91d7e3",
			sapphire = "#7dc4e4",
			blue = "#8aadf4",
			lavender = "#b7bdf8",
			text = "#cad3f5",
			crust = "#181926",
		},
	},
}

local colors = {
	border = scheme_colors.catppuccin.macchiato.lavender,
	tab_bar_active_tab_fg = scheme_colors.catppuccin.macchiato.mauve,
	tab_bar_active_tab_bg = scheme_colors.catppuccin.macchiato.crust,
	tab_bar_text = scheme_colors.catppuccin.macchiato.crust,
	arrow_foreground_leader = scheme_colors.catppuccin.macchiato.lavender,
	arrow_background_leader = scheme_colors.catppuccin.macchiato.crust,
}

--[[
============================
Border
============================
]]
--

config.window_frame = {
	border_left_width = "0.2cell", -- 0.4
	border_right_width = "0.2cell", -- 0.4
	border_bottom_height = "0.1cell", -- 0.15
	border_top_height = "0.1cell",
	border_left_color = colors.border,
	border_right_color = colors.border,
	border_bottom_color = colors.border,
	border_top_color = colors.border,
}

--[[
============================
Shortcuts
============================
]]
--

-- shortcut_configuration
config.leader = { key = "u", mods = "CTRL", timeout_milliseconds = 2000 }

-- LEADER + a : 다른 탭·윈도우의 pane 을 현재 pane 옆에 붙인다 (d 의 반대).
-- Lua API 에는 pane 을 기존 탭 안으로 옮기는 함수가 없어 `wezterm cli split-pane --move-pane-id` 를 부른다.
-- cli 는 GUI 가 물려준 WEZTERM_UNIX_SOCKET 으로 이 GUI 에 붙으므로 pane id 가 아래 목록과 같다.
-- 1단계 pane 고르기 → 2단계 방향 고르기. 콜백은 로드 시 1회만 만들고 (LEADER + . 치트시트 주석 참조),
-- 1단계에서 고른 pane id 는 2단계 choice id 에 "<pane id> <방향 옵션>" 으로 실어 넘긴다.
local wezterm_cli = wezterm.executable_dir .. "\\wezterm.exe"

-- toast 는 Windows 알림이 꺼져 있으면 보이지 않으므로 로그에도 남긴다 (Debug Overlay 에서 확인)
local function dock_notify(win, msg)
	wezterm.log_warn(msg)
	win:toast_notification("wezterm", msg, nil, 5000)
end

-- client 도메인 (unix_domains 의 mux · SSHMUX:*) 은 upstream 이 옮길 pane id 를 원격 id 로 바꾸지 않고 보내
-- 엉뚱한 pane 이 옮겨진다 (wezterm-client/src/domain.rs 의 ClientDomain::split_pane).
-- 그 밖의 도메인 (local · WSL:* · SSH:*) 끼리는 도메인이 달라도 옮길 수 있다.
local function is_client_domain(name)
	if name:find("^SSHMUX:") then
		return true
	end
	for _, d in ipairs(config.unix_domains or {}) do
		if d.name == name then
			return true
		end
	end
	return false
end

local dock_pick_side = wezterm.action_callback(function(win, p, id)
	if not id then
		return
	end
	local move_id, side = id:match("^(%d+) (%S+)$")
	-- 옮길 pane 은 split 전에 원래 탭에서 먼저 빠진다. 그래서 split 이 실패하면 어느 탭에도 없는 pane 이 되어
	-- 되찾을 수 없다 (mux/src/domain.rs 의 Domain::split_pane). split 실패 조건 (zoom · 공간 부족) 을 먼저 없앤다.
	p:tab():set_zoomed(false)
	local dims = p:get_dimensions()
	if (side == "--right" and dims.cols or dims.viewport_rows) < 3 then
		dock_notify(win, "현재 pane 이 너무 작아 나눌 수 없습니다")
		return
	end
	local ok, _, stderr = wezterm.run_child_process({
		wezterm_cli,
		"cli",
		"--no-auto-start",
		"split-pane",
		"--pane-id",
		tostring(p:pane_id()),
		side,
		"--move-pane-id",
		move_id,
	})
	if not ok then
		dock_notify(win, "pane " .. move_id .. " 붙이기 실패: " .. stderr)
	end
end)

local dock_pick_pane = wezterm.action_callback(function(win, p, id)
	if not id then
		return
	end
	win:perform_action(
		act.InputSelector({
			title = "pane " .. id .. " 을 붙일 방향",
			-- quick-select 문자를 LEADER w / v 와 맞춘다 : 누르는 즉시 실행
			alphabet = "wv",
			description = "w = 좌우 · v = 상하 · Esc = 취소",
			choices = {
				{ id = id .. " --right", label = "좌우 (Horizontal) : 현재 pane 오른쪽에 붙임" },
				{ id = id .. " --bottom", label = "상하 (Vertical)  : 현재 pane 아래에 붙임" },
			},
			action = dock_pick_side,
		}),
		p
	)
end)

local open_dock = wezterm.action_callback(function(win, pane)
	if is_client_domain(pane:get_domain_name()) then
		dock_notify(win, "세션(mux) 창에서는 pane 붙이기를 지원하지 않습니다")
		return
	end
	local here_tab = pane:tab():tab_id()
	-- mux 의 창 목록은 HashMap 순회라 순서가 매번 달라질 수 있다. 창 id 순으로 고정한다.
	local windows = wezterm.mux.all_windows()
	table.sort(windows, function(x, y)
		return x:window_id() < y:window_id()
	end)
	local choices = {}
	for _, mw in ipairs(windows) do
		for i, tab in ipairs(mw:tabs()) do
			if tab:tab_id() ~= here_tab then
				for _, cand in ipairs(tab:panes()) do
					if not is_client_domain(cand:get_domain_name()) then
						table.insert(choices, {
							id = tostring(cand:pane_id()),
							-- tab# 은 탭 바에 보이는 번호 (0 부터)
							label = string.format(
								"pane=%-4d window=%d tab#%d  %s",
								cand:pane_id(),
								mw:window_id(),
								i - 1,
								cand:get_title()
							),
						})
					end
				end
			end
		end
	end
	if #choices == 0 then
		dock_notify(win, "붙일 수 있는 pane 이 없습니다 (다른 탭·윈도우에 없음 · 세션(mux) pane 은 제외)")
		return
	end
	win:perform_action(
		act.InputSelector({
			title = string.format("현재 pane=%d 옆에 붙일 pane", pane:pane_id()),
			fuzzy = true,
			fuzzy_description = "붙일 pane 검색 (↑↓ 이동 · Enter 선택 · Esc 닫기) : ",
			choices = choices,
			action = dock_pick_pane,
		}),
		pane
	)
end)

-- LEADER 단축키 정의 (SSOT) : { 키, 설명, 액션 }
-- 실제 키 바인딩과 치트시트(LEADER + .)가 이 테이블 하나를 공유한다.
local leader_bindings = {
	{ "c", "새 탭 (Create)", act.SpawnTab("CurrentPaneDomain") },
	{ "u", "새 윈도우", act.SpawnWindow },
	{
		"y",
		"현재 pane 전체 텍스트 복사 (스크롤백 포함)",
		wezterm.action_callback(function(win, pane)
			local text = pane:get_logical_lines_as_text(pane:get_dimensions().scrollback_rows)
			win:copy_to_clipboard(text, "Clipboard")
		end),
	},
	{
		"d",
		"현재 pane 을 독립 윈도우로 분리 (Detach)",
		wezterm.action_callback(function(_, pane)
			pane:move_to_new_window()
		end),
	},
	{ "a", "다른 탭·윈도우의 pane 을 현재 pane 옆에 붙이기 (Attach · d 의 반대)", open_dock },
	{
		"s",
		"세션(mux)에 접속 - 창을 닫아도 살아 있는 쪽 (Session)",
		act.AttachDomain("mux"),
	},
	{
		"e",
		"세션에서 빠져나오기 (창만 닫히고 작업은 서버에서 계속)",
		act.DetachDomain("CurrentPaneDomain"),
	},
	{ "x", "현재 pane 닫기 (확인)", act.CloseCurrentPane({ confirm = true }) },
	{ "b", "이전 탭 (Back)", act.ActivateTabRelative(-1) },
	{ "n", "다음 탭 (Next)", act.ActivateTabRelative(1) },
	{ "w", "좌우 분할 (Width)", act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ "v", "상하 분할 (Vertical)", act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ "h", "왼쪽 pane 으로 이동", act.ActivatePaneDirection("Left") },
	{ "j", "아래쪽 pane 으로 이동", act.ActivatePaneDirection("Down") },
	{ "k", "위쪽 pane 으로 이동", act.ActivatePaneDirection("Up") },
	{ "l", "오른쪽 pane 으로 이동", act.ActivatePaneDirection("Right") },
	{ "LeftArrow", "pane 크기 조절 : 왼쪽 5", act.AdjustPaneSize({ "Left", 5 }) },
	{ "RightArrow", "pane 크기 조절 : 오른쪽 5", act.AdjustPaneSize({ "Right", 5 }) },
	{ "DownArrow", "pane 크기 조절 : 아래 5", act.AdjustPaneSize({ "Down", 5 }) },
	{ "UpArrow", "pane 크기 조절 : 위 5", act.AdjustPaneSize({ "Up", 5 }) },
	{ "/", "커맨드 팔레트 (WezTerm 전체 명령 검색)", act.ActivateCommandPalette },
}

-- Add leader keys to the main keys table
for _, b in ipairs(leader_bindings) do
	table.insert(keys, { mods = "LEADER", key = b[1], action = b[3] })
end

for i = 0, 9 do
	-- leader + number to activate that tab
	table.insert(keys, {
		key = tostring(i),
		mods = "LEADER",
		action = act.ActivateTab(i),
	})
end

-- LEADER + . : 위 목록을 그대로 오버레이로 표시. 고르면 그 동작을 실행한다.
-- 맨 위 행에 현재 window/tab/pane id 를 함께 띄운다 (그 행에서 Enter 면 클립보드로 복사).
-- 단축키 목록(choices)은 정적이라 config 로드 시점에 1회만 만든다.
-- 콜백도 아래 둘을 로드 시 1회씩만 만든다 — 키 핸들러 안에서 wezterm.action_callback 을 부르면
-- 누를 때마다 새 이벤트 핸들러가 등록되어 계속 쌓인다. 누를 때 새로 만드는 것은 순수 테이블뿐이다.
local cheatsheet_choices = {}
do
	local function add(key, desc, id)
		table.insert(cheatsheet_choices, { id = id or key, label = string.format("%-12s%s", key, desc) })
	end
	for _, b in ipairs(leader_bindings) do
		add(b[1], b[2])
	end
	add("0 - 9", "해당 번호의 탭 활성화   (안내 · 여기서 누르지 말 것)", "")
	add(".", "이 목록   (안내)", "")
end

-- id 행과 단축키 행을 가르는 접두어. 이 접두어가 붙은 항목은 동작 실행이 아니라 클립보드 복사다.
local ID_COPY_PREFIX = "copy-ids:"

local cheatsheet_pick = wezterm.action_callback(function(win, p, id)
	if not id or id == "" then
		return
	end
	if id:sub(1, #ID_COPY_PREFIX) == ID_COPY_PREFIX then
		win:copy_to_clipboard(id:sub(#ID_COPY_PREFIX + 1))
		return
	end
	for _, b in ipairs(leader_bindings) do
		if b[1] == id then
			win:perform_action(b[3], p)
			return
		end
	end
end)

-- id 는 창·pane 마다 다르므로 누르는 그 시점에 읽는다.
local open_cheatsheet = wezterm.action_callback(function(win, pane)
	local ids =
		string.format("window=%d tab=%d pane=%d", win:window_id(), win:active_tab():tab_id(), pane:pane_id())

	local choices = {
		{ id = ID_COPY_PREFIX .. ids, label = string.format("%-12s%s", "(id)", ids .. "   Enter → 클립보드 복사") },
	}
	for _, c in ipairs(cheatsheet_choices) do
		table.insert(choices, c)
	end

	win:perform_action(
		act.InputSelector({
			title = "LEADER (Ctrl+U) 단축키   " .. ids,
			-- fuzzy 를 켜지 않으면 각 행 앞에 quick-select 문자(1,2,3..a,b,c..)가 붙고,
			-- 그 문자가 화면에 적힌 단축키와 어긋난다 (예: 4 -> "4번 탭" 이 아니라 4번째 행 = pane 닫기).
			-- 도움말이 오히려 오조작을 유발하므로 검색 모드로 고정한다.
			fuzzy = true,
			fuzzy_description = ids .. "  ·  단축키 검색 (↑↓ 이동 · Enter 실행 · Esc 닫기) : ",
			choices = choices,
			action = cheatsheet_pick,
		}),
		pane
	)
end)

table.insert(keys, { mods = "LEADER", key = ".", action = open_cheatsheet })

-- Set the final keys configuration
config.keys = keys

--[[
============================
Tab Bar
============================
]]
--

-- tab bar
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = true

local function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local title = " " .. tab.tab_index .. ": " .. tab_title(tab) .. " "
	local left_edge_text = ""
	local right_edge_text = ""

	if tab_style == "rounded" then
		title = tab.tab_index .. ": " .. tab_title(tab)
		title = wezterm.truncate_right(title, max_width - 2)
		left_edge_text = wezterm.nerdfonts.ple_left_half_circle_thick
		right_edge_text = wezterm.nerdfonts.ple_right_half_circle_thick
	end

	-- ensure that the titles fit in the available space,
	-- and that we have room for the edges.
	-- title = wezterm.truncate_right(title, max_width - 2)

	if tab.is_active then
		return {
			{ Background = { Color = colors.tab_bar_active_tab_bg } },
			{ Foreground = { Color = colors.tab_bar_active_tab_fg } },
			{ Text = left_edge_text },
			{ Background = { Color = colors.tab_bar_active_tab_fg } },
			{ Foreground = { Color = colors.tab_bar_text } },
			{ Text = title },
			{ Background = { Color = colors.tab_bar_active_tab_bg } },
			{ Foreground = { Color = colors.tab_bar_active_tab_fg } },
			{ Text = right_edge_text },
		}
	end
end)

-- Add new tab button click handler
wezterm.on("new-tab-button-click", function(window, pane, button, default_action)
	-- Show launcher menu when new tab button is clicked
	window:perform_action(act.ShowLauncher, pane)
	-- Return false to prevent default action (creating new tab)
	return false
end)

--[[
============================
Leader Active Indicator
============================
]]
--

wezterm.on("update-status", function(window, _)
	-- leader inactive
	local solid_left_arrow = ""
	local arrow_foreground = { Foreground = { Color = colors.arrow_foreground_leader } }
	local arrow_background = { Background = { Color = colors.arrow_background_leader } }
	local prefix = ""

	-- leaader is active
	if window:leader_is_active() then
		prefix = " " .. leader_prefix

		if tab_style == "rounded" then
			solid_left_arrow = wezterm.nerdfonts.ple_right_half_circle_thick
		else
			solid_left_arrow = wezterm.nerdfonts.pl_left_hard_divider
		end

		local tabs = window:mux_window():tabs_with_info()

		if tab_style ~= "rounded" then
			for _, tab_info in ipairs(tabs) do
				if tab_info.is_active and tab_info.index == 0 then
					arrow_background = { Foreground = { Color = colors.tab_bar_active_tab_fg } }
					solid_left_arrow = wezterm.nerdfonts.pl_right_hard_divider
					break
				end
			end
		end
	end

	window:set_left_status(wezterm.format({
		{ Background = { Color = colors.arrow_foreground_leader } },
		{ Text = prefix },
		arrow_foreground,
		arrow_background,
		{ Text = solid_left_arrow },
	}))
end)

--[[
============================
Stability / Freeze Workarounds
============================
]]
-- Render backend (freeze 회피용)
-- 우선순위: WebGpu (빠름/안정) → OpenGL → Software (가장 안정, CPU 렌더)
-- hang 이 계속되면 "Software" 로 변경
-- config.front_end = "Software"
-- config.front_end = "OpenGL"
config.front_end = "WebGpu"
-- 내장 GPU(AMD)로 렌더 — HighPerformance 는 창마다 RTX 2060 VRAM 을 수백 MB~1.6GB 씩 점유해
-- qmd 등 로컬 LLM 이 VRAM 부족으로 실패했다 (2026-10-20). 렌더 문제가 생기면 "HighPerformance" 로 되돌린다.
config.webgpu_power_preference = "LowPower"

-- 참고: 종료 코드와 상관없이 닫고 싶다면
config.exit_behavior = "Close"
config.window_close_confirmation = "NeverPrompt"

-- 세션 유지용 mux 도메인 (창을 닫아도 안의 작업이 계속 돈다)
-- 서버는 처음 붙을 때 알아서 뜬다. 평소에는 평범한 로컬 창으로 열리고,
-- 세션에 붙고 싶을 때만 LEADER + s (또는 `wezterm connect mux`) 로 들어간다.
config.unix_domains = { { name = "mux" } }

-- 아래를 켜면 WezTerm 을 띄울 때마다 자동으로 mux 에 붙는다.
-- 새 창을 열어도 전부 같은 세션을 비추게 되므로 꺼 둔다.
-- (그 상태에서 평범한 창이 필요하면 `wezterm start`)
-- config.default_gui_startup_args = { "connect", "mux" }

-- and finally, return the configuration to wezterm
return config
