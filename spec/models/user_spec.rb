require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it { should have_many(:registered_applications) }

  describe "attributes" do
    it "has email and password attributes" do
      expect(user).to have_attributes(email: user.email, password: user.password)
    end
  end
end
