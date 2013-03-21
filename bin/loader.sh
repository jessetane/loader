#
# loader.sh
#

load() {
  
  # args
  local name="$1"
  local version="$2"
  
  # sanity pt. I
  [ -z "$PKGPATH" ] && echo "PKGPATH is not defined" >&2 && return 1
  [ -z "$name" ] && echo "please specify a package to load" >&2 && return 1
  
  # vars
  local src="$PKGPATH"/src/"$name"
  local build="$src"/build
  
  # sanity pt. II
  [ ! -d "$src" ] && echo "$name: package is not installed" >&2 && return 1
  
  # set version to default if necessary
  [ -z "$version" ] && version="default"
  
  # is the requested version installed?
  [ ! -d "$build"/"$version" ] && echo "$version: version not installed" >&2 && return 1
  
  # unload any currently loaded versions first
  unload "$name"
  
  # don't place a ":" at the end of PATH
  [ -n "$PATH" ] && PATH=":$PATH"
  
  # add package/version/bin to PATH
  PATH="$build"/"$version"/bin"$PATH"
  export PATH
}

unload() {
  
  # args
  local name="$1"
  
  # sanity
  [ -z "$PKGPATH" ] && echo "PKGPATH is not defined" >&2 && return 1
  [ -z "$name" ] && echo "please specify a package to unload" >&2 && return 1
  
  # vars
  local src="$PKGPATH"/src/"$name"
  local build="$src"/build
  
  # is the requested package installed?
  [ ! -d "$src" ] && echo "$name: package is not installed" >&2 && return 1
  
  # remove package/version/bin from PATH
  PATH="$(echo "$PATH" | sed "s|$build/[^/]*/bin:||g")"
  PATH="$(echo "$PATH" | sed "s|$build/[^/]*/bin||g")"
  export PATH
}
