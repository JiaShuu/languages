#!/bin/bash
########################################################################################################################
# BASH NOTES
# From https://missing.csail.mit.edu/
# Commands in bash are like machines in a factory connected by magic pipelines.
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

