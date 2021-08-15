#!/bin/bash

# Convert ABC or MIDI files to kalimba tab (in ascii)
#    Requirement: midi2abc to create the abc file
#    Limitations: Kalimba have limited note range and scale, notes 
#                 outside this range or scale will be ignored


# Options. The default here (which you can change in the script) will be enabled only 
#          if the variables are not already set from the command line, with for 
#          example: 
#               export NOTES=1 && kalimba.sh
#          You can unset a command line variable with: 
#               unset NOTES

if [ -z "$RYTHM" ] ; then
	RYTHM=0  # 0 = no rythm (only dots) ; 1 = rythm with extra spaces ; 2 = rythm alternative without extra lines
	fi
if [ -z "$GRAPHICAL" ] ; then
	GRAPHICAL=2  # 0 = simple display ; 1 = tab with █ ; 2 = tab simpler and clearer version
	fi
if [ -z "$BOARD" ] ; then
	BOARD=1  # 1 = the lowest note column is not marked ; the lowest note column is marked ;
	fi
if [ -z "$NOTES" ] ; then
	NOTES=2  # 1 (display notes) or 2 (display numbers)
	fi
if [ -z "$TUNING" ] ; then
	TUNING=C # C or G
	fi



# Main script

convert_abc() {
intro
banner

if [ $RYTHM = 1 ] ; then
 rythm_check() { perl -pe 's/\./\n|_|█|_|_|█|_|_|█|_|█|_|_|█|_|_|█|_|/gm' ; }
elif [ $RYTHM = 2 ] ; then
 rythm_check() { perl -pe  's/\./\n|_|||_|_|||_|_|||_|||_|_|||_|_|||_|/gm' ; }
else
 rythm_check() { perl -pe 's///g'; } # do nothing 
fi


if [ $GRAPHICAL = 1 ] ; then
 graphical_check() { perl -pe 's///g'; } # do nothing 
elif [ $GRAPHICAL = 2 ] ; then
 #graphical_check() { perl -pe 's/[\[\]]/|/g' | perl -pe 's/3°°\|/3| /gs' | perl -pe 's/°°\|/| \|/gs' | perl -pe 's/°\|/| /gs' | perl -pe 's/\|/ /gs'  | perl -pe 's/█/|/g' ; }
 graphical_check() { perl -pe 's/[\[\]]/|/g' |  perl -pe 's/\|/ /gs'  | perl -pe 's/█/|/g' ; }
else
 graphical_check() {  perl -pe 's/°/*/gm' | perl -pe  's/[_|█\[\]\n]//gm' | perl -pe  's/[ ]{1,}/ /g' | perl -pe 's/(.{1,50})/$1\n/gs' | perl -pe 's/^[ ]*//g' ;  } # replace 
fi


if [ $NOTES = 2 ] ; then
 note_check() { perl -pe 's///g'; } # do nothing 
else
 note_check() {  
    perl -pe  's/z/x/g' | \
	perl -pe "s/1°°/c°°/g" | \
	perl -pe "s/2°°/d°°/g" | \
	perl -pe "s/3°°/e°°/g" | \
	perl -pe  's/1°/c°/g' | \
	perl -pe  's/2°/d°/g' | \
	perl -pe  's/3°/e°/g' | \
	perl -pe  's/4°/f°/g' | \
	perl -pe  's/5°/g°/g' | \
	perl -pe  's/6°/a°/g' | \
	perl -pe  's/7°/b°/g' | \
	perl -pe  's/1/C/g' | \
	perl -pe  's/2/D/g' | \
	perl -pe  's/3/E/g' | \
	perl -pe  's/4/F/g' | \
	perl -pe  's/5/G/g' | \
	perl -pe  's/6/A/g' | \
	perl -pe  's/7/B/g'  ; }  # replace 
fi


if [ $BOARD = 1 ] ; then
 draw_board() {
	perl -pe  's/x/|x|||_|_|||_|_|█|_|█|_|_|||_|_|||_|_/g' |\
	perl -pe  's/z/|x|||_|_|||_|_|█|_|█|_|_|||_|_|||_|_/g' |\
	perl -pe "s/c'/|_|█|_|_|█|_|_|█|_|█|_|_|█|_|_[1°°]_/g" |\
	perl -pe "s/d'/[2°°]_|_|█|_|_|█|_|█|_|_|█|_|_|█|_|_/g" |\
	perl -pe "s/e'/|_|█|_|_|█|_|_|█|_|█|_|_|█|_|_|█[3°°]/g" |\
	perl -pe  's/C/|_|█|_|_|█|_|_|█[1]█|_|_|█|_|_|█|_|_/g' |\
	perl -pe  's/D/|_|█|_|_|█|_|_[2]_|█|_|_|█|_|_|█|_|_/g' |\
	perl -pe  's/E/|_|█|_|_|█|_|_|█|_[3]_|_|█|_|_|█|_|_/g' |\
	perl -pe  's/F/|_|█|_|_|█|_[4]█|_|█|_|_|█|_|_|█|_|_/g' |\
	perl -pe  's/G/|_|█|_|_|█|_|_|█|_|█[5]_|█|_|_|█|_|_/g' |\
	perl -pe  's/A/|_|█|_|_|█[6]_|█|_|█|_|_|█|_|_|█|_|_/g' |\
	perl -pe  's/B/|_|█|_|_|█|_|_|█|_|█|_[7]█|_|_|█|_|_/g' |\
	perl -pe  's/c/|_|█|_|_[1°]|_|█|_|█|_|_|█|_|_|█|_|_/g' |\
	perl -pe  's/d/|_|█|_|_|█|_|_|█|_|█|_|_[2°]|_|█|_|_/g' |\
	perl -pe  's/e/|_|█|_[3°]|_|_|█|_|█|_|_|█|_|_|█|_|_/g' |\
	perl -pe  's/f/|_|█|_|_|█|_|_|█|_|█|_|_|█[4°]|█|_|_/g' |\
	perl -pe  's/g/|_|█[5°]|█|_|_|█|_|█|_|_|█|_|_|█|_|_/g' |\
	perl -pe  's/a/|_|█|_|_|█|_|_|█|_|█|_|_|█|_[6°]|_|_/g' |\
	perl -pe  's/b/|_[7°]|_|█|_|_|█|_|█|_|_|█|_|_|█|_|_/g' ; }
else
 draw_board() {
 	perl -pe  's/x/|x|_|||_|_|||_|_|||_|_|||_|_|||_|_|_/g' |\
	perl -pe  's/z/|x|_|||_|_|||_|_|||_|_|||_|_|||_|_|_/g' |\
	perl -pe "s/c'/|_|_|█|_|_|█|_|_|█|_|_|█|_|_|█[1°°]_/g" |\
	perl -pe "s/d'/[2°°]█|_|_|█|_|_|█|_|_|█|_|_|█|_|_|_/g" |\
	perl -pe "s/e'/|_|_|█|_|_|█|_|_|█|_|_|█|_|_|█|_[3°°]/g" |\
	perl -pe  's/C/|_|_|█|_|_|█|_|_[1]_|_|█|_|_|█|_|_|_/g' |\
	perl -pe  's/D/|_|_|█|_|_|█|_[2]█|_|_|█|_|_|█|_|_|_/g' |\
	perl -pe  's/E/|_|_|█|_|_|█|_|_|█[3]_|█|_|_|█|_|_|_/g' |\
	perl -pe  's/F/|_|_|█|_|_|█[4]_|█|_|_|█|_|_|█|_|_|_/g' |\
	perl -pe  's/G/|_|_|█|_|_|█|_|_|█|_[5]█|_|_|█|_|_|_/g' |\
	perl -pe  's/A/|_|_|█|_|_[6]_|_|█|_|_|█|_|_|█|_|_|_/g' |\
	perl -pe  's/B/|_|_|█|_|_|█|_|_|█|_|_[7]_|_|█|_|_|_/g' |\
	perl -pe  's/c/|_|_|█|_[1°]|_|_|█|_|_|█|_|_|█|_|_|_/g' |\
	perl -pe  's/d/|_|_|█|_|_|█|_|_|█|_|_|█[2°]|█|_|_|_/g' |\
	perl -pe  's/e/|_|_|█[3°]|█|_|_|█|_|_|█|_|_|█|_|_|_/g' |\
	perl -pe  's/f/|_|_|█|_|_|█|_|_|█|_|_|█|_[4°]|_|_|_/g' |\
	perl -pe  's/g/|_|_[5°]|_|█|_|_|█|_|_|█|_|_|█|_|_|_/g' |\
	perl -pe  's/a/|_|_|█|_|_|█|_|_|█|_|_|█|_|_[6°]|_|_/g' |\
	perl -pe  's/b/|_[7°]|_|_|█|_|_|█|_|_|█|_|_|█|_|_|_/g' ; }
fi



if [ $TUNING = C ] ; then
 retune() { perl -pe 's///g'; } # do nothing 
else
 retune() {  
   perl -pe 's/b° /e°°/g' | \
   perl -pe 's/a° /d°°/g' | \
   perl -pe 's/g° /c°°/g' | \
   perl -pe  's/^f° /b°/g' | \
   perl -pe  's/e° /a°/g' | \
   perl -pe  's/d° /g°/g' | \
   perl -pe  's/c° /f°/g' | \
   perl -pe  's/B /e°/g' |\
   perl -pe  's/A /d°/g' |\
   perl -pe  's/G /c°/g' |\
   perl -pe  's/^F /B/g'  |\
   perl -pe  's/E /A/g' |\
   perl -pe  's/D /G/g' |\
   perl -pe  's/C /F/g' |\
   perl -pe  's/B, /E/g' |\
   perl -pe  's/A, /D/g' |\
   perl -pe  's/G, /C/g' ; }  # replace 
fi


printf " \n" | cat - $1 |\
perl -pe 's/"(.*?)"//g' |\
# remove label such as T: X: etc:
perl -pe 's/^([A-Za-z]):(.*)//g' |\
# remove comments
perl -pe 's/^%(.*)//g' |\
# remove < notation. Note: it won't be noted as such in the resulting tab
perl -pe "s/[<>]/ /g" |\
# separate chunks / croche
perl -pe 's/\/(\d+?)/\/\1 /g' |\
# TODO perl -pe 's/\/2/cinquanteq/g' |\
# separate chunks pipe
perl -pe 's/\|/ | /g' |\
# separate chunks A2 => space A2 space 
perl -pe 's/([_\^]?[A-Za-z][,]?)(\d+?)/ \1\2 /g' |\
perl -pe "s/([_\^]?[A-Za-z][']?)(\d+?)/ \1\2 /g" |\
# separate chunks AAB => A A B
perl -pe 's/([A-Za-z][,]?)([A-Za-z][,]?)/\1 \2/g' |\
perl -pe "s/([A-Za-z][']?)([A-Za-z][,]?)/\1 \2/g" |\
# separate chunks A2A2 => A2 A2
perl -pe 's/(\^[A-Za-z][,]?)(\d+?)/ \1\2 /g' |\
perl -pe 's/(_[A-Za-z][,]?)(\d+?)/ \1\2 /g' |\
perl -pe 's/([^_\^][A-Za-z][,]?)(\d+?)/ \1\2 /g' |\
perl -pe "s/(\^[A-Za-z][']?)(\d+?)/ \1\2 /g" |\
perl -pe "s/(_[A-Za-z][']?)(\d+?)/ \1\2 /g" |\
perl -pe "s/([^_\^][A-Za-z][']?)(\d+?)/ \1\2 /g" |\
# separate chunks AA => A A again
perl -pe 's/([A-Za-z][,]?)([A-Za-z][,]?)/\1 \2/g'  |\
perl -pe 's/(\^[A-Za-z][,]?)/ \1/g' |\
perl -pe 's/(_[A-Za-z][,]?)/ \1/g' |\
perl -pe 's/([^_\^][A-Za-z],\/?)/ \1/g' |\
perl -pe 's/([^_\^][A-Za-z]\/)/ \1/g' |\
perl -pe 's/([_\^][A-Za-z]\/?)/ \1/g' |\
perl -pe 's/([^_\^][A-Za-z][,]?[\/]?)/ \1/g'  |\
perl -pe "s/([A-Za-z][']?)([A-Za-z][']?)/\1 \2/g"  |\
perl -pe "s/(\^[A-Za-z][']?)/ \1/g" |\
perl -pe "s/(_[A-Za-z][']?)/ \1/g" |\
perl -pe "s/([^_\^][A-Za-z]'\/?)/ \1/g" |\
perl -pe "s/([^_\^][A-Za-z][']?[\/]?)/ \1/g"  |\

#todo ;: remove this?:
#perl -pe 's/(\d+?)([A-Z])/\1 \2/g' 
perl -pe 's/   / /g' |\
perl -pe 's/    / /g' |\
perl -pe 's/  / /g' |\
perl -pe 's/  / /g' |\
# remove empty lines:
sed '/^[[:space:]]*$/d' |\
perl -pe 's/([A-Za-z])\//\1 /g' |\
# remove ]:
perl -pe 's/]//g' |\
# separate accidentals too
perl -pe 's/(\^[A-Za-z])/ \1/g' |\
perl -pe 's/(_[A-Za-z])/ \1/g' |\
perl -pe 's/([A-Za-z])([A-Za-z])/\1 \2/g' |\
perl -pe 's/([A-Za-z])_([A-Za-z])/\1 _\2/g' |\
perl -pe 's/([A-Za-z])\^([A-Za-z])/\1 ^\2/g' |\
awk '{gsub (" ", "\n",$0); print}' | \
awk '{gsub ("/2", " 50q ",$0); print}' | \
awk '{gsub ("2", " 200q ",$0); print}' | \
awk '{gsub ("3", " 300q ",$0); print}' | \
awk '{gsub ("4", " 400q ",$0); print}' | \
awk '{gsub ("5", " 500q ",$0); print}' | \
awk '{gsub ("6", " 600q ",$0); print}' | \
awk '{gsub ("7", " 700q ",$0); print}' | \
awk '{gsub ("8", " 800q ",$0); print}' | \
awk '{gsub ("/", " 50q ",$0); print}' | \
# remove pipe and dots: 
perl -pe 's/\|/ /g'  |\
perl -pe 's/:/ /g'  |\
#tr -d \| |\
# remove trailing backslash
perl -pe 's/\\/ /g'  |\
#tr -d \\ |\
# separate ,
perl -pe 's/,[A-Za-z]/, \1/g'  |\
# remove empty lines again
sed -r '/^\s*$/d' |\
# line starting with a single letter should weight 100:
perl -pe 's/^(\^[A-Za-z][,]?)[\h]*$/\1 100q/g'  |\
perl -pe 's/^(_[A-Za-z][,]?)[\h]*$/\1 100q/g'  |\
perl -pe 's/^([A-Za-z][,]?)[\h]*$/\1 100q/g'  |\
perl -pe 's/^ ([A-Za-z][,]?)[\h]*$/\1 100q/g'  |\
perl -pe "s/^(\^[A-Za-z][']?)[\h]*$/\1 100q/g"  |\
perl -pe "s/^(_[A-Za-z][']?)[\h]*$/\1 100q/g"  |\
perl -pe "s/^([A-Za-z][']?)[\h]*$/\1 100q/g"  |\
perl -pe "s/^ ([A-Za-z][']?)[\h]*$/\1 100q/g"  |\
#shift 
awk '{print $1," "$2"\n"}'  |\
perl -pe 's/(\d+?)q\n/\1 /g' |\
# switch columns:
#awk '{print $2,$1}' |\
#convert notes
retune |\
perl -pe 's/\^C,/out/g' |\
perl -pe 's/_D,/out/g' |\
perl -pe 's/C,/out/g' |\
perl -pe 's/\^D,/out/g' |\
perl -pe 's/_E,/out/g' |\
perl -pe 's/D,/out/g' |\
perl -pe 's/E,/out/g' |\
perl -pe 's/\^F,/out/g' |\
perl -pe 's/_G,/out/g' |\
perl -pe 's/F,/out/g' |\
perl -pe 's/\^G,/out/g' |\
perl -pe 's/_A,/out/g' |\
perl -pe 's/G,/out/g' |\
perl -pe 's/\^A,/out/g' |\
perl -pe 's/_B,/out/g' |\
perl -pe 's/A,/out/g' |\
perl -pe 's/B,/out/g' |\
perl -pe 's/\^C/out/g' |\
perl -pe 's/_C/out/g' |\
perl -pe 's/ D/out/g' |\
perl -pe 's/\^D/out/g' |\
perl -pe 's/\^F/out/g' |\
perl -pe 's/\^G/out/g' |\
perl -pe 's/\^A/out/g' |\
perl -pe 's/ E/out/g' |\
perl -pe 's/_F/out/g' |\
perl -pe 's/_G/out/g' |\
perl -pe 's/_A/out/g' |\
perl -pe 's/_B/out/g' |\
perl -pe 's/\^c/out/g' |\
perl -pe 's/\^f/out/g' |\
perl -pe 's/\^g/out/g' |\
perl -pe 's/_e/out/g' |\
perl -pe 's/\^d/out/g' |\
perl -pe 's/\^a/out/g' |\
perl -pe 's/_a/out/g' |\
perl -pe 's/_b/out/g' |\
perl -pe 's/_d/out/g' |\
perl -pe 's/_g/out/g' |\
perl -pe "s/f'/out/g" |\
perl -pe "s/g'/out/g" |\
perl -pe "s/a'/out/g" |\
perl -pe "s/b'/out/g" |\
perl -pe "s/c''/out/g" |\
draw_board |\
perl -pe 's/800/......../g' |\
perl -pe 's/700/......./g' |\
perl -pe 's/600/....../g' |\
perl -pe 's/500/...../g' |\
perl -pe 's/400/..../g' |\
perl -pe 's/300/.../g' |\
perl -pe 's/200/../g' |\
perl -pe 's/100/./g' |\
perl -pe 's/50/ /g' |\
awk '{print $1," ",$2," "}' |\
#change █ to something else to make is lighter to read:
#perl -pe 's/█/*/g' |\
#change dots to new line:
rythm_check |\
graphical_check |\
note_check |\
#remove extra underscore to keep them aligned :
perl -pe 's/_/ /g' |\
# remove -
perl -pe "s/-[ ]*\n/   | -/g" 

}



#awk -F"."  '{ print $NF }'`


banner() {
echo " "
echo "   | |/ /__ _| (_)_ __ ___ | |__   __ _"
echo "   | ' // _\` | | | '_ \` _ \| '_ \ / _\` |"
echo "   | . | (_| | | | | | | | | |_) | (_| |"
echo "   |_|\_\__,_|_|_|_| |_| |_|_.__/ \__,_|.sh"
echo " "
}


intro() {
printf "\nConverted from $file "
printf "\nTuning: $TUNING \n\n"
}


convert_midi() {
	if cmd=$(command -v midi2abc); then 
	    rm -fr /tmp/tmp.abc
		midi2abc $1 > /tmp/tmp.abc
		convert_abc /tmp/tmp.abc ;
		else 
			printf "Please install midi2abc";
	fi
		
}


usage() {
	banner
	printf "Please use an abc or midi file as input.\n
          Usage: kalimba.sh file.abc 
                 kalimba.sh file.mid \n\n"
}


file=$1 

case "$1" in

		*.abc) 	convert_abc $1
				exit ;;
		*.mid) printf ""
				convert_midi $1
				exit ;;
		*) usage
			exit ;;
esac
