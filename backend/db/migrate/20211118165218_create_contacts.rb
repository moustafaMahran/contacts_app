# frozen_string_literal: true

# migration to create contacts table
class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :phone_number, null: false

      t.timestamps
    end

    add_index :contacts, %i(first_name last_name), name: 'index_contacts_on_names'
    add_index :contacts, :email, name: 'index_contacts_on_email'
    add_index :contacts, :phone_number, name: 'index_contacts_on_phone_number'
  end
end
