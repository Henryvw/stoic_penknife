module ExercisesHelper
  def randomize_label_color_css
    label_color_list = [
      'label-primary',
      'label-danger',
      'label-info',
      'label-warning',
      'label-default',
      'label-success'
    ]
    label_color_list.sample
  end

  def randomize_diagonal_css
    diagonal_css_list = [
      'diagonal-up',
      'diagonal-down'
    ]

    diagonal_css_list.sample
  end
end
