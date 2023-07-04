-- see https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md
-- adding local vars here to remove error diagnostics - these are globally defined
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
return {
        s(
                { trig = "bye", dscr = "My mail signature" },
                {
                        t({ 'Out of Cheese Error ++++REDO FROM START++++', '- David Egan' })
                }
        ),
        s(
                { trig = "match", dscr = "Structural pattern matching" },
                {
                        t('match '),
                        i(1, 'expression'),
                        t({ ':', '    case ' }),
                        i(2, 'pattern_1'),
                        t({ ':', '        ' }),
                        i(3, 'pass'),
                        t({ '', '    case ' }),
                        i(4, 'pattern_2'),
                        t({ ':', '        ' }),
                        i(0, 'pass')
                }
        ),
        s(
                { trig = "cc", dscr = "deep nesting", snippetType = "autosnippet" },
                {
                        t('C'),
                        i(1),
                        t(' '),
                        i(2, 'N+'),
                        t(' '),
                        i(3, 'N-'),
                        t(' '),
                        i(4, 'value'),
                        c(5,
                                { sn(nil,
                                        { t(' '), i(1, 'a_1'), t(' '), i(2, 'a_2'),
                                                c(3, { sn(nil, { t(' '), i(1, 'deep') }), t('') }) }), t('') })
                }
        ),
        s(
                { trig = "q" },
                {
                        t('Your age: '),
                        c(1, { t('<18'), t('18~60'), t('>60') }),
                        t({ '', 'Your height: ' }),
                        c(2, { t('<120cm'), t('120cm~180cm'), t('>180cm') })
                }
        ),
        s(
                { trig = "dint", dscr = "definit integral", snippetType = "autosnippet", priority = 300 },
                {
                        t('\\int_{'),
                        i(1, '-\\infty'),
                        t('}^{'),
                        i(2, '\\infty'),
                        t('} '),
                        i(3, 'integrand'),
                        t(' {\\mathrm{d} '),
                        i(4, 'x'),
                        t('}')
                }

        -- { condition = math }
        ),
}
