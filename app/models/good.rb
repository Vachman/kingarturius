class Good < ActiveRecord::Base
  acts_as_list :scope => :category

  serialize :parameters
  serialize :variants
  serialize :similar

  belongs_to :category
  has_and_belongs_to_many :virtual_categories, :class_name => 'Category'
  
  has_many :attachments, 
           :as => :resource,
           :dependent => :destroy
  has_many :extra_attachments, 
           :as => :resource,
           :dependent => :destroy

  has_many :order_goods,
           :dependent => :restrict

  #default_scope order('position ASC')
  scope :visible, where(:visible => true)
  scope :sorted, order('position asc')
  scope :on_site, visible.sorted

  scope :random, lambda { |cnt|
    order('random()').limit(cnt)
  }
  scope :not, lambda { |id|
    where(['id <> ?', id])
  }
  scope :has_virtual_category, lambda { |category|
    joins(:virtual_categories).
    where('categories_goods.category_id' => category.id)
  }
  scope :to_export, where(:export => true)

  scope :vc_id_eq, lambda { |id|
    joins(:virtual_categories).
    where('categories_goods.category_id' => id)
  }
  search_methods :vc_id_eq

  
  validates :category, :presence => true
  validates :name, :presence => true, 
                   :length => { :maximum => 255 }
  validates :price, :presence => true,
                    :numericality => true 
  
  VISIBLE = "visible"
  INVISIBLE = "invisible"
  IN_EXPORT = "in_export"
  NOT_IN_EXPORT = "not_in_export"

  def variants
    {
      "color" => [],
      "cloth" => [],
      "size" => []
    }.merge(super || {})
  end

  def nested_parameters
	  (self.parameters.nil? && !self.category.nil?) ? 
	      self.category.nested_parameters : self.parameters
	end

  def to_s
    self.name
  end

  def present_in?(category)
    return ( category.virtual && self.virtual_category_ids.include?(category.id) ) || 
    ( !category.virtual && self.category_id == category.id )
  end
  
  def attachment_styles
    { :list_image_big => "272x172#", :list_image_small => "84x60#" } 
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
  
  def extra_images
    (attachments.sorted[1..-1] || []).map &:image
  end

  def status
    self.visible ? VISIBLE : INVISIBLE
  end
  
  def export_status
    self.export ? IN_EXPORT : NOT_IN_EXPORT
  end

  def move_possible?(category)
    !category.virtual
  end

end
