jupyter:

	jupyter nbconvert --to markdown --output-dir . --NbConvertApp.output_files_dir=libs \
	    ...

	Rscript code/build-jupyter-notebook.R

cookbook:

	Rscript analysis/write_tmp.R
	Rscript code/build.R

readme:

	Rscript code/build-readme.R

push:

	Rscript code/push.R

copy:

	Rscript code/copy-md.R

clean:

	Rscript code/clean.R

all: cookbook push
