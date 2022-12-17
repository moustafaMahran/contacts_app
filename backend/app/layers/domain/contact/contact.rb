# frozen_string_literal: true
module Domain
  module Contact
    class Contact < Infra::Models::ApplicationRecord
      audited
      # Validations
      validates_presence_of :first_name, :last_name, :email, :phone_number
      validates_uniqueness_of :email
      # Scopes
      scope :ordered, -> { order('created_at ASC') }

      def edit(new_contact)
        self.first_name = new_contact[:first_name]
        self.last_name = new_contact[:last_name]
        self.email = new_contact[:email]
        self.phone_number =new_contact[:phone_number]
      end
    end
  end
end
