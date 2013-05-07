class TeacherSerializer < ActiveModel::Serializer
  # attributes :id
  attribute :id, :key => :teacher_id
  attribute :name, :key => :teacher_name

  def name
    object.first_name + ' ' + object.middle_name + ' ' + object.last_name
  end

end
