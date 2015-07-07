FactoryGirl.define do
  factory :item do
    user
    name 'Image'
    file { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures', 'audio.png')) }
  end

end
