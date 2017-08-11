.PHONY: all start clean download_data download_known_licenses

all: download_data
	tox

start: download_data
	tox -e start

clean:
	rm -rf data/ .tmp

download_data: download_known_licenses data/gov_licenses.csv

download_known_licenses: .tmp/choosealicense.zip | data/licenses
	unzip -d .tmp -o .tmp/choosealicense.zip choosealicense.com-gh-pages/_licenses/* && \
    mv .tmp/choosealicense.com-gh-pages/_licenses/* data/licenses

.tmp/choosealicense.zip: | .tmp
	wget "https://github.com/github/choosealicense.com/archive/gh-pages.zip" -O .tmp/choosealicense.zip

data/gov_licenses.csv: | data
	wget "https://docs.google.com/spreadsheets/d/1_XfO_Ghimj3jEjwtDTCpl6-1wpNcoFV02IwxQ_GW3g4/pub?gid=1442952037&single=true&output=csv" -O $@

data:
	mkdir -p $@

data/licenses:
	mkdir -p $@

.tmp:
	mkdir -p $@
