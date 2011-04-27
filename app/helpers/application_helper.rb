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
end
