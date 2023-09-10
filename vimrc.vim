let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-emmet', 'coc-css', 'coc-html',
\    'coc-json', 'coc-yank', 'coc-prettier', 'coc-java', 'coc-jedi', 'coc-deno', 'coc-yaml', 'coc-xml']

command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

" == AUTOCMD ================================ 
autocmd BufNewFile,BufRead *.ts                setlocal filetype=typescript
autocmd BufNewFile,BufRead *.tsx               setlocal filetype=typescript.tsx
autocmd BufNewFile,BufRead *.handlebars        setlocal filetype=html
autocmd BufNewFile,BufRead *.hbs               setlocal filetype=html
autocmd BufNewFile,BufRead tsconfig.json       setlocal filetype=jsonc

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" == AUTOCMD END ================================

