class AddCapacities < ActiveRecord::Migration
  def change
  	Capacity.create :code => 'E', :name => 'Empty'
  	Capacity.create :code => 'P', :name => 'Part-full'
  	Capacity.create :code => 'F', :name => 'Full'
  end
end
