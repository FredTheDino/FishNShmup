OUTDIR=out/

build:
	rm -rf $(OUTDIR)/*
	mkdir -p $(OUTDIR)
	moonc -t $(OUTDIR) *.moon 

run: build
	love $(OUTDIR)

clean:
	rm -rf $(OUTDIR)/*
