ActiveAdmin.register Candidate do
  menu :label => "Candidatos" #,:if => proc{ current_admin_user.isAdmin }

  index do
    column "Nombre", :first_name do |candidate|
      link_to candidate.first_name, admin_candidate_path(candidate)
    end
    column "Apellido Paterno", :last_name
    column "Apellido Materno", :mother_name
    column "RFC", :rfc
    column "Proveedor", :admin_user if current_admin_user.isAdmin
    column "Estatus", :status
    
    default_actions
  end

  controller do
    def scoped_collection
      if current_admin_user.isAdmin then
        end_of_association_chain
      else
        current_admin_user.candidates
      end
    end
  end

  # Filter only by name
  filter :first_name, :label => "Nombre"
  filter :last_name, :label => "Apellido Paterno"
  filter :rfc, :label => "RFC"
  filter :admin_user, :label => "Proveedor", :collection => proc { if current_admin_user.isAdmin then AdminUser.all else {} end }

  scope :all, :default => true
  scope :nuevo do |candidates|
    candidates.where(:status => Candidate::STATUS_NEW)
  end

  scope :aceptado do |candidates|
    candidates.where(:status => Candidate::STATUS_ACCEPTED)
  end

  scope :rechazado do |candidates|
    candidates.where(:status => Candidate::STATUS_REJECTED)
  end


  show do
    panel "Informacion General" do
      attributes_table_for candidate do
        row("Nombre") {candidate.first_name}
        row("Apellido Paterno") {candidate.last_name}
        row("Apellido Materno") {candidate.mother_name}
        row("RFC") {candidate.rfc}
        row("Estatus") {candidate.status}
      end
    end
    active_admin_comments
  end
  
  sidebar "Otra Informacion", :only => :show do
    attributes_table_for candidate do
      row("Estatus") {candidate.first_name}
      row("Creado") {candidate.created_at}
      row("Actualizado") {candidate.updated_at}
    end
  end
     
  form do |f|
    f.inputs "Nuevo Candidato" do
      f.input :admin_user, :label => "Proveedor" if current_admin_user.isAdmin
      f.input :status, :collection => Candidate.status_collection, :as => :select, :label => "Estatus" if current_admin_user.isAdmin
      f.input :admin_user_id, :as => :hidden, :value => current_admin_user.id unless current_admin_user.isAdmin
      f.input :status, :as => :hidden, :value => Candidate::STATUS_NEW unless current_admin_user.isAdmin
      f.input :first_name, :label => "Nombre"
      f.input :last_name, :label => "Apellido Paterno"
      f.input :mother_name, :label => "Apellido Materno"
      f.input :rfc, :label => "RFC"
    end
    f.buttons
  end
      
end
