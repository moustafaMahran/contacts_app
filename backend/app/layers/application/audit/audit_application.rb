module Application
  module Audit
    class AuditApplication
      def show_edit_history(show_audit_history_command)
        Infra::QueryObjects::AuditsQuery.edit_history({
          auditable_id: show_audit_history_command.auditable_id,
          auditable_type: show_audit_history_command.auditable_type
        })
      end
    end
  end
end