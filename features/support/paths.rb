module NavigationHelpers
  def path_to(page_name)
    "http://localhost/chits" + 
    case page_name
    
    when /a page/
      '/'

    when /home page/
      '/'
    when /admin page/
      '/info/index.php?page=ADMIN'

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
