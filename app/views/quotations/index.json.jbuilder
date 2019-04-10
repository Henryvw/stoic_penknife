# frozen_string_literal: true

json.array!(@quotations) do |quotation|
  json.extract! quotation, :id, :title, :passage
  json.url quotation_url(quotation, format: :json)
end
