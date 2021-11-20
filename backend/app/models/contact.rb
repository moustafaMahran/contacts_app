# frozen_string_literal: true

class Contact < ApplicationRecord
  audited
  # Validations
  validates_presence_of :first_name, :last_name, :email, :phone_number
  validates_uniqueness_of :email
  # Scopes
  scope :ordered, -> { order('created_at ASC') }

  def seletced_audits
    audits.select(:action, :audited_changes, :created_at)
  end
end
