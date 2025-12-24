set background=dark
highlight clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name = "naysayer_alt"

" Core Palette
" Background: #062329 (Dark Teal)
" Foreground: #d1b171 (Tan/Bone)
" Green 1:    #44b340 (Functions/Keywords)
" Green 2:    #7ad164 (Strings/Success)
" Highlight:  #103038 (Subtle Line)

" General UI
hi Normal       guifg=#d1b171 guibg=#062329
hi CursorLine   guibg=#103038 gui=none
hi LineNr       guifg=#44b340 guibg=#031a1f
hi CursorLineNr guifg=#d1b171 gui=bold
hi VertSplit    guifg=#103038 guibg=#103038
hi Search       guifg=#062329 guibg=#d1b171
hi Visual       guibg=#1e4d57

" Syntax Highlighting (Easy on the eyes)
hi Comment      guifg=#506d73 gui=italic
hi Constant     guifg=#d1b171 gui=bold
hi String       guifg=#7ad164
hi Character    guifg=#7ad164

hi Identifier   guifg=#d1b171 gui=none
hi Function     guifg=#44b340 gui=bold

hi Statement    guifg=#44b340 gui=none
hi PreProc      guifg=#7ad164
hi Type         guifg=#44b340 gui=none
hi Special      guifg=#7ad164
hi Todo         guifg=#062329 guibg=#7ad164 gui=bold

" Errors and Warnings
hi Error        guifg=#ff3131 guibg=NONE gui=undercurl
hi WarningMsg   guifg=#e6e139

