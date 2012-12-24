class CatalogController < ApplicationController
  before_filter :prepare_paginator, :only => [:index, :category]
  
  def index
    @subcats = Category.navigation.site_roots.page(@page).per(@perpage)
    
    render :action => 'category'
  end

  def category
    @category = Category.find(params[:category_id])
    @goods = @category.goods.on_site.page(@page).per(@perpage)
    @subcats = Category.site_children(@category).navigation.page(@page).per(@perpage)
  end
  
  def good
    @category = Category.find(params[:category_id])
    @good = Good.find(params[:good_id])
  end

end
