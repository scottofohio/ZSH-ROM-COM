## -----------------------------------------
 # Create (touch) new file and its non-existent parent directories
 #
 # @1 = new file path
 #
 # -> Example usage:
 #    lick ~/path/to/non-existing/dir/file
 #    lick -e ~/new/dis/and/file
 ##
function lick () {
    if [ -z "$1" ]; then
        echo "Please provide the file path:"
        read FILE_PATH
    else
        FILE_PATH=$1
    fi
    if [ $1 = "-e" ] || [ $1 = "--edit" ]; then
        FILE_PATH=$2
        if [ -z "$EDITOR" ]; then
            echo "'MY_EDITOR' is not defined!"
        else
            CMD=$EDITOR
            ECHO_STR="Creating necessary file and directories and opening for edit..."
        fi
    else
        CMD=touch
        ECHO_STR="Creating necessary file and directories..."
    fi
    test -d $(dirname $FILE_PATH) && ECHO_STR="$ECHO_STR\nFile already exists!" || mkdir -p $(dirname $FILE_PATH) && ECHO_STR="$ECHO_STR\nDone!"
    echo $ECHO_STR
    sleep .5
    $CMD $FILE_PATH
}

## -----------------------------------------
 # List all active system processes
 ##
function list-processes () {
    ps -d
}

## -----------------------------------------
 # List contents of all directories in the current directory
 ##
function ls-dirs () {
    ls -d ./*/
}

## -----------------------------------------
 # ls on current directory plus all sub-directories
 #
 # @1 = pattern to search (RegEx accepted)
 ##
function ls-recursive () {
    if [ -z "$MY_HELP_DIR" ]; then
        echo "'MY_HELP_DIR' must be defined."
    else
        if [ -z "$1" ]; then
            echo "pattern to search:"
            read PATTERN
        else
            PATTERN=$1
        fi
    fi
    find . -print | grep -i "$PATTERN"
}

## -----------------------------------------
 # Evaluate basic arithmetic operations & display the result
 #
 # @1 = operation/equation
 #
 # -> Example usage:
 #    math '8*3+(3*3)'
 ##
function math () {
    if [ -z "$1" ]; then
        echo "Type the operation to be evaluated:"
        read EVAL
        echo $(math "$EVAL")
    else
        calc="${@//p/+}"
        calc="${calc//x/*}"
        bc -l <<<"scale=10;$calc"
    fi
}

## -----------------------------------------
 # Create a new directory & cd into it
 #
 # @1 = New directory name
 ##
function mkcd () {
    if [ -z "$1" ]; then
        echo "Please provide a name for the new directory:"
        read DIR
    else
        DIR = $1
    fi
    mkdir "$DIR"
    cd "$DIR"
}

## -----------------------------------------
 # Move file to a new directory, overwriting any existing file
 #
 # @1 = File to move (name/location)
 # @2 = File destination (name/location)
 ##
function mv! () {
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Filename and destination required.."
    else
        cp $1 $2
        rm $1
    fi
}

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

## -----------------------------------------
 # Creates new variable & writes to file
 #
 # @1 = variable new
 # @2 = variable definition
 #    * Requires `'~/.bash_variables'` exists & is executed in `'~/.bashrc'`
 ##
function new-variable () {
    if [ -f ~/.bash_variables ]; then
        if [ -z "$1" ]; then
            echo "variable name (e.g. 'NEW_VAR' for '\$NEW_VAR'):"
            read NAME
        else
            NAME=$1
        fi
        if [ -z "$2" ]; then
            echo "variable definition:"
            read DEFINTION
        else
            if [ "$2" = "-cd" ]; then
                DEFINTION='cd '
            else
                DEFINTION=$2
            fi
        fi
        echo "export $NAME=\"$DEFINTION\"" >> $HOME/.bash_variables
        export $NAME="$DEFINTION"
    else
        echo "Ut-oh! This function requires '~/.bash_variables' exists and is executed in '~/.bashrc'"
    fi
}

## -----------------------------------------
 # Create a new bash/shell script & place the executable in your path
 #
 # @1 = Name of the new script
 #    * Requires 'MY_BIN' to be defined
 ##
function new-shell-script () {
    if [ -z "$MY_BIN" ]; then
        echo "'MY_BIN' is not defined!"
        echo "You can define it in '~/.bashrc' (e.g. 'export MY_BIN=/usr/bin')"
    else
        if [ -z "$1" ]; then
            echo "What do you want to call your new script?"
            read USERSCRIPT
        else
            USERSCRIPT=$1
        fi
        echo "Okay, creating shell script file '$USERSCRIPT.sh'.."
        touch $USERSCRIPT.sh
        chmod +x $USERSCRIPT.sh
        sleep 1
        echo "Opening your script for edit."
        echo "Got it? Good. Press Enter to continue."
        read
        $EDITOR $USERSCRIPT.sh
        echo "Save & Press Enter in your terminal when finished..."
        read
        mv $USERSCRIPT.sh $MY_BIN/$USERSCRIPT
        echo "Moving new script to your PATH ($MY_BIN/$USERSCRIPT)"
        echo "All done! Your new script is ready to use :-)"
    fi
}

## -----------------------------------------
 # Create a symbolic link
 #
 # @1 = Destination (should already exist)
 # @2 = Name for symbolic link (will be created in the current directory)
 #    ~ Optionally define 'HISTFILE' to write to bash history
 ##
function new-slink () {
    if [ "$(whoami)" != "root" ]; then
        SUDOER=""
    else
        SUDOER="sudo "
    fi
    if [ -z "$1" ]; then
        echo "destination (this should already exist):"
        read DEST
    else
        DEST=$1
    fi
    if [ -z "$2" ]; then
        echo "link name/location (make sure you are in this directory already!):"
        read LINK
    else
        LINK=$2
    fi
    CMD="$SUDOER ln -s $DEST $LINK"
    printf "$CMD \n"
    $CMD
    # Write to history
    if [ -f "$HISTFILE" ]; then
        echo "History file exists!"
        echo "Writing to bash history and cleaning up."
        echo $CMD >> "$HISTFILE"
    else
        echo "No history file in clear site!"
        echo "You can specify one in '~/.bashrc' (e.g. 'HISTFILE=~/.bash_history')"
    fi
}
