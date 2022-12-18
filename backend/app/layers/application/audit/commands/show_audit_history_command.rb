module Application
  module Audit
    module Commands
      class ShowAuditHistoryCommand
        attr_accessor :auditable_id, :auditable_type

        def initialize(auditable_id:, auditable_type:)
          @auditable_id = auditable_id
          @auditable_type = auditable_type
        end
      end
    end
  end
end
