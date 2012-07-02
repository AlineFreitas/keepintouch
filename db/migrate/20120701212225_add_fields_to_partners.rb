class AddFieldsToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :email, :string
    add_column :partners, :street, :string
    add_column :partners, :number, :string
    add_column :partners, :hood, :string
    add_column :partners, :cep, :string
    add_column :partners, :gender, :string
    add_column :partners, :birth_date, :date
    add_column :partners, :fone1, :string
    add_column :partners, :fone2, :string

    add_index :partners, :hood
    add_index :partners, :cep
    add_index :partners, :gender
  end
end
