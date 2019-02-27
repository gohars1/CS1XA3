#!/usr/bin/python

import sys
def hangman(s):
	word = list(s) #separates the string into a list of chars
	wordlength = len(s) # variable with length of string saved to it
	wordlength2 = len(s) 
	list1 = [] 
	while (wordlength > 0): #The following while loop generates a list with underscores to generate  [ _ , _ , _ ..] for hangman
		list1.append('_')
		wordlength = wordlength - 1 

	print('Starting Hangman')
	print("your word is %d characters long" % (wordlength2) ) #lets the player know the length of the word
	print("Make sure you add quotes around your letter!") #Important prompt, game will not run properly if quotes are not used
	man = 0
	while ( man < 6): # Since it takes 6 mistakes for the man to be generated, the while loop ends when the var 'man' reaches 6
		character = input('Choose a letter ')
		if (character in list1):
			print('You have already used this character') #stops user from reusing the same letter
		elif character in word:
			for c in range (0 , len(word)):
				if (word[c] == character):
					list1[c] = word[c] #if user guesses correctly, all instances of the character will appear in the list

		else:
			man = man + 1 #if mistake is made, counter increases
		if (man == 1):
			print('<',)
		elif (man == 2):
			print('<0',)
		elif (man == 3):
			print('<0-',)
		elif (man == 4):
			print('<0-[',)
		elif (man == 5):
			print('<0-[-',)
		elif (man == 6):
			print('<0-[-(',) # these cases generate the man for each mistake
		print(list1)

		if (man == 6):
			print ('haha, you lose') # tells the user he lost the game
		elif( '_' not in list1):
			print('hooray, you won!') # tells the user he won the game
			break 

if(len(sys.argv) != 2): #allows for the program to take an argument which is then used as the word in hangman
	print ('Usage: Hangman.py <word>')
else:
	hangman(sys.argv[1])

