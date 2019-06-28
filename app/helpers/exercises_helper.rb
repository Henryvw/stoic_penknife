module ExercisesHelper
  def randomize_color_css
    color_list = [
      'primary',
      'danger',
      'info',
      'warning',
      'default',
      'success'
    ]
    color_list.sample
  end

  def randomize_diagonal_css
    diagonal_css_list = [
      'diagonal-up',
      'diagonal-down'
    ]

    diagonal_css_list.sample
  end
end
