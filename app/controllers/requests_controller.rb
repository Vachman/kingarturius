class RequestsController < ApplicationController

  #GET requests/new
  def new;end

  #GET requests/express
  def express;end
  
  #POST requests
  def create
    @request = Request.new(params[:request])
    
    if @request.save
      RequestMailer.request_email(@request).deliver
      redirect_to root_url
    else
      render request.referrer
    end
  end
end