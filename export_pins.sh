# there must be exactly 1 argument
# $# is the quantity of command line arguments passed
# -eq compares if the number is equal to something (1 in this case)
if [ $# -eq 1 ]
then
	# argument must be a valid file
	# -r verifies if something is a readble file
	# $1 correspond tothe first command line argument passed (that must be a readble file)
	if [ -r $1 ]
	then
		# readble file in $1 is assigned to config_pin_file variable 
        config_pin_file=$1

        # prints a beautiful line :3
        echo ------------------------------------------	
		
		# this variable stores the index of the current line
		line_counter=0

		# reading each line of the config_pin_file (indicated after this corresponding done statment)
        while read line; do
        	
        	# filtered_line is line with   leading        and    trailing       spaces trimmed
            filtered_line=$(echo $line | sed -e 's/^ *//g' | sed -e 's/ *$//g')

            # filtered_line is now submitted to the minimal formatting. If it is ill formed, filtered_line will be empty
        	filtered_line=$(echo $filtered_line | grep -P '^(P|p)\d_?\d\d\s+\w+$')

        	# warn if the line is wrong formatted
        	if [ -z "$filtered_line" ]
        	then
        		echo 'Line' $line_counter ': '$line
        		echo "Wrong format. Should be like this:"
        		echo "P9_24 can"
			    echo "p8_40 pruout"
			    echo "p830 pruin"
			    echo "P932 in"
        	else
        		# otherwise, try to do the config
            	# word_counter is just a variable to differentiate between first and second word of a line
            	word_counter=0

				for word in $line; do
	            	# pin_mode is a array in which the first element is the pin and the second is the mode
		            pin_mode[$word_counter]=$word
	            	
	            	# incrementing the word_counter (eternally 0 or 1)
	            	word_counter=$(($word_counter+1))
		        done

	        	# indicating what happened
	            echo Setting pin ${pin_mode[0]} to mode ${pin_mode[1]}
	            config-pin ${pin_mode[0]} ${pin_mode[1]}
	            echo Final pin mode\:
	            config-pin -q ${pin_mode[0]}
		    fi

            echo ------------------------------------------

            # incrementing line_counter
            line_counter=$(($line_counter+1))
        done < $config_pin_file
	else
		# argument is not a readble file
		echo 'Can not read file '$1'. The file exists? Is it readable?'
	fi
else
	# if there's no argument, show what should be
    echo There must be exactly 1 argument that is a text file path of  the following format\:
    echo "P9_24 can"
    echo "p8_40 pruo"
    echo "p830 pruin"
    echo "P932 in"
fi
