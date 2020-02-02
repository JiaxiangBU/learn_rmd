all: cookbook

cookbook:
	
	Rscript analysis/write_tmp.R
	Rscript R/build.R
	
clean: 
	
	rm tmp/*