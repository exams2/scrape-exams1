.PHONY: download raw_pages

download: data raw_pages index.html
	echo "done"

raw_pages:
	mkdir -p raw_pages/institutii
	mkdir -p raw_pages/facultati
	mkdir -p raw_pages/materii
	mkdir -p raw_pages/subiecte
	mkdir -p raw_pages/atasamente
data:
	mkdir -p data

raw_pages/index.html:
	./scurl.sh http://exams.ro -o raw_pages/index.html

data/institutii.txt: raw_pages/index.html
	cat raw_pages/index.html | grep '<option value="[0-9]' | cut -d'"' -f2 > data/institutii.txt

raw_pages/institutii-gata: data/institutii.txt
	( cat data/institutii.txt | xargs -n1 -P1 -I{} ./scurl.sh "http://exams.ro/scripts/get_facultate.php?get_data={}" -o raw_pages/institutii/{}.html )
	echo "ok" > raw_pages/institutii-gata

data/facultati.txt: raw_pages/institutii-gata
	cat raw_pages/institutii/*.html | grep '<option' | grep -v 'an I' | sed 's/> /> \n/g' | grep 'option value' | cut -d"'" -f2 > data/facultati.txt

raw_pages/facultati-gata: data/facultati.txt
	for an in 1 2 3 4; do \
		cat data/facultati.txt | xargs -n1 -P1 -I{} ./scurl.sh "http://exams.ro/scripts/get_materie.php?get_data={}&get_data2=$$an" -o "raw_pages/facultati/{}-$$an.html" ; \
	done
	echo "ok" > raw_pages/facultati-gata

data/materii.txt: raw_pages/facultati-gata
	for facultate in $$(cat data/facultati.txt); do cat raw_pages/facultati/$$facultate-*.html | grep 'option value=' | sed 's/> /> \n/g'  | grep 'option value=' | cut -d"'" -f2 | sed "s/^/$$facultate,/"; done > data/materii.txt


raw_pages/materii-gata: data/materii.txt
	cat data/materii.txt | xargs -d '\n' -n1 -P1 ./dl-materie.sh
	echo "ok" > raw_pages/materii-gata

data/subiecte.txt: raw_pages/materii-gata
	cat raw_pages/materii/* | grep exams.ro | cut -d= -f3 | grep class | cut -d'"' -f1 > data/subiecte.txt


raw_pages/subiecte-gata: data/subiecte.txt
	cat data/subiecte.txt | xargs -n1 -P1 -I{} bash -c ' [[ ! -f "./raw_pages/subiecte/{}.html" ]] && ./scurl.sh "http://exams.ro/s.php?s={}" -o "./raw_pages/subiecte/{}.html" '
	echo "ok" > raw_pages/subiecte-gata

data/atasamente.txt: raw_pages/subiecte-gata
	cat raw_pages/subiecte/*.html | sed 's/>/\n/g'  | grep -w downloadS | cut -dS -f2- | sed "s#'). class='download'##g" | sed "s/('//g" > data/atasamente.txt


raw_pages/atasamente-gata: data/atasamente.txt
	cat data/atasamente.txt | xargs -d '\n' -n1 -P1 -I{} ./dl-atasament.sh "{}"
	echo "ok" > raw_pages/atasamente-gata

index.html: raw_pages/atasamente-gata
	./make-index.sh > index.html
