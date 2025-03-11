#!/bin/bash

list_cmd() { fd . --maxdepth 1 -t d; }
declare -a args
declare quiet

opts=$(getopt -o q -l quiet -- "$@")
nonopt=

eval set -- "$opts"

while true; do
  if [[ -z $nonopt ]]; then
    case $1 in
      --)
        nonopt=0
        shift 1
        ;;
      -q|--quiet)
        quiet=$2
        shift 2
        ;;
      *)
        printf "Invalid option: %s\n" "$1"
        exit 1
        ;;
    esac
  elif [[ -n $1 ]]; then
    args=("${arg[@]}" "$1")
    shift 1
  else
    break
  fi
done

subcmd=${args[0]:-run}
makecmd=(
  make "$subcmd"
)
all=$(list_cmd | wc -l)
[[ -n $quiet ]] && makecmd=("${makecmd[@]}" ">" /dev/null "2>&1")

function test_all {
  declare success fnum
  success=0
  fnum=1

  while read -r subdir; do
    local result=

    if bash -c "cd $subdir && ${makecmd[*]}"; then
      success=$((success+1))
      result=success
    else
      result=failure
    fi
    printf "[%d] %s: %s - %d/%d\n" "$fnum" "$PWD/$subdir" $result $success "$all"
    fnum=$((fnum+1))
  done <<< "$(list_cmd)"

  if [[ "$success" = "$all" ]]; then
    printf "All tests ran successfully!\n"
  else
    printf "%d cases failed out of %d\n" "$((all-success))" "$all"
  fi
}

function clean_all {
  while read -r subdir; do
    bash -c "cd $subdir && ${makecmd[*]}"
  done <<< "$(list_cmd)"
}

[[ $all = 0 ]] && { echo "No tests available, exiting..."; exit 0; }

case $subcmd in
  run)
    test_all
    ;;
  clean)
    clean_all
    ;;
  *)
    printf "unknown subcmd: %s" "$subcmd"
    exit 1
    ;;
esac

exit 0
