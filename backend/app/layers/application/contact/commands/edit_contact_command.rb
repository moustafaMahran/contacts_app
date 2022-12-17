module Application
  module Contact
    module Commands
      class EditContactCommand
        attr_accessor :id, :first_name, :last_name, :email, :phone_number

        def initialize(id:, first_name:, last_name:, email:, phone_number:)
          @id = id
          @first_name = first_name
          @last_name = last_name
          @email = email
          @phone_number = phone_number
        end
      end
    end
  end
end
