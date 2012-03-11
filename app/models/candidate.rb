class Candidate < ActiveRecord::Base
  belongs_to :admin_user
  validates :rfc, :presence => { :with => true, :message => "El RFC no puede estar en blanco"}
  validates :rfc, :format => { :with => /^[a-zA-Z]{3,4}(\d{6})((\D|\d){3})?$/, :message => "RFC invalido"} 
  validates :rfc, :uniqueness => { :with => true, :case_sensitive => false, :message => "Candidato ya existe"} 
  validates :first_name, :presence => { :with => true, :message => "El nombre no puede estar en blanco"}
  validates :last_name, :presence => { :with => true, :message => "El apellido paterno no puede estar en blanco"}
  validates :mother_name, :presence => { :with => true, :message => "El apellido materno no puede estar en blanco"}
  validates :admin_user, :presence => { :with => true, :message => "Se debe asignar a un proveedor"}
end
