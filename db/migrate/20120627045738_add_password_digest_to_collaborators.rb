class AddPasswordDigestToCollaborators < ActiveRecord::Migration
  def change
    add_column :collaborators, :password_digest, :string
  end
end
