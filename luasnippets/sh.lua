local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local fmt = require("luasnip.extras.fmt").fmt
return {
	-- s(
	-- 	{trig="w", dscr="wrap"},
	-- 	{
	-- 		t('\\"\\$\\{'),
	-- 		i(Tree(Token('RULE', 'visual'), [])),
	-- 		t('\\}\\"')
	-- 	}
	-- ),
	s(
		{ trig = "exists" },
		{
			t({ 'function program_exists {', '\ttype "\\' }),
			i(1),
			t({ '" > /dev/null 2>&1', '\treturn $?', '}' })
		}
	),
	s(
		{ trig = "heredoc" },
		{
			t({ 'cat <<- EOF', '' }),
			i(1, 'message'),
			t({ '', 'EOF' })
		}
	),
	s(
		{ trig = "usage" },
		{
			t({ 'function usage() {', '\tcat <<- EOF', '\t' }),
			i(1, 'This is a message'),
			t({ '', '\t\\' }),
			i(0),
			t(' '),
			i(2, ' parameters'),
			t({ ' ', '\tEOF', '}' })
		}
	),
	s(
		{ trig = "saferm" },
		{
			t('rm -rf "\\$\\{'),
			i(1, 'DATADIR'),
			t(':?\\}"/')
		}
	),
	s(
		{ trig = "getopt" },
		{
			t('while getopts ":h'),
			i(1),
			i(3),
			t({ '" opt; do', '\tcase $opt in', '\t\th )  usage; exit 0', '\t\t\t;;', '\t\t' }),
			rep(1),
			t(' ) '),
			i(2, 'command'),
			t({ ';', '\t\t\t;;', '\t\t' }),
			rep(3),
			t(' ) '),
			i(4, 'command'),
			t({ ';', '\t\t\t;;', '\t\t* ) echo -e "\\nOption does not exist : $OPTARG\\n"; usage; exit 1', '\t\t\t;;',
				'\tesac', 'done', 'shift $((OPTIND-1))' })
		}
	),
}
