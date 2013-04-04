class CharactersController < ApplicationController
  load_and_authorize_resource
  expose :characters,
    ancestor: :current_user
  expose :character,
    attributes: :character_params,
    ancestor: :characters

  def update
    character.save
    respond_with character, location: [ :edit, character ]
  end
  alias_method :create, :update

  def destroy
    character.destroy
    respond_with character, location: characters_path
  end

private

  def character_params
    params.require(:character).permit(:name, :public_bio, :private_bio, :avatar)
  end

end
