module ApplicationHelper
  def facebook?
    !!session["facebook_data"]
  end
end
