class Candidate < ActiveRecord::Base
  belongs_to :admin_user
  validates :rfc, :presence => { :with => true, :message => "El RFC no puede estar en blanco"}
  validates :rfc, :format => { :with => /^[a-zA-Z]{3,4}(\d{6})((\D|\d){3})?$/, :message => "RFC invalido"} 
  validates :rfc, :uniqueness => { :with => true, :case_sensitive => false, :message => "Candidato ya existe"} 
  validates :first_name, :presence => { :with => true, :message => "El nombre no puede estar en blanco"}
  validates :last_name, :presence => { :with => true, :message => "El apellido paterno no puede estar en blanco"}
  #validates :mother_name, :presence => { :with => true, :message => "El apellido materno no puede estar en blanco"}
  validates :admin_user, :presence => { :with => true, :message => "Se debe asignar a un proveedor"}

  validates :email, :presence => { :with => true, :message => "Se debe capturar un correo electronico"}
  validates :phone_number, :presence => { :with => true, :message => "Se debe capturar un telefono"}
  validates :technology, :presence => { :with => true, :message => "Se debe capturar una tecnologia"}

  STATUS_NEW = 'nuevo'
  STATUS_ACCEPTED  = 'aceptado'
  STATUS_REJECTED  = 'rechazado'

  def before_validation_on_create
    self.status = Candidate::STATUS_NEW unless attribute_present?("status")
  end
  
  def self.status_collection
    {
      "Nuevo" => STATUS_NEW,
      "Aceptado" => STATUS_ACCEPTED,
      "Rechazado" => STATUS_REJECTED
    }
  end
  
end
