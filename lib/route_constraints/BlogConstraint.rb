class BlogConstraint
  def self.matches?(request)
    #ActiveRecord::Base.logger.debug request.params[:path].to_json
    
    return case request.params[:action]
    when :index
      Event.EVENT_CATEGORIES.include?(request.params[:name])
    when :show
      Event.EVENT_CATEGORIES.include?(request.params[:name]) && 
      !Event.with_category(request.params[:name]).find_by_id(request.params[:id]).nil?
    else
      false
    end
  end
end
