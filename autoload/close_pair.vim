" TODO: generate doc file
" TODO: insert in normal mode and visual mode mechanism
" TODO: find out better solution for missing brace. Eg, [(]
" TODO: briefly show a note in the status bar
" TODO: find solution to close quotes(', ", `) and HTML tag
"
" Treated pairs: matchpairs options. It's hard to control ' and \"

function! close_pair#init()
	let g:close_pair#open_pairs_list = {}
	let g:close_pair#close_pairs_list = {}
	for pairs in split(&matchpairs, ",")
		let pp = split(pairs, ":")
		let open = get(pp, 0, '')
		let close = get(pp, 1, '')
		if open != '' && close != ''
			let g:close_pair#open_pairs_list[open] = close
			let g:close_pair#close_pairs_list[close] = open
		endif
	endfor

	let g:close_pair#inited = 1
endfunction

function! close_pair#try_close()
	if !exists('g:close_pair#inited') || !g:close_pair#inited
		call close_pair#init()
	end

	let char = close_pair#get_char()

	if char == ''
		return char
	endif

	if char == getline('.')[col('.')-1] && g:close_pair_ignore_if_matched
		return "\<Right>"
	endif

	return char
endfunction

function! close_pair#get_char()
	"count by open brace
	let pairs_count = {}

	let current_lineno = line('.')
	let lineno = current_lineno
	let all_character_count = 0
	"init pair count
	let pairs_count = {}

	while lineno > 0 && (g:close_pair_lines_limit < 0 || current_lineno - lineno < g:close_pair_lines_limit) && (g:close_pair_characters_limit < 0 || g:close_pair_characters_limit > all_character_count)
		let line = getline(lineno)

		if lineno == current_lineno
			let last_pos = col('.') - 1
		else
			let last_pos = col([lineno, '$']) - 1
		endif

		let before = strpart(line, 0, last_pos)
		let prev_chars = split(before, '\zs')

		" for next loop
		let lineno -= 1

		"check for any error if exists
		if last_pos == -1
			continue
		endif


		let off = 1
		while off <= last_pos
			if g:close_pair_characters_limit >= 0
				let all_character_count += 1
				if all_character_count >= g:close_pair_characters_limit
					return ''
				endif
			endif
			let key = get(prev_chars, -off)

			" Find out a open brace
			if has_key(g:close_pair#open_pairs_list, key)
				if !has_key(pairs_count, key) || pairs_count[key] == 0
					echo pairs_count
					return g:close_pair#open_pairs_list[key]
				else
					let pairs_count[key] -= 1
				endif
			endif

			" Find out a close brace
			if has_key(g:close_pair#close_pairs_list, key)
				let key = g:close_pair#close_pairs_list[key]
				if !has_key(pairs_count, key)
					let pairs_count[key] = 1
				else
					let pairs_count[key] += 1
				end
			endif
			let off += 1
		endwhile
	endwhile

	return ''

endfunction
