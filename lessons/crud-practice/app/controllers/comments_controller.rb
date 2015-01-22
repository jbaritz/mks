class CommentsController < ApplicationController
  def index
    @comments = Comment.all
  end

  def show
    @comments = Comment.find(params[:video_id])
  end

  def new
    @comments = Comment.new
  end

  def create
    comments = Comment.new(comment_params)
    comments.save
    redirect_to root_path
  end

  def edit
    @comments = Comment.find(params[:id])
  end

  def update
    @comments = Comment.find(params[:id])
    @comments.update(comment_params)
    redirect_to root_path
  end

  def destroy
    @comments = Comment.find(params[:id])
    @comments.destroy
    redirect_to root_path
  end

  private
  def comment_params
    params.require(:comments).permit(:title, :description, :youtube_id)
  end
end
