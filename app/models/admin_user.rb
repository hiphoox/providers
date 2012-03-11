class AdminUser < ActiveRecord::Base
  has_many :candidates
  validates :name, :presence => { :with => true, :message => "El nombre no puede estar en blanco"}
  validates :contact_name, :presence => { :with => true, :message => "Se debe especificar un contacto"}

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :contact_name, :phone_number

  after_create { |admin| admin.send_reset_password_instructions }

  def password_required?
    new_record? ? false : super
  end
end
