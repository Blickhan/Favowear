module PostsHelper

	# Returns the full title on a per-page basis.
  def full_url(my_url = '')
    if !my_url.include?('http')
    	'https://' + my_url
    elsif !my_url.include?('https') && my_url.include?('http')
    	my_url.sub('http','https')
    else
    	my_url
    end
  end

end
