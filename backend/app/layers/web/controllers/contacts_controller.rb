    # frozen_string_literal: true
module Web
  module Controllers
    class ContactsController < ApplicationController
      before_action :set_contact_id, only: %i(show update destroy show_edit_history)

      def index
        contacts = Application::Contact::ContactApplication.new.fetch_contacts_with_pagination(pagination_params(params))
        render json: contacts, status: :ok, each_serializer: Serializers::ContactSerializer
      end

      def show
        contact_id = params[:id] || params[:contact_id]
        contact = Application::Contact::ContactApplication.new.find_contact_by_id(contact_id)
        render json: contact, status: :ok, serializer: Serializers::ContactSerializer
      end

      def create
        command = Application::Contact::Commands::AddContactCommand.new(
          first_name: permitted_params[:first_name],
          last_name: permitted_params[:last_name],
          email: permitted_params[:email],
          phone_number: permitted_params[:phone_number]
        )
        contact = Application::Contact::ContactApplication.new.add_contact(command)
        render json: contact, status: :ok, serializer: Serializers::ContactSerializer
        # @contact = Contact.new(permitted_params)
        # if @contact.save
        #   render json: @contact, status: :ok, serializer: Serializers::ContactSerializer
        # else
        #   render json: @contact.errors, status: :bad_request
        # end
      end

      def update
        command = Application::Contact::Commands::EditContactCommand.new(
          id: @contact_id,
          first_name: permitted_params[:first_name],
          last_name: permitted_params[:last_name],
          email: permitted_params[:email],
          phone_number: permitted_params[:phone_number]
        )
        contact = Application::Contact::ContactApplication.new.edit_contact(command)
        render json: contact, status: :ok, serializer: Serializers::ContactSerializer
        # @contact.update_attributes(permitted_params)
        # if @contact.errors.empty?
        #   render json: @contact, status: :ok, serializer: ContactSerializer
        # else
        #   render json: @contact.errors, status: :bad_request
        # end
      end

      def destroy
        command = Application::Contact::Commands::DeleteContactCommand.new(
          id: @contact_id
        )
        contact = Application::Contact::ContactApplication.new.delete_contact(command)
        render json: contact, status: :ok, serializer: Serializers::ContactSerializer
        # @contact.destroy
        # if @contact.errors.empty?
        #   render json: @contact, status: :ok, serializer: ContactSerializer
        # else
        #   render json: @contact.errors, status: :bad_request
        # end
      end

      private

      def set_contact_id
        @contact_id = params[:id] || params[:contact_id]
        render json: { error: "contact id is required" }, status: 403 unless @contact_id
      end

      def permitted_params
        params.permit(%i(first_name last_name email phone_number))
      end
    end
  end
end
