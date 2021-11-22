# frozen_string_literal: true

class AuditsController < ApplicationController
  def index
    return render_missing_params unless permitted_params[:auditable_type]

    paginated_params = pagination_params(params)
    @audits = Audit.where(auditable_type: permitted_params[:auditable_type]).limit(paginated_params[:page_size]).offset(paginated_params[:offset])
    render json: @audits, status: :ok
  end

  def show
    return render_missing_params unless permitted_params[:auditable_type] && permitted_params[:id]

    paginated_params = pagination_params(params)
    @audits = Audit.where(auditable_type: permitted_params[:auditable_type],
                          auditable_id: permitted_params[:id],).limit(paginated_params[:page_size]).offset(paginated_params[:offset])
    render json: @audits, status: :ok
  end

  private

  def permitted_params
    params.permit(:auditable_type, :id)
  end

  def render_missing_params
    render json: { error: 'missing required params' }, status: :bad_request
  end
end
