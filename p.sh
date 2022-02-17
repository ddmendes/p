
P_PROPERTIES_FILE="${P_PROPERTIES_FILE:=$HOME/.pdata.properties}"

p() {
    case $1 in
    add) __add $2 $3 ;;
    list) __list $2 ;;
    *)  ;;
    esac
}

__add() {
    touch $P_PROPERTIES_FILE
    echo $1=$2 >> $P_PROPERTIES_FILE
}

__list() {
    if [ -z $1 ] ; then
        cat `echo $P_PROPERTIES_FILE`
    else
        singleAlias=$(grep $1 $P_PROPERTIES_FILE)
        if [ -z $singleAlias ] ; then
            echo "Alias \"$1\" not found"
        else
            echo $singleAlias
        fi
        unset singleAlias
    fi
}

__cd() {
    
}


