module ApplicationHelper
  # Return a title on a per-page basis.
  def title
    base_title = "Caliburn Entertainment"
    if @full_title
      @full_title
    elsif @title.nil?
      base_title
    else
      "#{@title} - #{base_title}"
    end
  end
  
  # Return a description on a per-page basis.
  def meta_description
    @meta_description
  end
  
  def category_breadcrumb(category)
    unless category.nil?
      links = []
      category.self_and_ancestors.each do |cat|
        links << link_to(cat.capitalized_name, shop_path(:ancestors => cat.ancestors_for_route, :category => cat.dasherized_name))
      end
      return content_tag(:p, raw(links.join(" > ")))
    end
  end
end
