# frozen_string_literal: true

class ContactsController < ApplicationController
  before_action :set_contact, only: %i(show update destroy show_edit_history)

  def index
    paginated_params = pagination_params(params)
    contacts = Contact.ordered.limit(paginated_params[:page_size]).offset(paginated_params[:offset])
    render json: contacts, status: :ok, each_serializer: ContactSerializer
  end

  def show
    render json: @contact, status: :ok, serializer: ContactSerializer
  end

  def create
    @contact = Contact.new(permitted_params)
    if @contact.save
      render json: @contact, status: :ok, serializer: ContactSerializer
    else
      render json: @contact.errors, status: :bad_request
    end
  end

  def update
    @contact.update_attributes(permitted_params)
    if @contact.errors.empty?
      render json: @contact, status: :ok, serializer: ContactSerializer
    else
      render json: @contact.errors, status: :bad_request
    end
  end

  def destroy
    @contact.destroy
    if @contact.errors.empty?
      render json: @contact, status: :ok, serializer: ContactSerializer
    else
      render json: @contact.errors, status: :bad_request
    end
  end

  def show_edit_history
    paginated_params = pagination_params(params)
    @audits = @contact.audits.limit(paginated_params[:page_size]).offset(paginated_params[:offset])
    render json: @audits, status: :ok, each_serializer: ContactAuditsSerializer
  end

  private

  def set_contact
    contact_id = params[:id] || params[:contact_id]
    @contact = Contact.find(contact_id)
    return render json: { error: "contact with id #{contact_id} does not exist" }, status: 403 unless @contact.present?
  end

  def permitted_params
    params.permit(%i(first_name last_name email phone_number))
  end
end
