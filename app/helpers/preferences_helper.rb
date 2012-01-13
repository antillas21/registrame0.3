module PreferencesHelper
  def label_output(field)
    content_tag :span, value_for(field), class: "label #{tag_class(field)}" 
  end

  private

  def tag_class(field)
    if field == true || field.present?
      'success'
    else
      'important'
    end
  end

  def value_for(field)
    if field == true || field.present?
      'Yes'
    else
      'No'
    end
  end

end
