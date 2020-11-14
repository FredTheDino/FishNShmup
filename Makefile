OUT=out/
RES=res/

build:
	rm -rf $(OUT)/*
	mkdir -p $(OUT)
	moonc -t $(OUT) src/*.moon 
	mv $(OUT)/src/* $(OUT)/
	cp $(RES)/* $(OUT)/

run: build
	love $(OUT)

clean:
	rm -rf $(OUT)/*
