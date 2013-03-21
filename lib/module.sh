#
# module - modify environment for specific module version
#

module() {
  
  # args
  local cmd="$1"
  local name="$2"
  local version="$3"
  
  # sanity
  [ -z "$MODULE_ROOT" ] && echo '$MODULE_ROOT is not defined' >&2 && return 1
  [ -z "$cmd" ] && echo "please specify a command" >&2 && return 1
  [ -z "$name" ] && echo "please specify a module" >&2 && return 1
  
  # vars
  local build="$MODULE_ROOT"/src/"$name"/build
  
  # proxy to command
  case "$cmd" in
    "load") __module_load;;
    "unload") __module_unload;;
    *) echo "$cmd: command not found" >&2 && return 127;;
  esac
}

__module_load() {
  
  # set version to default if necessary
  [ -z "$version" ] && version="default"
  
  # is the requested version installed?
  [ ! -d "$build"/"$version" ] && echo "version $version is not installed" >&2 && return 1
  
  # unload any currently loaded versions first
  __module_unload
  
  # don't place a ":" at the end of PATH
  [ -n "$PATH" ] && PATH=":$PATH"
  
  # add libraries & executables to PATH
  PATH="$build"/"$version"/lib"$PATH"
  PATH="$build"/"$version"/bin:"$PATH"
  export PATH
}

__module_unload() {
  
  # only modify PATH if it's defined
  if [ -n "$PATH" ]
  then
    PATH="$(echo "$PATH" | sed "s|$build/[^/]*/lib:||g")"
    PATH="$(echo "$PATH" | sed "s|$build/[^/]*/lib||g")"
    PATH="$(echo "$PATH" | sed "s|$build/[^/]*/bin:||g")"
    PATH="$(echo "$PATH" | sed "s|$build/[^/]*/bin||g")"
    export PATH
  fi
}
