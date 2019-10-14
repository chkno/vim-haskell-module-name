call delete("Foo.hs")
call delete("Bar.hs")
e Foo.hs
normal! imodule Bar where
write
FixHaskellModuleDeclaration
echo "File is " . fnamemodify(expand("%"), ":t")
call vimtest#SaveOut()
call delete("Foo.hs")
call delete("Bar.hs")
call vimtest#Quit()
