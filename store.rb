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

	def purchase
		Console_Screen.cls #Clear the display area
	
		#get items from flat file
		items = Array.new
		prodfile = File.join(File.dirname(__FILE__), 'products.txt')
		File.open(prodfile) do |f|
			f.each_line do |line|
				items << line.chomp.split(/\s*\|\s*/)
			end
		end
	
		puts "Please enter your name."
		customer = STDIN.gets.chomp
		
		purchaseItem = 0
		puts "What would you like to purchase?\n" +
		"(Enter item number and press enter)"
		
		items.each_with_index { |x,index| puts "Item #{index + 1} is #{x[0]} for $#{x[1]}" }
		purchaseItem = STDIN.gets.to_i

		if purchaseItem - 1 >= 0 && purchaseItem - 1 < items.length
			purchasedItem = "#{items[purchaseItem - 1][0]}"
			price = "#{items[purchaseItem - 1][1]}"
			time1 = Time.new
			date = time1.strftime("%Y-%m-%d")
			time = time1.strftime("%H:%M:%S")
			Store.logPurchase(customer,purchasedItem,price,date,time)
			Console_Screen.cls #Clear the display area
			puts "Thanks for your purchase! (Press enter)"
			Console_Screen.pause #wait for input
			Store.storeClose
		else
			Console_Screen.cls #Clear the display area
			puts "Please select a valid option."
			purchase(0)
		end
	end

	def logPurchase(customer,purchasedItem,price,date,time)
		hisfile = File.join(File.dirname(__FILE__), 'purchase-history.txt')
		open(hisfile, 'a') { |f|
  			f.puts "#{customer}|#{purchasedItem}|#{price}|#{date}|#{time}"
		}
	end

	def getHistory
		Console_Screen.cls #Clear the display area
		
		#get history from flat file
		history = Array.new
		File.open('purchase-history.txt') do |f|
			f.each_line do |line|
				history << line.chomp.split(/\s*\|\s*/)
			end
		end

		history.each { |x| puts "#{x[0]} purchased a #{x[1]} for $#{x[2]} on #{x[3]} at #{x[4]}" }
	end

	def storeClose
		Console_Screen.cls #Clear the display area

		puts "Please come back soon! \n"
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

# menu logic
if menuSelection == "1"
	Store.purchase
elsif menuSelection == "2"
	Store.getHistory
else
	Store.storeClose
end