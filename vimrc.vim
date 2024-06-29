" == AUTOCMD ================================ 
autocmd BufNewFile,BufRead *.ts                setlocal filetype=typescript
autocmd BufNewFile,BufRead *.tsx               setlocal filetype=typescript.tsx
autocmd BufNewFile,BufRead *.handlebars        setlocal filetype=html
autocmd BufNewFile,BufRead *.hbs               setlocal filetype=html
autocmd BufNewFile,BufRead tsconfig.json       setlocal filetype=jsonc

