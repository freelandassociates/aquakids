class CreateRoles < ActiveRecord::Migration
  def up
    create_table :roles do |t|
      t.string :role
     
      t.timestamps
    end

    Role.create([
    	{ role: 'Corporate' }, 
    	{ role: 'Manager' }, 
    	{ role: 'Office' }, 
    	{ role: 'Trainee' }, 
    	{ role: 'Parent' }
    ])

  end

  def down
  	drop_table :roles
  end

end
