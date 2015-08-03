FactoryGirl.define do
  factory :profile do
    user
    name "My name"
    photo { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures', 'image.jpeg')) }
    birthday "23/03/1989"
  end
end
