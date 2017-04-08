class CommentsController < ApplicationController
  before_action :require_user #from ApplicationController

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = @recipe.comments.build(comment_params)
    @comment.chef = current_chef
    if @comment.save
      ActionCable.server.broadcast "comments", render(partial: 'comments/comment', object: @comment)
      #flash[:success] = "Comment was created successfully" # Can't use this with the Action Cable process
      #redirect_to recipe_path(@recipe)
    else
      flash[:danger] = "Comment was not created"
      redirect_to :back
    end
  end

  def edit
    @comment = Comment.find(params[:id]) #get the comment data
  end

  def update

    @comment = Comment.find(params[:id]) #get the Comment data
    if @comment.update(comment_params)
      flash[:success] = "Comment was updated successfully!"
      redirect_to recipe_path(session[:recipe_comment_id]) #passed from _comments.html.erb on _recipe partial
    else
      render 'edit'
    end
  end

  def show
    @comment = Comment.find(params[:id]) #get the recipe data
  end

  def destroy

  end

  private

  def comment_params
    params.require(:comment).permit(:description)
  end

end
