class BooksController < ApplicationController
  def index
    sleep 1 #to simulate real-world latency
    @books = Book.paginate(page: params[:page], per_page: 10)

    respond_to do |format|
      format.html
      format.js
    end
  end

end
