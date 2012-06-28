class AddIndexToCollaboratorName < ActiveRecord::Migration
  def change
  end
  add_index :collaborators, :name
end
