class CharactersController < ApplicationController
  expose :character, attributes: :character_params
  expose(:characters){ current_user.characters }
  load_and_authorize_resource

private

  def character_params
    params.require(:character).permit(:name)
  end

end
