ActiveAdmin.register AdminUser, :as => "Proveedor" do
  index do
    column "Nombre", :name
    column "Nombre de Contacto", :contact_name
    column "Correo Electronico", :email
    column "Telefono", :phone_number
    column "Es Administrador", :isAdmin do |adminUser|
      adminUser.isAdmin ? "Si" : "No"
    end
    default_actions
  end 

  # Filters
  filter :name, :label => "Nombre"
  filter :contact_name, :label => "Contacto"
  filter :email, :label => "Correo electronico"

  form do |f|
    f.inputs "Detalles del Proveedor" do
      f.input :name, :label => "Nombre"
      f.input :contact_name, :label => "Contacto"
      f.input :email, :label => "Correo electronico"
      f.input :phone_number, :label => "Telefono"
      f.input :isAdmin, :label => "Administrador?"
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
