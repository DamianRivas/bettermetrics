require 'rails_helper'

RSpec.describe RegisteredApplication, type: :model do
  let(:user) { create(:user) }
  let(:app) { create(:registered_application, user: user) }

  it { should belong_to(:user) }
  it { should have_many(:events) }

  it { should validate_presence_of(:name) }

  it { should validate_presence_of(:url) }
  it { should validate_length_of(:url).is_at_least(3) }
  it { should validate_uniqueness_of(:url) }

  describe "attributes" do
    it "contains name, URL, and user_id attributes" do
      expect(app).to have_attributes(name: app.name, url: app.url, user_id: user.id)
    end
  end
end
