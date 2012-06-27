class AddIndexToCollaboratorsEmail < ActiveRecord::Migration
  def change
    add_index :collaborators, :email, unique: true
  end
end
