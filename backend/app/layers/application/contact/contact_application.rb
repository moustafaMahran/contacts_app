module Application
  module Contact
    class ContactApplication
      def initialize(repositories = {})
        @contact_repository = repositories.fetch(:contact) { Infra::Repositories::ContactRepository.new }
      end

      def add_contact(add_contact_command)
        contact = Domain::Contact::Contact.new(
          first_name: add_contact_command.first_name,
          last_name: add_contact_command.last_name,
          email: add_contact_command.email,
          phone_number: add_contact_command.phone_number
        )
        ActiveRecord::Base.transaction do
          @contact_repository.save(contact)
        end
        contact
      end

      def edit_contact(edit_contact_command)
        contact = find_contact_by_id(edit_contact_command.id)
        contact.edit({
          first_name: edit_contact_command.first_name,
          last_name: edit_contact_command.last_name,
          email: edit_contact_command.email,
          phone_number: edit_contact_command.phone_number
        })
        ActiveRecord::Base.transaction do
          @contact_repository.save(contact)
        end
        contact
      end

      def delete_contact(delete_contact_command)
        contact = find_contact_by_id(delete_contact_command.id)
        ActiveRecord::Base.transaction do
          @contact_repository.delete(contact)
        end
      end

      def fetch_contacts_with_pagination(paginated_params)
        Infra::QueryObjects::ContactsQuery.contacts_with_pagination(paginated_params)
      end

      def find_contact_by_id(id)
        Infra::QueryObjects::ContactsQuery.contact_by_id(id)
      end
    end
  end
end