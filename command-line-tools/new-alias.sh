## -----------------------------------------
 # Creates new alias & writes to file
 #
 # @1 = alias new
 # @2 = alias definition
 #    * Requires `'~/.bash_aliases'` exists & is executed in `'~/.bashrc'`
 ##
function new-alias () {
    if [ -f ~/.bash_aliases ]; then
        if [ -z "$1" ]; then
            echo "alias name:"
            read NAME
        else
            NAME=$1
        fi
        if [ -z "$2" ]; then
            echo "alias definition:"
            read DEFINTION
        else
            if [ "$2" = "-cd" ]; then
                DEFINTION='cd '
            else
                DEFINTION=$2
            fi
        fi
        echo "alias $NAME=\"$DEFINTION\"" >> $HOME/.bash_aliases
        alias $NAME="$DEFINTION"
    else
        echo "Ut-oh! This function requires '~/.bash_aliases' exists and is executed in '~/.bashrc'"
    fi
}