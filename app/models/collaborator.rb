# == Schema Information
#
# Table name: collaborators
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  password_digest :string(255)
#  remember_token  :string(255)
#  admin           :boolean         default(FALSE)
#  street          :string(255)
#  number          :string(255)
#  hood            :string(255)
#  cep             :string(255)
#  gender          :string(255)
#  brithdate       :date
#  fone1           :string(255)
#  fone2           :string(255)
#

class Collaborator < ActiveRecord::Base
  attr_accessible :email, :name, :street, :number, :hood, :birth_date, :gender,
                  :cep, :fone1, :fone2, :password, :password_confirmation

  has_many :partners, dependent: :destroy

  has_secure_password

  before_save { |collaborator| collaborator.email = email.downcase }
  before_save :create_remember_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true


  def feed
    Partner.where("collaborator_id = ?", id)
  end


  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
