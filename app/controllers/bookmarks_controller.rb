class BookmarksController < ApplicationController
  before_action :set_bookmark, only: [:show, :edit, :update, :destroy]

  def index
    @bookmarks = Bookmark.all.order(created_at: :desc)
  end

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    if @bookmark.save
      flash[:notice] = '１レコード追加しました'
      redirect_to bookmarks_path
    else
      flash.now[:alert] = '追加に失敗しました。入力内容を確認してください。'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
      @bookmark = Bookmark.find(params[:id])
  end

  def update
    if @bookmark.update(bookmark_params)
      flash[:notice] = '１レコード更新しました'
      redirect_to bookmarks_path
    else
      flash.now[:alert] = '更新に失敗しました。入力内容を確認してください。'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @bookmark.destroy
      flash[:notice] = '１レコード削除しました'
      redirect_to bookmarks_path
    else
      flash[:alert] = '削除に失敗しました'
      redirect_to bookmarks_path, status: :unprocessable_entity
    end
  end

  private

  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:title, :url, :date)
  end
end
