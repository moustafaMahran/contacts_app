module Infra
  module Repositories
    class ContactRepository < Domain::Contact::ContactRepository
      def initialize(model = {})
        @contact = model.fetch(:contact) { Domain::Contact::Contact }
      end

      def save(contact)
        contact.save!
      end

      def delete(contact)
        contact.destroy!
      end
    end
  end
end

