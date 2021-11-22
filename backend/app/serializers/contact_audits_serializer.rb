class ContactAuditsSerializer < ActiveModel::Serializer
  attributes :changes

  def changes
    return create_action_changes if object.action == 'create'

    return update_action_changes if object.action == 'update'

    object.audited_changes
  end

  def create_action_changes
    create_changes = []
    object.audited_changes.each do |key, val|
      create_changes << "#{key} was created with the value #{val}"
    end
    {created_at: object.created_at.to_datetime, history: create_changes}
  end

  def update_action_changes
    update_changes = []
    object.audited_changes.each do |key, array|
      update_changes << "#{key} has changed from #{array.first} to #{array.last}"
    end
    {created_at: object.created_at.to_datetime, history: update_changes}
  end
end