# encoding: utf-8
ActiveAdmin.register AdminUser, :as => "Proveedor" do
  menu :label => "Proveedores",:if => proc{ current_admin_user.isAdmin }

  index do
    column "Nombre", :name
    column "Nombre de Contacto", :contact_name
    column "Correo Electrónico", :email
    column "Teléfono", :phone_number
    column "Es Administrador", :isAdmin do |adminUser|
      adminUser.isAdmin ? "Si" : "No"
    end
    default_actions
  end 

  # Filters
  filter :name, :label => "Nombre"
  filter :contact_name, :label => "Contacto"
  filter :email, :label => "Correo electronico"

  show :name => :name do
    panel "Informacion General" do
      attributes_table_for proveedor do
        row("Email") {proveedor.email}
        row("Nombre") {proveedor.name}
        row("Nombre de Contacto") {proveedor.contact_name}
        row("Teléfono") {proveedor.phone_number}
        row("Administrador") {proveedor.isAdmin ? "Si" : "No"}
      end
    end
    active_admin_comments
  end

  form do |f|
    f.inputs "Detalles del Proveedor" do
      f.input :name, :label => "Nombre"
      f.input :contact_name, :label => "Contacto"
      f.input :email, :label => "Correo electrónico"
      f.input :phone_number, :label => "Teléfono"
      f.input :isAdmin, :label => "Administrador?"
    end
    f.buttons
  end

end
