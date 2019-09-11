all: hexwords-2 hexwords-3 hexwords-4 hexwords-8 hexwords-16

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
