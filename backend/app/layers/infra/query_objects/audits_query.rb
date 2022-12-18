module Infra
  module QueryObjects
    class AuditsQuery < Domain::Audit::Audit
      class << self
        def edit_history(auditable_params)
          if auditable_params[:auditable_type] == 'Contact'
            self
            .contacts
            .where(auditable_id: auditable_params[:auditable_id])
          end
        end
      end
    end
  end
end

