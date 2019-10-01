Haskell Module Name vim plugin
------------------------------

This plugin provides two vim commands for maintaining consistency between Haskell source filenames and module declarations.

*`:FixHaskellModuleDeclaration`* changes the declaration to match the filename.

*`:FixHaskellFilename`* moves the file to match the declaration.  Requires [Eunuch](https://github.com/tpope/vim-eunuch).

No default bindings are provided.  Example bindings:

```vim
noremap <Leader>mn :FixHaskellModuleDeclaration<CR>  " _M_odule, _N_ame
noremap <Leader>mm :FixHaskellFilename<CR>           " _M_odule, _M_ove
```
