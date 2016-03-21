module ApplicationHelper

  # helper method to display errors in app.  See post partial (_form) for example
  def form_group_tag(errors, &block)
    css_class = 'form-group'
    css_class << ' has-error' if errors.any?

    content_tag :div, capture(&block), class: css_class
  end

end
