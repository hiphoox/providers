# encoding: utf-8
ActiveAdmin::Dashboards.build do

	section "Últimos Candidatos Capturados" , :if => Proc.new { not current_admin_user.isAdmin } do
  	table_for Candidate.where(:admin_user_id => current_admin_user).where(:status => Candidate::STATUS_NEW).order('created_at desc').all do |t|
			t.column "Nombre", :first_name do |candidate|
	    	link_to candidate.first_name, admin_candidato_path(candidate)
	    end
    	t.column "Apellido Paterno", :last_name
    	t.column "Apellido Materno", :mother_name
   		t.column "RFC", :rfc
    	t.column "Proveedor", :admin_user if current_admin_user.isAdmin
	  	end
  end

	section "Candidatos Rechazados" , :if => Proc.new { not current_admin_user.isAdmin } do
		table_for Candidate.where(:admin_user_id => current_admin_user).where(:status => Candidate::STATUS_REJECTED).order('created_at desc').all do |t|
			t.column "Nombre", :first_name do |candidate|
				link_to candidate.first_name, admin_candidato_path(candidate)
			end
			t.column "Apellido Paterno", :last_name
			t.column "Apellido Materno", :mother_name
		 	t.column "RFC", :rfc
			t.column "Proveedor", :admin_user if current_admin_user.isAdmin
			end
	end

	section "Últimos Candidatos Capturados" , :if => Proc.new { current_admin_user.isAdmin } do
		table_for Candidate.where(:status => Candidate::STATUS_NEW).order('created_at desc').all do |t|
			t.column "Nombre", :first_name do |candidate|
				link_to candidate.first_name, admin_candidato_path(candidate)
			end
			t.column "Apellido Paterno", :last_name
			t.column "Apellido Materno", :mother_name
		 	t.column "RFC", :rfc
			t.column "Proveedor", :admin_user if current_admin_user.isAdmin
			end
	end

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
  
  # == Conditionally Display
  # Provide a method name or Proc object to conditionally render a section at run time.
  #
  # section "Membership Summary", :if => :memberships_enabled?
  # section "Membership Summary", :if => Proc.new { current_admin_user.account.memberships.any? }

end
