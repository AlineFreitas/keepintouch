# == Schema Information
#
# Table name: partners
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  collaborator_id :integer
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#

class Partner < ActiveRecord::Base
  attr_accessible :name

  belongs_to :collaborator

  validates :collaborator_id, presence: true
  validates :name, presence: true

  default_scope order: 'partners.name ASC'
end
