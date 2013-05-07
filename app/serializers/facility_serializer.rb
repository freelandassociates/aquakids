class FacilitySerializer < ActiveModel::Serializer
  # attributes :id
  attribute :id, :key => :facility_id
  attribute :name, :key => :facility_name
end
