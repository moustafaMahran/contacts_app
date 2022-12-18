# frozen_string_literal: true
module Web
  module Controllers
    class AuditsController < ApplicationController
      def show
        command = Application::Audit::Commands::ShowAuditHistoryCommand.new(
          auditable_id: permitted_params[:id],
          auditable_type: permitted_params[:auditable_type]
        )
        audits = Application::Audit::AuditApplication.new.show_edit_history(command)
        render json: audits, status: :ok, each_serializer: Serializers::AuditSerializer
      end

      private

      def permitted_params
        params.permit(:auditable_type, :id)
      end
    end
  end
end
