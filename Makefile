lutro:
	zip -9 -r Vespa.lutro ./*

js:
	python3 ~/emsdk/upstream/emscripten/tools/file_packager.py Vespa.data --preload ./* --js-output=Vespa.js

clean:
	@$(RM) -f Vespa.*

.PHONY: all clean
