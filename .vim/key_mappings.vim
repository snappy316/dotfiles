" Esc to normal mode in terminal
tnoremap <Esc><Esc> <C-\><C-n>

" NERDTree
map <C-n> :NERDTreeToggle<CR>
map <C-p> :Files<CR>

" VTR
nnoremap <leader>ra :VtrAttachToPane<cr>
nnoremap <leader>rf :VtrFocusRunner<cr>
nnoremap <leader>rr :VtrSendLinesToRunner<cr>
nnoremap <leader>rd :VtrSendCtrlD<cr>
nnoremap <leader>sf :VtrSendFile<cr>

" vim-test
nnoremap <leader>T :TestFile<CR>
nnoremap <leader>t :TestNearest<CR>
nnoremap <leader>l :TestLast<CR>
nnoremap <leader>a :TestSuite<CR>
