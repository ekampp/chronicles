class CharactersController < ApplicationController
  expose :character,
    attributes: :character_params,
    ancestor: :current_user
  expose :characters,
    ancestor: :current_user
  load_and_authorize_resource

private

  def character_params
    params.require(:character).permit(:name)
  end

end
