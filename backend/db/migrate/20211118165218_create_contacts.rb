# frozen_string_literal: true

# migration to create contacts table
class CreateContacts < ActiveRecord::Migration[5.0]
  def change
    create_table :contacts do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false, index: { unique: true }
      t.string :phone_number, null: false

      t.timestamps
    end

    add_index :contacts, [:first_name, :last_name], :name => 'contact_name_index'
    add_index :contacts, :email, :name => 'contact_email_index'
    add_index :contacts, :phone_number, :name => 'contact_phone_number_index'

  end
end
