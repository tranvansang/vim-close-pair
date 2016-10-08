Vim Close Pair
==============
A Vim plugin to find last opening brace and insert corresponding closing brace

Install
-------
*	With [Vundle](https://github.com/VundleVim/Vundle.vi://github.com/VundleVim/Vundle.vim)

	- Append `Plugin ‘tranvansang/vim-close-pair’` to your `.vimrc`
	- Restart vim or run `:source ~/.vimrc`
	- Run `:PluginInstall`

*	Manual

		git checkout https://github.com/tranvansang/vim-close-pair.git
		cd vim-close-pair
		mkdir -p ~/.vim/plugin
		cp -f plugin/close-pair.vim ~/.vim/plugin/
		mkdir -p ~/.vim/autoload
		cp -f autoload/close-pair.vim ~/.vim/autoload/

Usage
-----
In insert mode, type `Ctrl-L`

- Text   : `({[ [foo] bar (foo) bar`
- Result : `({[ [foo] bar (foo) bar]`

Options
-------
Set values here are the default

*	Binding key. Becareful when set this option, because it is bound it insert mode and may caught trouble when typing.

	Set empty(`’’`) to disable this plugin

	```
	let g:close_pair_key = ‘<C-L>’
	```

*	Maximal number of lines to scan for opening braces.

	Set `0` to disable this plugin, `-1` for unlimit (scan until first line)

	This option is combined with `g:close_pair_characters_limit`.
	
	Scanning will stop when any of both limits reached.

	```
	let g:close_pair_lines_limit = -1
	```

*	Maximal number of characters to scan.

	Set `0` to disable this plugin, `-1` for unlimit (scan until first character in buffer)

	This option is combined with `g:close_pair_lines_limit`.
	
	Scanning will stop when any of both limits reached.

	```
	let g:close_pair_characters_limit = -1
	```

*	Just move cursor right if the closing brace is already inserted

	```
	let g:close_pair_ignore_if_matched = 1
	```

	Example:

	- Text  : `(|)` (`|`: cursor position)
	- Result :
		- When this option is enabled: `()|`
		- When this options is disabled: `()|)`
	
NOTE
----
*	This plugin parses only pairs in `matchpairs` option.

*	For HTML tag, you should use system completion (`<C-x><C-o>`) for better effect.

	Example:

	- Text   : `<header>foo</|` (`|`   : cursor position)
	- Type   : `<C-x><C-o>`
	- Result : `<header>foo</header>|`
