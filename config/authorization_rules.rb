authorization do

# 1. Corporate Security – Access to all applications and all locations
# 2. Manager Security – Access to all applications and reports for their location ONLY
# 3. Office Security – Access to change classes for their location ONLY.  No access to manager financial reports.
# 4. Trainee Security – Access to enroll students, take payments for classes/retail, and navigate the system for their location ONLY.  No ability to edit classes

	role :Corporate do
		# has_permission_on :users, :to => [:index, :show, :new, :create, :edit, :update, :destroy]		
		has_permission_on :teachers, :to => [:index, :show, :new, :create, :edit, :update, :destroy]		
	end

	role :Manager do
		has_permission_on :teachers, :to => [:index, :show, :new, :create, :edit, :update, :destroy]	
	end

	role :Office do
		has_permission_on :teachers, :to => [:index, :show, :new, :create, :edit, :update, :destroy]	
	end

	role :Trainee do
		has_permission_on :teachers, :to => [:index]	
	end

	role :Parent do
		# has_permission_on :teachers, :to => [:index, :show]	
	end

	role :guest do
		# has_permission_on :users, :to => [:index, :show]	
	end

end