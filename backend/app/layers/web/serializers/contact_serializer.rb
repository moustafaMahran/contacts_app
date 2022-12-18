module Web
  module Serializers
    class ContactSerializer < ActiveModel::Serializer
      attributes :id, :first_name, :last_name, :phone_number, :email
    end
  end
end
