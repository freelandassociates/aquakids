module ApplicationHelper

def javascript(*files)
  content_for(:head) { javascript_include_tag(*files) }
end

# def reload_flash
# 	page.replace "flash-messages", :partial => 'layouts/flashmessages'
# end

# def format_time(time, timezone)
# 	time.in_time_zone("US/Central")
# end

end
