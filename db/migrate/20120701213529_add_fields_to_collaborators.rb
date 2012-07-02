class AddFieldsToCollaborators < ActiveRecord::Migration
  def change
    add_column :collaborators, :street, :string
    add_column :collaborators, :number, :string
    add_column :collaborators, :hood, :string
    add_column :collaborators, :cep, :string
    add_column :collaborators, :gender, :string
    add_column :collaborators, :brithdate, :date
    add_column :collaborators, :fone1, :string
    add_column :collaborators, :fone2, :string
  end
end
