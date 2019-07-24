module ExercisesHelper
  def randomize_color_css
    color_list = %w[
      primary
      danger
      info
      warning
      success
    ]
    color_list.sample
  end

  def randomize_diagonal_css
    diagonal_css_list = %w[
      diagonal-up
      diagonal-down
    ]

    diagonal_css_list.sample
  end
end
