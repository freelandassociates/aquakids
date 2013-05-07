class ZoneSerializer < ActiveModel::Serializer
  # attributes :id
  attribute :id, :key => :zone_id
  attribute :name, :key => :zone_name
end
