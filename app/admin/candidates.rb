ActiveAdmin.register Candidate, :as => "Candidato" do
  menu :label => "Candidatos" #,:if => proc{ current_admin_user.isAdmin }
  form :partial => "form"

  index do
    column "Nombre", :first_name do |candidato|
      link_to candidato.first_name, admin_candidato_path(candidato)
    end
    column "Apellido Paterno", :last_name
    column "Apellido Materno", :mother_name
    column "RFC", :rfc
    column "Proveedor", :admin_user if current_admin_user.isAdmin
    #column "Estatus", :status
    
    default_actions
  end

  controller do
    def scoped_collection
      if current_admin_user.isAdmin then
        end_of_association_chain
      else
        current_admin_user.candidatos
      end
    end
  end

  # Filter only by name
  filter :first_name, :label => "Nombre"
  filter :last_name, :label => "Apellido Paterno"
  filter :rfc, :label => "RFC"
  filter :technology, :label => "Tecnologia"
  filter :admin_user, :label => "Proveedor", :collection => proc { if current_admin_user.isAdmin then AdminUser.all else {} end }

  scope :all, :default => true
  scope :propuesto do |candidatos|
    candidatos.where(:status => Candidate::STATUS_NEW)
  end

  scope :aceptado do |candidatos|
    candidatos.where(:status => Candidate::STATUS_ACCEPTED)
  end

  scope :rechazado do |candidatos|
    candidatos.where(:status => Candidate::STATUS_REJECTED)
  end

  # View page
  show do
    panel "Informacion General" do
      attributes_table_for candidato do
        row("Nombre") {candidato.first_name}
        row("Apellido Paterno") {candidato.last_name}
        row("Apellido Materno") {candidato.mother_name}
        row("RFC") {candidato.rfc}
        row("Correo electronico") {candidato.email}
        row("Telefono") {candidato.phone_number}
        row("Tecnologia") {candidato.technology}
      end
    end
    active_admin_comments
  end
  
  sidebar "Otra Informacion", :only => :show do
    attributes_table_for candidato do
      row("Estatus") {candidato.status}
      row("Creado") {candidato.created_at}
      row("Actualizado") {candidato.updated_at}
      row("Proveedor") {candidato.admin_user}
    end
  end
     
  # New or Edit page
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
      f.input :email, :label => "Correo Electronico"
      f.input :phone_number, :label => "Telefono"
      f.input :technology, :label => "Tecnologia"      
    end
      f.buttons
  end
      
end
