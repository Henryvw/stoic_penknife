# frozen_string_literal: true

json.extract! @exercise,
              :id,
              :title,
              :general_description,
              :text_question,
              :category,
              :created_at,
              :updated_at
