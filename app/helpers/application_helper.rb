module ApplicationHelper
  # Return a title on a pre-page basis.
  def title
    base_title = "Weblog"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
  def logo 
    image_tag('logo.png', :alt => "Weblog Header Image", :height => "100px", :width => "100px", :border => "0px", :class=> "round")
  end
end
