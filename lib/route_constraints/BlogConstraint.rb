class BlogConstraint
  def self.matches?(request)
    #Rails.logger.debug({:a => Event::EVENT_CATEGORIES.include?(request.params[:name])})
    #Rails.logger.debug({:p => request.params})
    
    Event::EVENT_CATEGORIES.include?(request.params[:name])
  end
end
