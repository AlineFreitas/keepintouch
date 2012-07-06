# == Schema Information
#
# Table name: partners
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  collaborator_id :integer
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  brith_date      :date
#  email           :string(255)
#  street          :string(255)
#  number          :string(255)
#  hood            :string(255)
#  cep             :string(255)
#  gender          :string(255)
#  birth_date      :date
#  fone1           :string(255)
#  fone2           :string(255)
#

class Partner < ActiveRecord::Base
  attr_accessible :name, :email, :street, :number, :hood, :cep, :gender,
                  :birth_date, :fone1, :fone2

  belongs_to :collaborator

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/
  VALID_OCIDENTAL_DATE_REGEX = /(0[1-9]|[12][0-9]|3[01])\/(0[1-9]|1[012])\/[12][0-9]{3}$/

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, format: { with: VALID_EMAIL_REGEX }
  validates :birth_date, presence: true,
            :format => { :with => VALID_OCIDENTAL_DATE_REGEX }
  validates :collaborator_id, presence: true
  validates :street, presence: true
  validates :number, presence: true
  validates :hood, presence: true
  validates :cep, presence: true, format: { with: /(\d\d\d\d\d\d\d\d)/}

  default_scope order: 'partners.name ASC'
end
