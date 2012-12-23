class EventsController < ApplicationController
  def index
    @perpage = params[:perpage].to_i > 0 ? params[:perpage].to_i : 10
    @page = params[:page].to_i > 0 ? params[:page].to_i : 1
    
    @events = Event.with_category(params[:name]).on_site.page(@page).per(@perpage)
  end
  
  def show
    @event = Event.with_category(request.params[:name]).find_by_id(request.params[:id])
    
    redirect_to blog_url unless @event
  end
end
