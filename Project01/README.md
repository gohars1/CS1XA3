# README for Part 1 Project01, project analyze.sh <h1>

To incorporate user input, the script asks you what your name is.
It then prompts you to input some characters, preferably your name.
Whatever it is that you input, the script will than call you whatever you
inputted and ask if you would like a TODO log.
** This part is crucial, you must answer "yes", it is case sensitive, if you
type anything else, it will say "please execute again" and end.**
If you do say yes it will then search through the repository for a count of the
following file types (Java,Python,HTML,CSS,Haskell, and Bash Script Files).
First it echos "number of (current_file_type) files" and then on the same line
outputs the number of files. 
It does this by using (ls -R (absolute path of CS1XA3 directory)) to list all the
files in the directory. It then greps that list of files and searches for file
extensions of type (.html,.py,.hs,etc). Grep also uses a -c flag which counts the
number of things it finds.
 
