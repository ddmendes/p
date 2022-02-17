
P_PROPERTIES_FILE="${P_PROPERTIES_FILE:=$HOME/.pdata.properties}"

p() {
    case $1 in
    set) __p_set $2 $3 ;;
    list) __p_list $2 ;;
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
    echo "P utility help"
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
        cat `echo $P_PROPERTIES_FILE`
    else
        local singleAlias=$(grep ^$1 $P_PROPERTIES_FILE)
        if [ -z $singleAlias ] ; then
            __p_err "Alias \"$1\" does not exist"
            return 1
        else
            echo $singleAlias
        fi
    fi
}

__p_cd() {
    local path `__p_getPath $1`
    if [ -z $path] ; then
        __p_err "Alias \"$1\" does not exist"
        return 1
    fi

    cd $1
}

__p_getPath() {
    if [ -z $1 ] ; then
        __p_err "Missing alias key"
        return 1
    fi

    local _p_path=$(grep ^$1 $P_PROPERTIES_FILE | cut -d"=" -f2)
    echo $_p_path
}

__p_add() {
    touch $P_PROPERTIES_FILE
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
