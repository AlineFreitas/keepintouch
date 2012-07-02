class AddIndexToCollaboratorName < ActiveRecord::Migration
  def change
    add_index :collaborators, :name
  end
end
