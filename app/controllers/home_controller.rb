class HomeController < ApplicationController
  def index
    @show_contact_form  = true
    @show_logo_and_menu = true
  end
end
