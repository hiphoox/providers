ActiveAdmin.register Candidate, :as => "Candidato" do
  index do
    column "Nombre", :first_name do |candidate|
      link_to candidate.first_name, admin_candidato_path(candidate)
    end
    column "Apellido Paterno", :last_name
    column "Apellido Materno", :mother_name
    column "RFC", :rfc
    column "Proveedor", :admin_user if current_admin_user.isAdmin
    column "Estatus", :status
    
    default_actions
  end

  # Filter only by name
  filter :first_name, :label => "Nombre"
  filter :last_name, :label => "Apellido Paterno"
  filter :rfc, :label => "RFC"
  filter :admin_user, :label => "Proveedor"

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
      attributes_table_for candidato do
        row("Nombre") {candidato.first_name}
        row("Apellido Paterno") {candidato.last_name}
        row("Apellido Materno") {candidato.mother_name}
        row("RFC") {candidato.rfc}
        row("Estatus") {candidato.status}
      end
    end
    active_admin_comments
  end
  
  sidebar "Otra Informacion", :only => :show do
    attributes_table_for candidato do
      row("Estatus") {candidato.first_name}
      row("Creado") {candidato.created_at}
      row("Actualizado") {candidato.updated_at}
    end
  end
     
  form do |f|
    f.inputs "Nuevo Candidato" do
      f.input :admin_user, :label => "Proveedor" if current_admin_user.isAdmin
      f.input :first_name, :label => "Nombre"
      f.input :last_name, :label => "Apellido Paterno"
      f.input :mother_name, :label => "Apellido Materno"
      f.input :rfc, :label => "RFC"
      f.input :status, :collection => Candidate.status_collection, :as => :select, :label => "Estatus"
    end
    f.buttons
  end
      
end
