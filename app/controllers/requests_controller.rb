class RequestsController < ApplicationController
  before_filter :save_action, :except => [:create]
  
  #GET requests/new
  def new
    @request = Request.new
  end
  
  def express
    redirect_to :action => 'express_moscow'
  end

  #GET requests/*
  [:moscow, :region, :commerce, :residential].each do |request_type|
    define_method "express_#{request_type}" do 
      @request = Request.new
      
      render :action => 'express'
    end
  end
  
  #POST requests
  def create
    @request = Request.new(params[:request])
    
    if @request.save
      RequestMailer.request_email(@request).deliver
      redirect_to root_url
    else
      render :action => session[:action]
    end
  end
  
  protected
  
  def save_action
    session[:action] = params[:action]
  end
end