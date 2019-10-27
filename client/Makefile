all: src/generated/Api.elm ../assets/index.html

src/generated/Api.elm: GenerateElm.hs ../server/src/Lib.hs
	(cd ../ ; stack exec -- runhaskell -iserver/src client/GenerateElm.hs)

../assets/index.html: src/Main.elm
	elm make src/Main.elm
	mv index.html ../assets/
