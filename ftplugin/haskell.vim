" MoveFileToModuleName loads the destination Haskell file while it is running,
" which triggers re-loading this script.  We must avoid attempting to redefine
" MoveFileToModuleName while it is running.
if ! exists("s:loaded")

  " Line number of module declaration
  function! FindHaskellModuleDeclaration()
    for l:i in range(line('$'))
      let l:l = getline(l:i + 1)
      if l:l =~ '^\s*module '
        return l:i + 1
      endif
    endfor
    echoerr 'Could not find module line'
  endfunction

  " 'module Data.Maybe ...' -> ['Data', 'Maybe']
  function! HaskellModuleNameFromModuleDeclaration()
    return split(split(getline(FindHaskellModuleDeclaration()))[1], '\.')
  endfunction

  " ~/base/src/Data/Maybe.hs -> '~/base/src'
  function! HaskellBaseDirectory()
    let l:dir = expand('%:p:h')
    while l:dir != '/'
      let l:upercase_dir_name = fnamemodify(l:dir, ':t') =~ '^\u.*'
      let l:cabal_file_present = glob(l:dir . '/*.cabal')
      if !l:upercase_dir_name || l:cabal_file_present
        " This is imprecise, but often works.  Parsing the cabal file for
        " hs-source-dirs would be more accurate.
        return l:dir
      endif
      let l:dir = fnamemodify(l:dir, ':h')
    endwhile
    echoerr 'Could not find Haskell base directory'
  endfunction

  " ~/base/src/Data/Maybe.hs -> ['Data', 'Maybe']
  function! HaskellModuleNameFromFileName()
    return split(expand('%:p:r')[len(HaskellBaseDirectory()):], '/')
  endfunction

  " ['Data', 'Maybe'] -> 'module Data.Maybe ...'
  function! SetHaskellModuleName(new_name)
    let l:lineno = FindHaskellModuleDeclaration()
    let l:declaration = getline(l:lineno)
    let l:suffix = substitute(l:declaration, '^\s*module\s\+\S\+', '', '')
    call setline(l:lineno, 'module ' . join(a:new_name, '.') . suffix)
  endfunction

  " ['Data', 'Maybe'] -> ~/base/src/Data/Maybe.hs
  function! MoveFileToModuleName(new_name)
    let l:new_path = join([HaskellBaseDirectory()] + a:new_name, '/') . '.hs'
    execute 'Move ' . l:new_path
  endfunction

  " Change the module declaration to match the filename
  command! FixHaskellModuleDeclaration
    \ if HaskellModuleNameFromModuleDeclaration() !=# HaskellModuleNameFromFileName() |
    \   call SetHaskellModuleName(HaskellModuleNameFromFileName()) |
    \ endif

  " Change the filename (move the file) to match the module declaration
  command! FixHaskellFilename
    \ if HaskellModuleNameFromModuleDeclaration() !=# HaskellModuleNameFromFileName() |
    \   call MoveFileToModuleName(HaskellModuleNameFromModuleDeclaration()) |
    \ endif

  let s:loaded = 1
endif
