module ApplicationHelper
  def nav_link(path)
    class_name = current_page?(path) ? 'active' : ''
    haml_tag(:li, class: class_name) do
      yield
    end
  end
end
