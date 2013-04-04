require 'spec_helper'

describe UsersController do
  let(:user) { create :user, :with_characters }

  describe "#edit" do
    context "signed in" do
      include_context :sign_in
      it_should_behave_like :action do
        let(:action) { get :edit, id: user.id }
        let(:template) { :edit }
        let(:status) { 200 }
        let(:variables) { {user: user} }
      end
    end

    context "not signed in" do
      it_should_behave_like :action do
        let(:action) { get :edit, id: user.id }
        let(:status) { 302 }
        let(:location) { sign_in_path }
      end
    end
  end

  describe "#update" do
    let(:atrs) { attributes_for :user }

    context "signed in" do
      include_context :sign_in
      it_should_behave_like :action do
        let(:action) { put :update, id: user.id, user: atrs }
        let(:status) { 302 }
        let(:location) { edit_user_path(user) }
        let(:variables) { {user: user} }
      end
    end

    context "not signed in" do
      it_should_behave_like :action do
        let(:action) { put :update, id: user.id, user: atrs }
        let(:status) { 302 }
        let(:location) { sign_in_path }
      end
    end
  end
end
