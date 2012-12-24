class EventsController < ApplicationController
  before_filter :prepare_paginator, :only => [:index]
  
  def index
    @events = Event.with_category(params[:name]).on_site.page(@page).per(@perpage)
  end
  
  def show
    @event = Event.with_category(request.params[:name]).find_by_id(request.params[:id])
    
    redirect_to blog_url unless @event
  end
end
