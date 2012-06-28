class CreatePartners < ActiveRecord::Migration
  def change
    create_table :partners do |t|
      t.string :name
      t.integer :collaborator_id

      t.timestamps
    end
    add_index :partners, [:collaborator_id]
  end
end
