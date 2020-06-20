all: cookbook clean push

cookbook:
	
	Rscript analysis/write_tmp.R
	Rscript code/build.R
	
clean: 
	
	rm tmp/*
	
push:

	Rscript code/push.R
	git push