module Infra
  module QueryObjects
    class ContactsQuery < Domain::Contact::Contact
      class << self
        def contacts_with_pagination(paginated_params)
          self
          .ordered
          .limit(paginated_params[:page_size])
          .offset(paginated_params[:offset])
        end

        def contact_by_id(id)
          self.find_by(id: id)
        end

        def edit_history(id:, page_size:, offset:)
          self.find_by(id: id).audits.limit(:page_size).offset(:offset)
        end
      end
    end
  end
end

