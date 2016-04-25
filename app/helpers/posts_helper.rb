module PostsHelper

	# Returns the full title on a per-page basis.
  def full_url(my_url = '')
    if !my_url.include?('http')
    	'http://' + my_url
    else
    	my_url
    end
  end

end
