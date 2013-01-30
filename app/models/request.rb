class Request < ActiveRecord::Base
  validates_presence_of :full_name
  validates_presence_of :email
  validates_presence_of :phone
  validates_presence_of :request_type
  
  validates_length_of :phone, :within => 10..10
  
  serialize :information, Hash
  
  DEPARTMENTS = [:one, :two, :three]
  TYPES = [:type1, :type2, :type3]
  METRO = [:m1, :m2]
  GOALS = [:g1, :g2]
  OPERATION_TYPES = [:ot1, :ot2]
  OBJECT_TYPES = [:ob1, :ob2]
  DIRECTIONS = [:dir1, :dir2]
  MATHERIALS = [:mat1, :mat2]
  
  T_INF_SCOPE = [:activerecord, :attributes, :request, :information]
  T_TYP_SCOPE = [:activerecord, :attributes, :request, :types]
  T_DEP_SCOPE = [:activerecord, :attributes, :request, :departments]
  T_MET_SCOPE = [:activerecord, :attributes, :request, :metro]
  T_GOA_SCOPE = [:activerecord, :attributes, :request, :goals]
  T_OPT_SCOPE = [:activerecord, :attributes, :request, :operation_types]
  T_OBT_SCOPE = [:activerecord, :attributes, :request, :object_types]
  T_DIR_SCOPE = [:activerecord, :attributes, :request, :directions]
  T_MAT_SCOPE = [:activerecord, :attributes, :request, :matherials]
end
