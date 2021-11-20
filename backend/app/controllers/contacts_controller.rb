# frozen_string_literal: true

class ContactsController < ApplicationController
  before_action :set_contact, only: %i(show update destroy contact_edit_history)

  def index
    paginated_params = pagination_params(params)
    contacts = Contact.ordered.limit(paginated_params[:page_size]).offset(paginated_params[:offset])
    render json: contacts, status: :ok
  end

  def show
    render json: @contact, status: :ok
  end

  def create
    @contact = Contact.new(permitted_params)
    if @contact.save
      render json: @contact, status: :ok
    else
      render json: @contact.errors, status: :bad_request
    end
  end

  def update
    @contact.update_attributes(permitted_params)
    if @contact.errors.empty?
      render json: @contact, status: :ok
    else
      render json: @contact.errors, status: :bad_request
    end
  end

  def destroy
    @contact.destroy
    if @contact.errors.empty?
      render json: @contact, status: :ok
    else
      render json: @contact.errors, status: :bad_request
    end
  end

  def contact_edit_history
    paginated_params = pagination_params(params)
    audits = @contact.seletced_audits.limit(paginated_params[:page_size]).offset(paginated_params[:offset])
    render json: audits, status: :ok
  end

  private

  def set_contact
    contact_id = params[:id] || params[:contact_id]
    @contact = Contact.find(contact_id)
    return render json: { error: "contact with id #{contact_id} does not exist" }, status: 403 unless @contact.present?
  end

  def pagination_params(params)
    default_page_size = 10
    default_page_number = 1
    params[:page_size] = default_page_size if params[:page_size].nil?
    params[:page_number] = default_page_number if params[:page_number].nil?
    params[:offset] = (params[:page_size] * params[:page_number]) - params[:page_size]
    params
  end

  def permitted_params
    params.permit(%i(first_name last_name email phone_number))
  end
end
