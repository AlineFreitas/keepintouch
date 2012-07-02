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

  validates :collaborator_id, presence: true
  validates :name, presence: true

  default_scope order: 'partners.name ASC'
end
