class Item < ActiveRecord::Base
  mount_uploader :file, FileUploader
  belongs_to :user
  belongs_to :folder

  before_create :generate_token, :set_name

  private

  def generate_token
    self.token = SecureRandom.urlsafe_base64(64, true)
  end

  def set_name
    self.name = File.basename self.file.path
  end
end
