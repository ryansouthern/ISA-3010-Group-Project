#!/usr/bin/ruby -w
#------------------------------------------------------------
# 
# Script Name: store.rb
# Version: 1.0
# Author: Ryan Southern
# Date: October 2015
# 
# Description: This Ruby program covers some of the basic 
#              operations of an e-Commerce store.
# 
#------------------------------------------------------------

class Screen
	def cls #Define a method that clears the display area
		puts ("\n" * 25) #Scroll the screen 25 times
	end
end

Console_Screen = Screen.new
Console_Screen.cls