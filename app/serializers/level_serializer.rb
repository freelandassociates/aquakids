class LevelSerializer < ActiveModel::Serializer
  # attributes :id, :name
  attribute :id, :key => :level_id
  attribute :name, :key => :level_name
end
