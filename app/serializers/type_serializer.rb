class TypeSerializer < ActiveModel::Serializer
  # attributes :id
  attribute :id, :key => :type_id
  attribute :name, :key => :type_name
end
