
P_PROPERTIES_FILE="${P_PROPERTIES_FILE:=$HOME/.pdata.properties}"
_P_VERSION="1.0.0"

p() {
    touch $P_PROPERTIES_FILE
    case $1 in
    set) __p_set $2 $3 ;;
    list) __p_list $2 ;;
    rm) __p_rm $2 ;;
    --help) ;&
    help)   ;&
    -h)
        __p_help ;;
    --version) ;&
    -v) __p_version ;;
    *)
        if [ -z $1 ] ; then
            __p_help
        else 
            __p_cd $1
        fi
    ;;
    esac
}

__p_help() {
    cat <<EOF
P path shortcuts manager

Usage:
    p set <alias> <path>
    p list [<alias>]
    p rm <alias>
    p <alias>

Commands:
set         Stores (add or edit) a shortcut for directory <path> with
            key <alias>.
list        If no alias is given list all known alias=path.
            If alias is given list according path.
rm          Remove an alias.
<alias>     Change working directory to respective path for the given alias.
EOF
}

__p_version() {
    echo "P path shortcuts manager version $_P_VERSION"
}

__p_set() {
    if [ -z $1 ] || [ -z $2 ] ; then
        __p_err "Missing operands [alias] [path]"
        return 1
    fi

    local lookup=$(__p_getPath $1)
    if [ -z $lookup ] ; then
        __p_add $1 $2
    else 
        __p_update $1 $2
    fi
}

__p_list() {
    if [ -z $1 ] ; then
        cat $P_PROPERTIES_FILE | sort
    else
        local singleAlias=$(grep ^$1= $P_PROPERTIES_FILE)
        if [ -z $singleAlias ] ; then
            __p_err "Alias \"$1\" does not exist"
            return 1
        else
            echo $singleAlias
        fi
    fi
}

__p_rm() {
    if [ -z $1 ] ; then
        __p_err "Missing alias key"
    fi

    grep -v ^$1= $P_PROPERTIES_FILE > $P_PROPERTIES_FILE.tmp
    mv $P_PROPERTIES_FILE{.tmp,}
}

__p_cd() {
    local path=$(__p_getPath $1)
    if [ -z $path ] ; then
        __p_err "Alias \"$1\" does not exist"
        return 1
    fi

    cd $path
}

__p_getPath() {
    if [ -z $1 ] ; then
        __p_err "Missing alias key"
        return 1
    fi

    grep ^$1= $P_PROPERTIES_FILE | cut -d"=" -f2
}

__p_add() {
    echo $1=$2 >> $P_PROPERTIES_FILE
}

# Code from here: https://gist.github.com/kongchen/6748525
__p_update() {
    awk -v pat="^$1=" -v value="$1=$2" '{ if ($0 ~ pat) print value; else print $0; }' $P_PROPERTIES_FILE > $P_PROPERTIES_FILE.tmp
    mv $P_PROPERTIES_FILE{.tmp,}
}

__p_err() {
    if [ -n $1 ] ; then
        echo "p: $1" > /dev/stderr
    fi
}
