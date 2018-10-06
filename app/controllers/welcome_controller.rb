class WelcomeController < ApplicationController
  
  skip_before_action :authenticate_user!, only: [:index, :about]
  def index
    if user_signed_in? 
      redirect_to tasks_path
    end
  end

  def about

  end

end
