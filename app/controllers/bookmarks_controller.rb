class BookmarksController < ApplicationController
  def create
    @movie = Movie.find_by(title: params[:movie])
    @list = List.find(params[:list_id])
    if @movie.nil?
      redirect_to list_path(@list, movie: params[:bookmark][:movie], comment: params[:bookmark][:comment])
    else
      @bookmark = Bookmark.new(bookmark_params)
      @bookmark.list = @list
      if @bookmark.save
        redirect_to lists_path
      else
        render "lists/show", status: :unprocessable_entity
      end
    end
  end

  def destroy
    bookmark = Bookmark.find(params[:id])
    bookmark.destroy
    redirect_to list_path(bookmark.list), status: :see_other
  end

  def import
    movie = Movie.new(title: params["movie"]["Title"], overview: "Imported Movie",  poster_url: params["movie"]["Poster"])
    movie.save!
    @list = List.find(params[:list_id])
    @bookmark = Bookmark.new(movie: movie, list: @list, comment: params[:comment])
    if @bookmark.save!
      redirect_to list_path(@list)
    else
      render "list/show", status: :unprocessable_entity
    end
  end

    private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie)
  end
end
