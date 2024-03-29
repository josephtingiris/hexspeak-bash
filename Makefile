all: hexwords hexwords-2 hexwords-3 hexwords-4 hexwords-8 hexwords-16 hexwords-alpha-all

hexwords:
	hexspeak.bash > hexwords.txt &

hexwords-2:
	hexspeak.bash 2 > hexwords-2.txt &

hexwords-3:
	hexspeak.bash 3 > hexwords-3.txt &

hexwords-4:
	hexspeak.bash 4 > hexwords-4.txt &

hexwords-8:
	hexspeak.bash 8 > hexwords-8.txt &

hexwords-16:
	hexspeak.bash 16 > hexwords-16.txt &

hexwords-alpha-all: hexwords-alpha-curl hexwords-alpha hexwords-alpha-2 hexwords-alpha-3 hexwords-alpha-4 hexwords-alpha-8 hexwords-alpha-16

hexwords-alpha-curl:
	curl "https://raw.githubusercontent.com/dwyl/english-words/master/words_alpha.txt" -O
	dos2unix words_alpha.txt

hexwords-alpha:
	export WORDS_FILE=words_alpha.txt; hexspeak.bash > hexwords-alpha.txt &

hexwords-alpha-2:
	export WORDS_FILE=words_alpha.txt; hexspeak.bash 2 > hexwords-alpha-2.txt &

hexwords-alpha-3:
	export WORDS_FILE=words_alpha.txt; hexspeak.bash 3 > hexwords-alpha-3.txt &

hexwords-alpha-4:
	export WORDS_FILE=words_alpha.txt; hexspeak.bash 4 > hexwords-alpha-4.txt &

hexwords-alpha-8:
	export WORDS_FILE=words_alpha.txt; hexspeak.bash 8 > hexwords-alpha-8.txt &

hexwords-alpha-16:
	export WORDS_FILE=words_alpha.txt; hexspeak.bash 16 > hexwords-alpha-16.txt &

hexwords-clean:
	for hexwords_txt in hexwords.txt hexwords-[0-9]*.txt hexwords-alpha.txt hexwords-alpha-[0-9]*.txt; do echo "cleaning $$hexwords_txt"; sort -u $$hexwords_txt -o $$hexwords_txt; sed -i '/^$$/d' $$hexwords_txt; done 
