# frozen_string_literal: true

json.array!(@exercises) do |exercise|
  json.extract! exercise, :id, :title, :general_description, :text_question, :category
  json.url exercise_url(exercise, format: :json)
end
