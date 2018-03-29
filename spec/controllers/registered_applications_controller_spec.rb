require 'rails_helper'
require 'faker'

RSpec.describe RegisteredApplicationsController, type: :controller do
  let(:user) { create(:user) }
  let(:app) { create(:registered_application, user: user) }
  let(:other_user) { create(:user) }
  let(:other_app) { create(:registered_application, user: other_user) }

  describe "GET #index" do
    context "for guest user" do
      it "redirects the user to the login page" do
        get :index, params: { user_id: user.id }

        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "for signed-in user" do
      before do
        sign_in user
      end

      it "returns http success" do
        get :index, params: { user_id: user.id }

        expect(response).to have_http_status(:success)
      end

      it "assigns applications that belong to the user to @applications" do
        get :index, params: { user_id: user.id }

        expect(assigns(:registered_applications)).to eq([app])
      end
    end
  end

  describe "GET #show" do
    context "guest user" do
      it "redirects the user to the sign in page" do
        get :show, params: { id: app.id, user_id: user.id }

        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "signed-in user" do
      before do
        sign_in user
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "assigns the respective wiki to @wiki" do
        get :show, params: { id: app.id, user_id: user.id }

        expect(assigns(:registered_application)).to eq(app)
      end
    end
  end

  describe "GET #new" do
    context "guest user" do
      it "redirects the user to the login page" do
        get :new, params: { user_id: user.id }

        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "signed-in user" do
      before do
        sign_in user
      end

      it "returns http success" do
        get :new, params: { user_id: user.id }

        expect(response).to have_http_status(:success)
      end

      it "renders the #new view" do
        get :new, params: { user_id: user.id }

        expect(response).to render_template :new
      end

      it "instantiates @application" do
        get :new, params: { user_id: user.id }

        expect(assigns(:registered_application)).not_to be_nil
      end
    end
  end

  describe "POST #create" do
    context "guest user" do
      it "redirects to the login page" do
        domain = Faker::Internet.domain_word
        post :create, params: { user_id: user.id, registered_application: { name: domain, url: "#{domain}.com" } }

        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "signed-in user" do
      before do
        sign_in user
      end

      it "increases the number of RegisteredApplications by 1" do
        domain = Faker::Internet.domain_word
        expect{ post :create, params: { user_id: user.id, registered_application: { name: domain, url: "#{domain}.com" } } }.to change(RegisteredApplication, :count).by(1)
      end

      it "assigns the new RegisteredApplication to @application" do
        domain = Faker::Internet.domain_word
        post :create, params: { user_id: user.id, registered_application: { name: domain, url: "#{domain}.com" } }

        expect(assigns(:registered_application)).to eq RegisteredApplication.last
      end

      it "redirects to the new RegisteredApplication" do
        domain = Faker::Internet.domain_word
        post :create, params: { user_id: user.id, registered_application: { name: domain, url: "#{domain}.com" } }

        expect(response).to redirect_to [user, RegisteredApplication.last]
      end
    end
  end

  describe "GET #edit" do
    context "guest user" do
      it "redirects the user to the login page" do
        get :edit, params: { id: app.id, user_id: user.id }

        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "signed-in user" do
      before do
        sign_in user
      end

      it "returns http success" do
        get :edit, params: { id: app.id, user_id: user.id }

        expect(response).to have_http_status(:success)
      end

      it "renders the #edit view" do
        get :edit, params: { id: app.id, user_id: user.id }

        expect(response).to render_template :edit
      end

      it "assigns RegisteredApplication to be updated to @registered_application" do
        get :edit, params: { id: app.id, user_id: user.id }
        app_instance = assigns(:registered_application)

        expect(app_instance.id).to eq app.id
        expect(app_instance.name).to eq app.name
        expect(app_instance.url).to eq app.url
      end
    end
  end

  describe "PUT #update" do
    context "guest user" do
      it "redirects to the login page" do
        new_name = Faker::Internet.domain_word
        new_url = "#{new_name}.com"
        put :update, params: { user_id: user.id, id: app.id, registered_application: { name: new_name, url: new_url } }

        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "signed-in user" do
      before do
        sign_in user
      end

      it "updates registered application with expected attributes" do
        new_name = Faker::Internet.domain_word
        new_url = "#{new_name}.com"
        put :update, params: { user_id: user.id, id: app.id, registered_application: { name: new_name, url: new_url } }

        updated_app = assigns(:registered_application)
        expect(updated_app.id).to eq app.id
        expect(updated_app.name).to eq new_name
        expect(updated_app.url).to eq new_url
      end

      it "redirects to the updated application" do
        new_name = Faker::Internet.domain_word
        new_url = "#{new_name}.com"
        put :update, params: { user_id: user.id, id: app.id, registered_application: { name: new_name, url: new_url } }

        expect(response).to redirect_to [user, app]
      end
    end
  end

  describe "destroy" do
    context "guest user" do
      it "redirects the user to the login page" do
        delete :destroy, params: { user_id: user.id, id: app.id }

        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "signed-in user" do
      before do
        sign_in user
      end

      it "deleted the registered application" do
        delete :destroy, params: { user_id: user.id, id: app.id }
        count = RegisteredApplication.where({id: app.id}).size

        expect(count).to eq 0
      end

      it "redirects to the registered applications index for the user" do
        delete :destroy, params: { user_id: user.id, id: app.id }

        expect(response).to redirect_to(user_registered_applications_path)
      end
    end
  end
end
