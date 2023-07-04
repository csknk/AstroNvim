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
	s(
		{ trig = "pf", dscr = "fmt.Printf(\"$1\n\", $2)" },
		fmt(
			[[
			fmt.Printf("{}\n", {})
			]],
			{ i(1, "%v"), i(2, "x") }
		)
	),
	s(
		{ trig = "readinlines", dscr = "Read lines from filepath to slice of strings" },
		{
			i(1, 'f'),
			t(', err := os.Open('),
			i(2, 'inFilePath'),
			t({ ')', 'if err != nil {', '\tlog.Fatal(err)', '}', 'defer ' }),
			i(1, 'f'),
			t({ '.Close()', 'sc := bufio.NewScanner(f)', '' }),
			i(3, 'lines'),
			t({ ' := []string{}', 'for sc.Scan() {', '\t' }),
			i(3, 'lines'),
			t(' = append('),
			i(3, 'lines'),
			t({ ', sc.Text())', '}' })
		}
	),
	s(
		{ trig = "openwrite", dscr = "Open a file for writing/reading" },
		{
			i(1, 'outfile'),
			t(', err := os.OpenFile('),
			i(2, 'path'),
			t(', '),
			i(3, 'os.O_CREATE|os.O_RDWR'),
			t(', '),
			i(4, '0644'),
			t({ ')', 'if err != nil {', '\t' }),
			i(5, 'log.Fatal(err)'),
			t({ '', '}', 'defer ' }),
			i(1, 'outfile'),
			t('.Close()')
		}
	),
	s(
		{ trig = "connect", dscr = "Connect to a Tendermint node" },
		{
			t({ '// Establish a connection to Tendermint node', 'nc, err := qredochain.NewNodeConnector(' }),
			i(1, 'config.HostIP'),
			t('+":"+'),
			i(2, 'config.Port'),
			t({ ', nil)', 'if err != nil {', '\tlog.Fatal(err)', '}', 'defer nc.Stop()' })
		}
	),
	s(
		{ trig = "rce", dscr = "Return custom error" },
		{
			t('return fmt.Errorf("'),
			i(1, 'message'),
			i(2, '%s'),
			t(': %w", '),
			i(3, 'var'),
			t(', err)')
		}
	),
	s(
		{ trig = "rne", dscr = "Return new error" },
		{
			t('return fmt.Errorf("'),
			i(1, 'error message'),
			t('")')
		}
	),
	s(
		{ trig = "loglines", dscr = "Log line numbers" },
		{
			t('log.SetFlags(log.LstdFlags | log.Lshortfile)')
		}
	),
	s(
		{ trig = "logtofile", dscr = "Log a message to a file" },
		{
			t('func logToFile('),
			i(1, 'message'),
			t({ ' string) {', '\tf, err := os.OpenFile("/home/david/logs/' }),
			c(2, { sn(nil, { t('`date +"%d-%m-%Y:%H:%M:%S"`'), t('.log') }), t('') }),
			t({ '", os.O_WRONLY|os.O_CREATE|os.O_APPEND, 0644)', '\tif err != nil {', '\t\tlog.Fatal(err)', '\t}',
				'\tdefer f.Close()', '\tw := bufio.NewWriter(f)', '\tfmt.Fprintf(w, "%s\\n---\\n", message)',
				'\tw.Flush()', '}' })
		}
	),
	s(
		{ trig = "qrlicence", dscr = "Qredo licence block" },
		{
			t({ '/*', 'Licensed to the Apache Software Foundation (ASF) under one',
				'or more contributor license agreements.  See the NOTICE file',
				'distributed with this work for additional information',
				'regarding copyright ownership.  The ASF licenses this file',
				'to you under the Apache License, Version 2.0 (the',
				'"License"); you may not use this file except in compliance',
				'with the License.  You may obtain a copy of the License at', '',
				'  http://www.apache.org/licenses/LICENSE-2.0', '',
				'Unless required by applicable law or agreed to in writing,',
				'software distributed under the License is distributed on an',
				'"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY',
				'KIND, either express or implied.  See the License for the',
				'specific language governing permissions and limitations', 'under the License.', '*/' })
		}
	),
	s(
		{ trig = "ignore", dscr = "Mark for compiler ignore" },
		{
			t('//go:build test')
		}
	),
}
