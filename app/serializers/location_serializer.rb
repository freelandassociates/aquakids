class LocationSerializer < ActiveModel::Serializer
  # attributes :id
  attribute :id, :key => :location_id
  attribute :name, :key => :location_name
end
