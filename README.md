```

  __                 __             
 |  |.-----.---.-.--|  |.-----.----.
 |  ||  _  |  _  |  _  ||  -__|   _|
 |__||_____|___._|_____||_____|__|

```
Load package versions into the current shell environment.

## Why
Modifying PATH by hand is a pain.

## How
Sourceable shell functions.  
* You are in charge of exporting PKGPATH which defines where packages should be searched for.  
* Follow these filesystem conventions for organizing package contents:  
	* place versions of built packages here: `"$PKGPATH"/src/<package>/build`
	* place executables and libraries here: `"$PKGPATH"/src/<package>/build/<version>/bin`
	* place man pages here: `"$PKGPATH"/src/<package>/build/<version>/man<section>`

## Usage
* `load <package> [<version>]`  
* `unload <package>`

## Test
`test/test.sh`

## Inspiration
[virtualenv](http://www.virtualenv.org/)  
[modules](http://modules.sourceforge.net/docs/Modules-Paper.pdf)

## License
[WTFPL](http://www.wtfpl.net/txt/copying/)