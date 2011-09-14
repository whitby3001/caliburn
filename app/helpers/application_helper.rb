module ApplicationHelper
  # Return a title on a per-page basis.
  def title
    base_title = "Caliburn Entertainment"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
  def category_breadcrumb(category)
    unless category.nil?
      links = []
      category.self_and_ancestors.each do |cat|
        links << link_to(cat.name.titleize, shop_path(:category => cat.id))
      end
      return content_tag(:p, raw(links.join(" > ")))
    end
  end
end
