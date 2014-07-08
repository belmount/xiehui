json.array!(@students) do |student|
  json.extract! student, :id, :name, :tel, :gender, :education, :company_name, :company_code, :id_code, :district, :school, :school_cert
  json.url student_url(student, format: :json)
end
