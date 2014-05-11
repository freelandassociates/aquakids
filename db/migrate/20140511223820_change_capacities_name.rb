class ChangeCapacitiesName < ActiveRecord::Migration
  def change
  	Capacity.delete_all

  	Capacity.create :code => 'E', :name => 'Empty'
  	Capacity.create :code => 'P', :name => 'Not-full'
  	Capacity.create :code => 'F', :name => 'Full'
  end

end
