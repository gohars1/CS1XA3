#!/bin/bash

echo "Hi User, may I ask what your name is?"

read var1

echo "Nice to meet you $var1, would you like a File Type Count?"

read var2

	if [ "$var2" == "yes" ]; then
		echo -n "Number of HTML Files: "
		ls -R /home/gohars1/CS1XA3 | grep -c ".html"
		echo -n "Number of CSS Files: "
		ls -R /home/gohars1/CS1XA3 | grep -c ".css"
		echo -n "Number of Javascript Files: "
		ls -R /home/gohars1/CS1XA3 | grep -c ".jss"
		echo -n "Number of Haskell Files: "
		ls -R /home/gohars1/CS1XA3 | grep -c ".hs"
		echo -n "Number of Python Files: "
		ls -R /home/gohars1/CS1XA3 | grep -c ".py"
		echo -n "Number of Bash Script Files: "
		ls -R /home/gohars1/CS1XA3 | grep -c ".sh"
			
	else
		echo "Please execute again"
	fi
