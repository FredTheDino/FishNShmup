OUTDIR=out/

build:
	rm -rf $(OUTDIR)/*
	mkdir -p $(OUTDIR)
	moonc -t $(OUTDIR) src/*.moon 
	mv $(OUTDIR)/src/* $(OUTDIR)/

run: build
	love $(OUTDIR)

clean:
	rm -rf $(OUTDIR)/*
