ActiveAdmin::Dashboards.build do

  # Define your dashboard sections here. Each block will be
  # rendered on the dashboard in the context of the view. So just
  # return the content which you would like to display.
  
  # == Simple Dashboard Section
  # Here is an example of a simple dashboard section
  #
  #   section "Recent Posts" do
  #     ul do
  #       Post.recent(5).collect do |post|
  #         li link_to(post.title, admin_post_path(post))
  #       end
  #     end
  #   end

  section I18n.t('active_admin.titles.request.recent_requests') do
     table_for(Request.limit(15)) do |t|
       t.column(I18n.t('activerecord.attributes.request.id'), :id )
       t.column(I18n.t('activerecord.attributes.request.full_name'), :full_name )
       t.column(I18n.t('activerecord.attributes.request.phone'), :phone )
       t.column(I18n.t('activerecord.attributes.request.email'), :email )
       t.column(I18n.t('activerecord.attributes.request.request_type'), :request_type )       
       t.column(I18n.t('activerecord.attributes.request.created_at'), :created_at)
       t.column('') { |i| link_to( I18n.t('active_admin.titles.request.more') , admin_request_path(i)) }       
     end
  end
 
  # Request.limit(15).collect do |request|
  #   li request.full_name
  #   li request.created_at
  #   li link_to(request.email, request.email)
  # end

  

  
  # == Render Partial Section
  # The block is rendered within the context of the view, so you can
  # easily render a partial rather than build content in ruby.
  #
  #   section "Recent Posts" do
  #     div do
  #       render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
  #     end
  #   end
  
  # == Section Ordering
  # The dashboard sections are ordered by a given priority from top left to
  # bottom right. The default priority is 10. By giving a section numerically lower
  # priority it will be sorted higher. For example:
  #
  #   section "Recent Posts", :priority => 10
  #   section "Recent User", :priority => 1
  #
  # Will render the "Recent Users" then the "Recent Posts" sections on the dashboard.

end
