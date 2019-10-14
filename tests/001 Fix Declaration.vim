call delete("Foo.hs")
call delete("Bar.hs")
e Foo.hs
normal! imodule Bar where
normal! oa = a
write
FixHaskellModuleDeclaration
echo "File is " . expand("%")
call vimtest#SaveOut()
call delete("Foo.hs")
call delete("Bar.hs")
call vimtest#Quit()
