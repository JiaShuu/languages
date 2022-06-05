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
