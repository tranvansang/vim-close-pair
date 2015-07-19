" binding key. Empty to disable
if !exists('g:close_pair_key')
	let g:close_pair_key = '<C-L>'
end

"0 means disable
if !exists('g:close_pair_lines_limit')
	let g:close_pair_lines_limit = -1
end

"0 means disable
if !exists('g:close_pair_characters_limit')
	let g:close_pair_characters_limit = -1
end

if !exists('g:close_pair_ignore_if_matched')
	let g:close_pair_ignore_if_matched = 1
end

if g:close_pair_key != ""
	exe 'inoremap <silent> '. g:close_pair_key .' <C-R>=close_pair#try_close()<CR>'
endif
