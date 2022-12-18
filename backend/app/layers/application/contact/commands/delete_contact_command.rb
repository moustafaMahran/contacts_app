module Application
  module Contact
    module Commands
      class DeleteContactCommand
        attr_accessor :id

        def initialize(id:)
          @id = id
        end
      end
    end
  end
end
