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

private

  def character_params
    params.require(:character).permit(:name)
  end

end
