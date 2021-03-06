class Event < ActiveRecord::Base
  has_many :attachments, 
           :as => :resource,
           :dependent => :destroy
  has_many :photo_albums,
           :dependent => :nullify
  scope :sorted, order('created_at desc')
  scope :inv_sorted, order('created_at asc')
  scope :visible, where(:visible => true)

  scope :all_events, where('1=1')
  #scope :future, where('date >= current_timestamp')
  #scope :past, where('date < current_timestamp')
  scope :featured, where(:featured => true)

  scope :news, where(event_category: 'news')
  scope :informations, where(event_category: 'informations')
  scope :mortgages, where(event_category: 'mortgages')
  scope :services, where(event_category: 'services')
  
  #scope :today, where("date_trunc('day', date) = date_trunc('day', current_timestamp)").visible
  #scope :of_current_year, where("extract(year from date) = extract(year from current_timestamp)")
  #scope :for_calendar, select("max(name) as name, date_trunc('day', date) as date").group("date_trunc('day', date)")

  scope :on_site, visible.sorted
#  scope :site_future, future.visible.inv_sorted
  scope :site_featured, featured.on_site
  
  scope :with_category, lambda { |cat|
    where :event_category => cat.to_s
  }
  scope :by_year_and_month, lambda { |year, month|
    events_date = Date.new(year.to_i, month.to_i) rescue Date.today
    
    where(["date_trunc('month', date) = date_trunc('month', TIMESTAMP ?)", events_date])
  }

  validates :name, :presence => true, 
                   :length => { :maximum => 255 }
  #validates :date, :presence => true

  VISIBLE = "visible"
  INVISIBLE = "invisible"
  EVENT_CATEGORIES = [ 'news', 'informations', 'mortgages', 'services' ]
  
  
  def self.event_categories
    event_categories = {}
    EVENT_CATEGORIES.map { |e| event_categories[I18n.t("active_admin.scopes.#{e}")] = e }
    event_categories
  end

  def status
    visible ? VISIBLE : INVISIBLE
  end

  def to_s
    name
  end

#  def date_json
#    [date.month, date.day, date.year]
#  end
  
  def self.months
    Event.on_site.select("DISTINCT date_trunc('month', date) as date").collect(&:date).sort
  end
  
  def has_image?
    attachments.count > 0
  end
  
  def image
    if has_image?
      (attachments.main.first || attachments.sorted.first).image
    else
      nil
    end
  end

  def attachment_styles
    { :list_image => "172x172#" } 
  end

end
