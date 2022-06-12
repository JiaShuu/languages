#!/bin/bash
########################################################################################################################
# BASH NOTES
# From https://missing.csail.mit.edu/, https://effective-shell.com/
# In Unix and Linux - almost everything can be represented as a file. 
########################################################################################################################
echo $PATH                                      # to print path
mv                                              # to rename/move a file
cp                                              # to copy a file
mkdir                                           # to make a new directory
cat hello.txt                                   # to catenate
cat < hello.txt > hello2.txt                    # redirection
>>                                              # to append to a file
sudo !!                                         # run last command as root
echo 3 | sudo tee brightness                    # Each command in a pipeline is executed in its own subshell  
                                                # Gotcha！sudo echo 3 > brightness 
                                                # https://effective-shell.com/part-2-core-skills/thinking-in-pipelines/
\                                               # Escape Character
''                                              # preserves the literal value of each character within the quotes. 
""                                              # preserves the literal value of all characters except '$', '`', '\'
chmod 754                                       # change file mode 4(r) + 2(w) + 1(x)
foo=bar                                         # to assign a variable
diff <(ls foo) <(ls bar)                        # show differences (get the output of a command as a variable)
sort                                            # type ^D to end transmission, ^C to interrupt
#!/usr/bin/env python                           # use environment variable to run Python scripts
find . -name src -type d                        # Find all directories named src
find . -path '*/test/*.py' -type f              # Find all python files within test folder
find . -mtime -1                                # Find all files modified in the last day (modification time)
find . -size +500k -size -10M -name '*.tar.gz'  # Find all zip files with size in range 500k to 10M
find . -name '*.tmp' -exec rm {} \;             # Delete all .tmp extension files
find . -name '*.png' -exec convert {} {}.jpg \; # Find all PNG files and convert them to JPG
fd ".*py"
grep -C 1 -R foobar                             # context of 1 line and recursively
history | grep ls                               # print history commands containing ls
^r                                              # backward research
cat mcd.sh | fzf                                # fuzzy find
fish                                            # autofill tool which gives history-based autosuggestions
&>file                                          # redirect stdout and stderr to file
                                                # same as >&file     or       >file 2>&1
########################################################################################################################
$0 - Name of the script
$1 to $9 - Arguments to the script. $1 is the first argument and so on.
$@ - All the arguments
$# - Number of arguments
$? - Return code of the previous command
$$ - Process identification number (PID) for the current script
!! - Entire last command, including arguments. 
$_ - Last argument from the last command. 
########################################################################################################################
false || echo "Oops, fail"              # Oops, fail
true || echo "Will not be printed"      #
true && echo "Things went well"         # Things went well
false && echo "Will not be printed"     #
true ; echo "This will always run"      # This will always run
false ; echo "This will always run"     # This will always run
########################################################################################################################
echo "Starting program at $(date)" 
echo "Running program $0 with $# arguments with pid $$"
for file in "$@"; do
    grep foobar "$file" > /dev/null 2> /dev/null
    # When pattern is not found, grep has exit status 1
    # redirect STDOUT and STDERR to a null register since we do not care about them
    if [[ $? -ne 0 ]]; then
    # try to use double brackets [[ ]] in favor of simple brackets [ ]
        echo "File $file does not have any foobar, adding one"
        echo "# foobar" >> "$file"
    fi
done
########################################################################################################################
# globbing
rm foo?                    # rm foo1,foo2...foo999
rm f*                      # rm fo,foo,fooo...
mkdir foo bar
touch {foo,bar}/{a..h}     # creates files foo/a, foo/b, ... foo/h, bar/a, bar/b, ... bar/h 
########################################################################################################################
# ex1
#!/usr/bin/env bash
marco() {
    export MARCO=$(pwd)
}

polo() {
    cd "$MARCO"
}

                        # another way
#!/user/bin/env sh
marco() {
    pwd > /tmp/marco
}
polo() {
    cd $(cat /tmp/marco)
}
########################################################################################################################
# ex2 random.sh
#!/usr/bin/env bash
n=$((RANDOM % 100))

if [[ n -eq 42 ]]; then
    echo "Something went wrong">&2
    echo "The error was using magic numbers"
    exit 1
fi

echo "Everything went according to plan"


# debug1.sh
#!/usr/bin/env bash

count=0
until [[ "$?" -ne 0 ]];
do
count=$((count+1))
./random.sh 2> out.txt
done

echo "found error after $count runs"
cat out.txt


# debug2.sh
#!/usr/bin/env bash
runs=0
error=0
while [ true ]; do
    bash random.sh 1>>/tmp/debug-out.txt 2>>/tmp/debug-error.txt
    ((++runs))
    if [ -s /tmp/debug-error.txt ]; then
        break
    fi
done
cat /tmp/debug-out.txt /tmp/debug-error.txt
rm /tmp/debug-{out,error}.txt
echo "It took $runs runs."    
########################################################################################################################

