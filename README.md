# loader
Load / unload package versions into / from the current shell environment.

## Why
Modifying PATH by hand is a pain.

## How
Sourceable shell functions.
You are in charge of exporting PKGPATH which defines where packages should be searched for.
Follow these filesystem conventions for organizing package builds:
```
"$PKGPATH"/src/<package>/build						 							# place versions of built packages here
"$PKGPATH"/src/<package>/build/<version>/bin						# place executables and libraries here
"$PKGPATH"/src/<package>/build/<version>/man<section> 	# place man pages here
```

## Usage
```
load <package> [<version>]
unload <package> [<version>]
```

## Test
`test/test.sh`

## Inspiration
[modules](http://modules.sourceforge.net/docs/Modules-Paper.pdf)

## License
[WTFPL](http://www.wtfpl.net/txt/copying/)