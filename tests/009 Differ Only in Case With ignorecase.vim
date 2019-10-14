set ignorecase
call delete("Foobar.hs")
call delete("FooBar.hs")
e Foobar.hs
normal! imodule FooBar where
normal! oa = a
write
FixHaskellModuleDeclaration
echo "File is " . fnamemodify(expand("%"), ":t")
call vimtest#SaveOut()
call delete("Foobar.hs")
call delete("FooBar.hs")
call vimtest#Quit()
