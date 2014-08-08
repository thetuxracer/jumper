#! /bin/bash

while read line
do
    my_array=("${my_array[@]}" $line)
done

if [ "$(uname)" == "Darwin" ]; then
  # osascript -e "tell application \"Terminal\" to do script \"cd $pwd; clear\"" > /dev/
  for ARG in "${my_array[@]}"
    do
osascript <<END
      tell application "iTerm"
    activate
    
    -- make a new terminal
    set myterm to (make new terminal)
    
    -- talk to the new terminal
    tell myterm
      
      -- make a new session
      set mysession to (make new session at the end of sessions)
      
      -- set size
      set number of columns to 100
      set number of rows to 50
      
      -- talk to the session
      tell mysession
        
        exec command "ssh root@$ARG"
        
      end tell -- we are done talking to the session
      
      -- we are back to talking to the terminal
      
      --wait-- launch a default shell in a new tab in the same terminal
      end tell
      
   end tell
 
END

done
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # Do something under Linux platform
    for ARG in "${my_array[@]}"
    do
      # echo $ARG
      xterm -hold -e ssh root@$ARG &
    done

elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    # Do something under Windows NT platform
    echo "You are beyond saving!"
fi


# for ARG in "$@"
# do
#   # echo $ARG
#   xterm -hold -e ssh root@$ARG &
# done

# xterm -hold -e ssh root@$1