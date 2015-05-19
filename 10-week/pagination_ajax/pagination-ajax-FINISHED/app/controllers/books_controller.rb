class BooksController < ApplicationController
  def index
    # offset_value = (params[:page].to_i - 1) * 10
    # @books = Book.limit(10).offset(offset_value)
    sleep 1
    @books = Book.paginate(page: params[:page], per_page: 10)

    respond_to do |format|
      format.html
      format.js
    end
  end

end
