class DatepickerInput < SimpleForm::Inputs::Base

	def input

		@builder.text_field(attribute_name.to_s + "_user", input_html_options) + \

		# Switch the commenting on these lines to test
		@builder.hidden_field(attribute_name, { :class => attribute_name.to_s + "-alt"})
		# @builder.text_field(attribute_name, { :class => attribute_name.to_s + "-alt"})

	end

end