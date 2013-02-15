class SiteController < ApplicationController
  def index
    @page = StaticPage.find_by_link('catalog') || StaticPage.root
    if @page.redirect_url.blank?
      set_meta(@page)
    else
      redirect_to @page.redirect_url
    end
  end

  def static_page
    @page = StaticPage.find(params[:page_id])
    if @page.redirect_url.blank?
      set_meta(@page)
      
      template = @page.link
      begin
        logger.info "Try #{template} template ..."
        render :action => template
      rescue ActionView::MissingTemplate => e1
        begin
          template = @page.self_and_ancestors[0].link
          logger.info "Try #{template} template ..."
          render :action => template
        rescue ActionView::MissingTemplate => e2
          logger.info "Use default StaticPage template"
        end
      end
    else
      redirect_to @page.redirect_url
    end
  end
end
