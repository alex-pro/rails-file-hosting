class Item < ActiveRecord::Base
  update_index 'items#item', :self

  mount_uploader :file, FileUploader
  validates :file, presence: true
  belongs_to :user
  belongs_to :folder
  before_create :generate_token, :set_name

  def image?
    check_file('image')
  end

  def audio?
    check_file('audio')
  end

  def video?
    check_file('video') || check_file('application')
  end

  private

  def check_file(type)
    file.content_type.include?(type)
  end

  def generate_token
    self.token = SecureRandom.urlsafe_base64(64, true)
  end

  def set_name
    self.name = File.basename self.file.path
  end
end
