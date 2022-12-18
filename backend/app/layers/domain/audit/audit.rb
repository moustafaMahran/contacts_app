# frozen_string_literal: true
module Domain
  module Audit
    class Audit < Infra::Models::ApplicationRecord
      scope :contacts, -> { Audit.where(auditable_type: 'Domain::Contact::Contact') }
    end
  end
end