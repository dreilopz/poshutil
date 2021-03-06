# (C) 2014, 2015, Pedro Ivan Lopez <m@pedroivanlopez.com>
#
# This source code is released under the new MIT license, a copy of the
# license is in the distribution directory.

get_file_extensions() {
    find "${1-$(pwd)}" -type f -iname '*.*' | 
        grep -iv -e '^.*~$' |  # ignore vim backups
        sed -e 's/.*\.\(.*\)/\1/' -e 's/\(.*\)/\L\1/' | sort | uniq
}

is_older() {
    age_threshold=${2-'0'}
    dirp=$(dirname ${1-$(pwd)})
    fp=$(basename ${1-$(pwd)})
    test "$(find "$dirp" -maxdepth 1 -mmin +$age_threshold -name "$fp")"
    return $?
}

get_cfg_dir() {
    if [ -z $1 ]
    then
        return 1
    fi
    fp="$1"
    dirp="$(readlink -f ${2-$(pwd)})"
    maxdepth=${3-'1'}

    find "$dirp" -maxdepth "$maxdepth" -type f -name "$fp" 2>/dev/null | head -n 1
}

randint() {
    if [ -z $1 ]
    then
        intmax=10
    else
        intmax=$1
    fi

    if [ intmax -gt 10 ]; then
        intmax=10
    fi

    randstr=$RANDOM
    randstr=$randstr$RANDOM
    randstr=${randstr:(-$intmax)}

    echo $randstr
}
