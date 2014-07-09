json.array!(@courses) do |course|
  json.extract! course, :id, :nth, :open_at, :end_at
  json.url course_url(course, format: :json)
end
