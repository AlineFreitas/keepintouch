class AddAdminToCollaborators < ActiveRecord::Migration
  def change
    add_column :collaborators, :admin, :boolean, default: false
  end
end
