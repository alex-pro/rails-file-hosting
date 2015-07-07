require 'rails_helper'

RSpec.describe Folder, type: :model do
  it { should validate_presence_of :name }
  it { should have_many(:children).with_foreign_key(:parent_id).dependent :destroy }
  it { should have_many(:items).dependent :destroy }
  it { should belong_to(:parent) }
  it { should belong_to(:user) }
end
