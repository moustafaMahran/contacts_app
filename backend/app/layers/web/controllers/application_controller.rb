# frozen_string_literal: true

module Web
  module Controllers
    class ApplicationController < ActionController::API
      private

      def pagination_params(params)
        default_page_size = 10
        default_page_number = 1
        params[:page_size] = default_page_size if params[:page_size].nil?
        params[:page_number] = default_page_number if params[:page_number].nil?
        params[:page_size] = params[:page_size].to_i
        params[:page_number] = params[:page_number].to_i
        params[:offset] = (params[:page_size] * params[:page_number]) - params[:page_size]
        params
      end
    end
  end
end
