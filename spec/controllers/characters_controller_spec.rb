require 'spec_helper'

describe CharactersController do
  let(:user) { create :user, :with_characters }

  describe "#index" do
    context "signed in" do
      include_context :sign_in
      it_should_behave_like :action do
        let(:action) { get :index }
        let(:template) { :index }
        let(:status) { 200 }
        let(:variables) { {characters: user.characters} }
      end
    end

    context "not signed in" do
      it_should_behave_like :action do
        let(:action) { get :index }
        let(:status) { 302 }
        let(:location) { sign_in_path }
      end
    end
  end

  describe "#edit" do
    let(:character) { user.characters.sample }

    context "signed in" do
      include_context :sign_in
      it_should_behave_like :action do
        let(:action) { get :edit, id: character.id }
        let(:template) { :edit }
        let(:status) { 200 }
        let(:variables) { {character: character} }
      end
    end

    context "not signed in" do
      it_should_behave_like :action do
        let(:action) { get :edit, id: character.id }
        let(:status) { 302 }
        let(:location) { sign_in_path }
      end
    end
  end

  describe "#update" do
    let(:character) { user.characters.sample }
    let(:atrs) { attributes_for :character }

    context "signed in" do
      include_context :sign_in
      it_should_behave_like :action do
        let(:action) { put :update, id: character.id, character: atrs }
        let(:status) { 302 }
        let(:location) { edit_character_path(character) }
        let(:variables) { {character: character} }
      end
    end

    context "not signed in" do
      it_should_behave_like :action do
        let(:action) { put :update, id: character.id, character: atrs }
        let(:status) { 302 }
        let(:location) { sign_in_path }
      end
    end
  end

  describe "#create" do
    let(:atrs) { attributes_for :character }

    context "signed in" do
      include_context :sign_in
      it_should_behave_like :action do
        let(:action) { post :create, character: atrs }
        let(:header_location) { /\/characters\/.{24}\/edit/ }
        let(:status) { 302 }
      end
    end

    context "not signed in" do
      it_should_behave_like :action do
        let(:action) { post :create, character: atrs }
        let(:status) { 302 }
        let(:location) { sign_in_path }
      end
    end
  end

  describe "#destroy" do
    let(:character) { user.characters.sample }

    context "signed in" do
      include_context :sign_in
      it_should_behave_like :action do
        let(:action) { delete :destroy, id: character.id }
        let(:status) { 302 }
        let(:location) { characters_path }
        let(:variables) { {character: character} }
      end
    end

    context "not signed in" do
      it_should_behave_like :action do
        let(:action) { delete :destroy, id: character.id }
        let(:status) { 302 }
        let(:location) { sign_in_path }
      end
    end
  end
end
