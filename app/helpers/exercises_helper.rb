module ExercisesHelper
  def randomize_label_color
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
end
