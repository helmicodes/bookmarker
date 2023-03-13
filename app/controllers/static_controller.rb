class StaticController < ApplicationController
  def index
    if signed_in?
      redirect_to links_url
    end
  end
end
