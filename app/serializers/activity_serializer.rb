class ActivitySerializer < ActiveModel::Serializer
  # attributes :id
  attribute :id, :key => :activity_id
  attribute :name, :key => :activity_name
end
