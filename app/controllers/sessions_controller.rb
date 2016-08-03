class SessionsController < ApplicationController
	def create
		raise env["ominauth.auth"].to_yaml
	end
end