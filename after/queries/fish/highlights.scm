;; extends

; builtins

(command
	name: (word) @function.builtin
	(#any-of? @function.builtin "abbr" "path")
)

(for_statement "in" @keyword.repeat)

((variable_name) @variable.builtin (#any-of? @variable.builtin
	"argv"
	"BROWSER"
	"CDPATH"
	"CMD_DURATION"
	"COLUMNS"
	"EUID"
	"fish_ambiguous_width"
	"fish_autosuggestion_enabled"
	"fish_complete_path"
	"fish_cursor_selection_mode"
	"FISH_DEBUG"
	"FISH_DEBUG_OUTPUT"
	"fish_emoji_width"
	"fish_escape_delay_ms"
	"fish_function_path"
	"fish_greeting"
	"fish_handle_reflow"
	"fish_history"
	"fish_key_bindings"
	"fish_kill_signal"
	"fish_killring"
	"fish_pid"
	"fish_read_limit"
	"fish_sequence_key_delay_ms"
	"fish_term24bit"
	"fish_term256"
	"fish_trace"
	"fish_user_paths"
	"history"
	"HOME"
	"hostname"
	"IFS"
	"LANG"
	"last_pid"
	"LC_ALL"
	"LC_COLLATE"
	"LC_CTYPE"
	"LC_MESSAGES"
	"LC_MONETARY"
	"LC_NUMERIC"
	"LINES"
	"PATH"
	"pipestatus"
	"PWD"
	"SHLVL"
	"status"
	"status_generation"
	"TERM"
	"umask"
	"version"
))

((variable_name) @variable.builtin (#match? @variable.builtin "^fish_(pager_)?color"))

; punctuation

(glob) @character.special

(double_quote_string (command_substitution ["$" "(" ")"] @punctuation.special))
(variable_expansion "$" @punctuation.special)
