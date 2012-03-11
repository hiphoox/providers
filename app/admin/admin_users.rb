ActiveAdmin.register AdminUser, :as => "Proveedor" do
  index do
    column "Nombre", :name
    column "Nombre de Contacto", :contact_name
    column "Correo Electronico", :email
    column "Telefono", :phone_number
    default_actions
  end 

  # Filters
  filter :name 
  filter :contact_name
  filter :email

  form do |f|
    f.inputs "Detalles del Proveedor" do
      f.input :name
      f.input :contact_name
      f.input :email
      f.input :phone_number
    end
    f.buttons
  end

  show "Candidatos" => :name do
    panel "Candidatos" do
      table_for proveedor.candidates do |c| 
        c.column("Nombre") { |candidate| link_to candidate.first_name, admin_candidato_path(candidate) }
      end
    end
  end
  
end