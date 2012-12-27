class CatalogController < ApplicationController
  before_filter :prepare_paginator, :only => [:index, :category]
  
  def index
    @subcats = Category.navigation.site_roots.page(@page).per(@perpage)
    
    render :action => 'category'
  end

  def category
    @category = Category.find(params[:category_id])
    @subcats = Category.site_children(@category).navigation.page(@page).per(@perpage)
    
    @goods = @category.goods.on_site.page(@page).per(@perpage)
    process_filter
  end
  
  def good
    @category = Category.find(params[:category_id])
    @good = Good.find(params[:good_id])
  end

  protected
  
  def process_filter
    return unless params[:filter].is_a?(Hash)
    
    params[:filter].each do |name, value|
      filter_category = Category.find_by_link(name)
      next if filter_category.nil?
                
      filter_value_category = filter_category.children.find_by_link(value)
      next if filter_value_category.nil?
            
      @goods = @goods.has_virtual_category(filter_value_category)
    end
  end
end
