class AuthController < ApplicationController
	protect_from_forgery :except => :auth # stop rails CSRF protection for this action

	def auth
		if true
			response = Pusher[params[:channel_name]].authenticate(params[:socket_id])
			render :json => response
		else
			render :text => "Forbidden", :status => '403'
		end
	end
end