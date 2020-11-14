OUT = out/
RES = res/
LOVE_FILE = dist/FishNShips.love

build: clean
	mkdir -p $(OUT)
	moonc -t $(OUT) src/*.moon
	mv $(OUT)/src/* $(OUT)/
	cp $(RES)/* $(OUT)/

run: build
	love $(OUT)

clean:
	rm -rf $(OUT)/*
	rm -f FishNShips-win.zip
	rm -f FishNShips.love
	rm -f FishNShips-macos.zip
	rm -f $(LOVE_FILE)
	rm -f dist/FishNShips.exe
	rm -rf dist/FishNShips.app

$(LOVE_FILE): build
	zip -9 -r -j $@ out/

dist-win: $(LOVE_FILE)
	cat dist/love.exe $< > dist/FishNShips.exe
	zip -r -j FishNShips-win.zip dist/license.txt dist/FishNShips.exe dist/win-dll/

dist-linux: $(LOVE_FILE)
	cp $< FishNShips.love

dist-mac: $(LOVE_FILE)
	cd dist && unzip FishNShips-macos-base.zip
	cp $< dist/FishNShips.app/Contents/Resources
	cd dist && zip -y ../FishNShips-macos.zip FishNShips.app

dist-all: dist-win dist-linux dist-mac
