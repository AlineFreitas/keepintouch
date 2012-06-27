class AddRememberTokenToCollaborators < ActiveRecord::Migration
  def change
    add_column :collaborators, :remember_token, :string
    add_index  :collaborators, :remember_token
  end
end
