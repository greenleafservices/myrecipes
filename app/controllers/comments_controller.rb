class CommentsController < ApplicationController
  before_action :require_user #from ApplicationController
  protect_from_forgery
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
    # @recipe = Recipe.find(params[:recipe_id])
    # @comment = @recipe.comments.build(comment_params)
  end

  def update

  end

  def show

  end

  def destroy

  end

  private

  def comment_params
    params.require(:comment).permit(:description)
  end

end
