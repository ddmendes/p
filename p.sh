
P_PROPERTIES_FILE="${P_PROPERTIES_FILE:=$HOME/.pdata.properties}"

p() {
    case $1 in
    add) __add $2 $3 ;;
    list) __list $2 ;;
    *)
        if [ -z $1 ] ; then
            __p_help
        else 
            __cd $1
        fi
    ;;
    esac
}

__p_help() {
    echo "P utility help"
}

__add() {
    touch $P_PROPERTIES_FILE
    echo $1=$2 >> $P_PROPERTIES_FILE
}

__list() {
    if [ -z $1 ] ; then
        cat `echo $P_PROPERTIES_FILE`
    else
        _p_singleAlias=$(grep ^$1 $P_PROPERTIES_FILE)
        if [ -z $_p_singleAlias ] ; then
            echo "Alias \"$1\" not found"
        else
            echo $_p_singleAlias
        fi
        unset _p_singleAlias
    fi
}

__cd() {
    if [ -z $1 ] ; then
        echo "Missing alias name"
        return 1
    fi

    _p_path=$(grep ^$1 $P_PROPERTIES_FILE | cut -d"=" -f2)
    if [ -z $_p_path ] ; then
        echo "No definition for alias \"$1\""
    fi

    cd $_p_path
    unset _p_path
}
