require 'open-uri'
require "json"

class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
    @bookmark = Bookmark.new
    @movies = get_movie_search(params[:movie])
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to lists_path
    else
      render :new, status: :unprocessable_entity
    end
  end

    private

  def list_params
    params.require(:list).permit(:name, :photo)
  end

  def get_movie_search(title)
    url = URI.open("http://www.omdbapi.com/?apikey=adf1f2d7&s=#{title}").read
    req = JSON.parse(url)
    req
  end
end
