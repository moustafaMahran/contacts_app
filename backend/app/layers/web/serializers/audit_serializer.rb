module Web
  module Serializers
    class AuditSerializer < ActiveModel::Serializer
      attributes :changes

      def changes
        { created_at: object.created_at.to_datetime, history: [object.audited_changes] }
      end
    end
  end
end
