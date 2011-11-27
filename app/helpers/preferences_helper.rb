module PreferencesHelper
  def label_output(field)
    content_tag :span, value_for(field), class: "label #{tag_class(field)}" 
  end

  private

  def tag_class(field)
    field == true ? 'success' : 'important'
  end

  def value_for(field)
    field == true ? 'Yes' : 'No'
  end
end
