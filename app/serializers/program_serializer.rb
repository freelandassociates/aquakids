class ProgramSerializer < ActiveModel::Serializer
  # attributes :id
  attribute :id, :key => :program_id
  attribute :name, :key => :program_name
end
