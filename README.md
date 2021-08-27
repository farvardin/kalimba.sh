# kalimba.sh

The Kalimba is a musical instrument in the lamellophone family, it makes sounds from vibrating plates fixed on a wooden box.

![](kalimba.jpg)


With kalimba.sh, you can convert and display [ABC](https://abcnotation.com/) or MIDI files to kalimba tab in ascii, and easily copy them to a website and for any use.



```
   | |/ /__ _| (_)_ __ ___ | |__   __ _
   | ' // _` | | | '_ ` _ \| '_ \ / _` |
   | . | (_| | | | | | | | | |_) | (_| |
   |_|\_\__,_|_|_|_| |_| |_|_.__/ \__,_|.sh
 
   |     |     |   3     |     |       .  
   |     | 6   |   |     |     |       .  
   |     |     |   | 5   |     |       .  
   |     | 6   |   |     |     |       .  
   |     |     |   |   7 |     |       .  
   |     | 6   |   |     |     |       .  
   |     |     |   |   7 |     |       .  
   |     1°    |   |     |     |       .  
   |     |     |   |   7 |     |       .  
   |     1°    |   |     |     |       .  
   |     |     |   |   7 |     |       .  
   |     1°    |   |     |     |       .  
   |     |     |   |     2°    |       .  
   |   3°      |   |     |     |       .  
   |     |     |   |     2°    |       .  
   |     1°    |   |     |     |       .  
   |     |     |   |   7 |     |       .  
   |     1°    |   |     |     |       .  
   |     |     |   |   7 |     |       .  
   |     | 6   |   |     |     |       ...  
   |     | 6   |   |     |     |       ..  
   |     | 6   |   |     |     |       .  
```



You can find an explanation of how kalimba tabs work on this [website](https://www.kalimbamagic.com/info/how-to-play/how-to-read-and-write-kalimba-tablature).

The dots are a rough indication for the rythms and notes lengths.





## Usage

```
kalimba.sh file.abc 
kalimba.sh file.mid 
```


You'll need to have [midi2abc](https://sourceforge.net/projects/abcmidi/) to be able to convert from midi to kalimba tab.


If you want to export the result into a text file, use a redirection:

```
./kalimba.sh samples/blacknag.abc > samples/blacknag.txt
```


## Options

You can change different options from the script itself, or you can define them from the command line:

for example:
	``export NOTES=1 && kalimba.sh``

You can unset a command line variable with: 
	``unset NOTES``
	
The possibles options are:

### RYTHM
 - 0 = no rythm (only dots) ; 1 = rythm with extra spaces ; 2 = rythm alternative without extra lines
 
### GRAPHICAL
 - 0 = simple display ; 1 = tab ; 2 = tab simpler and clearer version

### BOARD
 - 1 = the lowest note column is not marked ; the lowest note column is marked ;

### NOTES
 - 1 = display notes ; 2 = display numbers

### TUNING
 - C or G



## Limitations

Kalimba have limited note range and scale, notes outside this range or scale will be ignored. 


Kalimba.sh is convenient to quickly convert from a midi file. If you prefer a WYSIWYG editor, have a look at [Kalimba Tabs](https://github.com/oakleyaidan21/kalimba-tabs)


If you need to display the result line by line to play along, you can use [slow](https://github.com/davidgranstrom/slow).

``./kalimba.sh tune.mid |slow -l -d 500``



## Licence

BSD 2-Clause [License](LICENSE)





