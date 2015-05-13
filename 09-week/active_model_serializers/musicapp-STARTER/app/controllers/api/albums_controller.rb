module API
  class AlbumsController < ApplicationController
    protect_from_forgery with: :null_session

    def index
      render json: Album.all
    end
  end
end
