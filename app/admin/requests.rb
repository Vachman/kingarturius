ActiveAdmin.register Request do
  
  filter :request_type  
  filter :full_name
  filter :phone
   
  index do
    column(:full_name, :sortable => false)
    column(:request_type, :sortable => false)
    column(:created_at, :sortable => false)
    column('') { |i| link_to( I18n.t('active_admin.titles.request.more') , admin_request_path(i)) }  
  end
end