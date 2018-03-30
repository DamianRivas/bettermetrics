require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:user) { create(:user) }
  let(:app) { create(:registered_application, user: user) }
  let(:event) { create(:event, registered_application: app) }

  it { should belong_to(:registered_application) }

  describe "attributes" do
    it "should have name and registered_application_id attributes" do
      expect(event).to have_attributes(name: event.name, registered_application_id: app.id)
    end
  end
end
