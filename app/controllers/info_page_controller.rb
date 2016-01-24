class InfoPageController < ApplicationController
  before_action :authenticate_user!, :except => [:home]
  def home
  end

  def about
  end

end
