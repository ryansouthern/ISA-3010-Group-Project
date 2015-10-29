#!/usr/bin/ruby -w
#------------------------------------------------------------
# 
# Script Name: store.rb
# Version: 1.0
# Author: Ryan Southern
# Author: Vishav Kalia
# Author: Lindsay Anderson
# Author: Annabel Biwott
# Date: October 2015
# 
# Description: This Ruby program covers some of the basic 
#              operations of an e-Commerce store.
# 
#------------------------------------------------------------

#Define console windows class
class Screen
	def cls #Define a method that clears the display area
		puts ("\n" * 25) #Scroll the screen 25 times
	end

	def pause #Define a method that pauses the display area
		#Execute the STDIN class's get method to pause
		#script execution until the player presses Enter
		STDIN.gets
	end
end

#Define the store class
class StoreClass

	def welcome
		welcomeMessage = "Welcome to the store.  Press Enter to continue. \n"
		print welcomeMessage
	end

	def menu
		menuTxt = "Please select from the following: \n" +
		"(Enter the number, then press Enter)\n" +
		"1. Purchase Item \n" +
		"2. Lookup Purchase History \n" +
		"3. Exit\n"
		print menuTxt
	end

end



# Main Script Logic -----------------------------------------

Console_Screen = Screen.new #Initialize a new Screen object
Store = StoreClass.new #Initialize a new StoreClass object

Console_Screen.cls #Clear the display area

Store.welcome #Display the welcome message

Console_Screen.pause #wait for input

menuSelection = "" #Initialize variable for menu selection

#loop unitl a correct menu selection has been made
until menuSelection == "1" || menuSelection == "2" || menuSelection == "3"
	Console_Screen.cls
	Store.menu
	menuSelection = STDIN.gets
	menuSelection.chop!
end

# menu logic, then preform the action
if menuSelection == "1"
	
	Console_Screen.cls #Clear the display area

	#get items from flat file
	items = Array.new
	File.open('products.txt') do |f|
		f.each_line do |line|
			items << line.chomp.split(/\s*\|\s*/)
		end
	end

	puts "Please enter your name."
	customer = STDIN.gets

	purchaseItem = 0
	until purchaseItem < 1 || purchaseItem > items.length || purchaseItem != null
		puts "What would you like to purchase?\n" +
		"(Enter item number and press enter)"

		items.each_with_index { |x,index| puts "Item #{index + 1} is #{x[0]} for #{x[1]}" }
		purchaseItem = STDIN.gets.to_i

		if purchaseItem < 1 || purchaseItem > items.length
			puts "Please enter a valid item number."
			puts purchaseItem
		end
	end

elsif menuSelection == "2"

	Console_Screen.cls #Clear the display area

	#put lookup history code here

else

	Console_Screen.cls #Clear the display area

	puts "Please come back soon! \n"

end