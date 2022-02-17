
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
    touch $P_PROPERTIES_FILE
    echo $1=$2 >> $P_PROPERTIES_FILE
}

__p_list() {
    if [ -z $1 ] ; then
        cat `echo $P_PROPERTIES_FILE`
    else
        local _p_singleAlias=$(grep ^$1 $P_PROPERTIES_FILE)
        if [ -z $_p_singleAlias ] ; then
            echo "Alias \"$1\" not found"
        else
            echo $_p_singleAlias
        fi
    fi
}

__p_cd() {
    cd `__p_getPath $1`
}

__p_getPath() {
    if [ -z $1 ] ; then
        __p_err "Missing alias key"
        return 1
    fi

    local _p_path=$(grep ^$1 $P_PROPERTIES_FILE | cut -d"=" -f2)
    if [ -z $_p_path ] ; then
        __p_err "No definition for alias \"$1\""
    fi

    echo $_p_path
}

__p_err() {
    if [ -n $1 ] ; then
        echo "p: $1" > /dev/stderr
    fi
}
