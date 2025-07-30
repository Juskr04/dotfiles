let g:MAX_SIZE = 5
let g:buffer_list = []
let g:buffer_name_list = []
let g:cursor_posn_bs = []
let g:cursor_posn_bs_str = ""
let g:cursor_posn_bs_liststr = ""

function! SetBufferIndex()
	if len(g:buffer_list) <= g:MAX_SIZE
		call add(g:buffer_list, bufnr('%'))
		call add(g:buffer_name_list, bufname())
		let b = len(g:buffer_list)-1
		echo "Buffer saved to Index ".b
	else 
		echo "NO MORE BUFFERS FOR YOU"
	endif
endfunction

function! LoadBuffer(index)
	execute 'silent b'.g:buffer_list[a:index]
endfunction

function! Record_cursorposn()
	let b:cursor_posn = getpos('.')
endfunction

function! Restore_cursorposn()
	call setpos('.', b:cursor_posn)
endfunction

function! Write_cursorposn()
	let g:final_state = repeat([''], len(g:buffer_list))
	for i in range(len(g:buffer_list))
		execute 'silent b'.g:buffer_list[i]
		call add(g:cursor_posn_bs, b:cursor_posn)
	endfor
	let g:cursor_posn_bs_str = join(map(g:cursor_posn_bs, 'string(v:val)'), ',') 
	let g:cursor_posn_bs_str = g:cursor_posn_bs_str[:len(g:cursor_posn_bs_str)-2]
	let g:cursor_posn_bs_liststr = split(g:cursor_posn_bs_str, '],')
	for i in range(len(g:cursor_posn_bs))
		let g:cursor_posn_bs_liststr[i] .= ']'
	endfor
	for i in range(len(g:buffer_list))
		let g:buffer_name_list[i] .= ' '
		let g:final_state[i] .= g:buffer_name_list[i].g:cursor_posn_bs_liststr[i]
	endfor
	call writefile(g:final_state, './.harpclone') 
	execute "q"
endfunction

function! Opt_save()
	if len(g:buffer_list) != 0
		let choice = inputdialog('Do you want to save your harpclone session : ' )
		if choice == 1
			echo "\n"."You chose Yes!"
			call Write_cursorposn()
		elseif choice == 0
		echo "\n"."You chose No!"
			execute 'q'
		else
			echo "\n"."choose either 1 or 0"
			call Opt_save()
		endif
	else
		execute 'q'
	endif
endfunction

function! Load_session()
	let lines = readfile('./.harpclone')
	for i in range(len(lines))
		execute 'silent e ./.harpclone'
		let first_sb = match(getline(i+1), '[')
		let last_sb = match(getline(i+1), ']')
		let cursorposn_str = getline(i+1)[first_sb:last_sb]
		let clean_cursorposn = substitute(cursorposn_str, '^\[\|\]$', '', '')
		let cursorposn_list = split(clean_cursorposn, ',\s*')
		let cursorposn = map(cursorposn_list, {_, v -> str2nr(v)})
		let strname = getline(i+1)[0:first_sb-2]
		execute 'silent e '.strname
		call SetBufferIndex()
		call setpos('.', cursorposn)
		execute 'silent b ./.harpclone'
		execute 'bw'
	endfor
	echo "loading harpclone session was successful"
endfunction

function! ResetBufferIndex(index)
	let index = index(g:buffer_list, bufnr())
	if index != -1
		let a = a:index + 1
		call insert(g:buffer_list, bufnr(), a)
		call remove(g:buffer_list, a:index)
		call remove(g:buffer_list, index)

		call insert(g:buffer_name_list, bufname(), a)
		call remove(g:buffer_name_list, a:index)
		call remove(g:buffer_name_list, index)

		echo "Now, This buffer is saved to Index ".a:index
	else
		echo "this buffer is not in the buffer list"
	endif
endfunction

function! Reload()
	if len(g:buffer_list) != 0
		let currentbuff = bufnr()
		for i in range(len(g:buffer_list))
			call LoadBuffer(i)
		endfor
		execute 'b'.currentbuff
		echo "RELOADED"
	endif
endfunction

function! Delete_buffer()
	let index = index(g:buffer_list, bufnr())
	if index != -1
		call remove(g:buffer_list, index)
		echo "current buffer removed from the buffer list"
	else
		echo "this buffer is not in the buffer list"
	endif
endfunction
