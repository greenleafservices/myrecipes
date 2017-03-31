class PagesController < ApplicationController
		def home
			# If we're logged in, go to the recipes listing, not the home page for the app
			redirect_to recipes_path if logged_in? #logged_in is in the ApplicationController
		end
	end
