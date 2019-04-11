# frozen_string_literal: true

json.array!(@rehearsals) do |rehearsal|
  json.extract! rehearsal, :id, :tally
  json.url rehearsal_url(rehearsal, format: :json)
end
