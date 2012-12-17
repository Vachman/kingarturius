class Request < ActiveRecord::Base
  validates_presence_of :full_name
  validates_presence_of :email
  validates_presence_of :phone
  validates_presence_of :request_type
  
  validates_length_of :phone, :within => 10..10
end
