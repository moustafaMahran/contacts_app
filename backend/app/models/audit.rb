# frozen_string_literal: true

class Audit < ApplicationRecord
  scope :contacts, -> { Audit.where(auditable_type: 'Contact') }
end
