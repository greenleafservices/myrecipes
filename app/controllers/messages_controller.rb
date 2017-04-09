class MessagesController < ApplicationController

  before_action :require_user #from ApplicationController

  def create
    @message = Message.new(message_params)
      @message.chef = current_chef
      if @message.save
        #redirect_to chat_path
        ActionCable.server.broadcast "chatroom_channel", render(partial: 'messages/message', object: @message)
        #render(partial: 'message', locals: { message: message})
        #ActionCable.server.broadcast "chatroom_channel", message: render_message(@message), chef: @message.chef.name
      else
        render 'chatrooms/show'
      end
  end

  def edit
    # @comment = Comment.find(params[:id]) #get the comment data
  end

  def update

    # @comment = Comment.find(params[:id]) #get the Comment data
    # if @comment.update(comment_params)
    #   flash[:success] = "Comment updated!"
    #   redirect_to recipe_path(session[:recipe_comment_id]) #passed from _comments.html.erb on _recipe partial
    # else
    #   flash[:danger] = "Comment was not updated"
    #   #redirect_to :back
    #   render 'edit'
    # end
  end

  def show
    # @comment = Comment.find(params[:id]) #get the recipe data
  end

  def delete
  end

  def destroy
    # Comment.find(params[:id]).destroy #get the comment data, set the action
    # flash[:success] = "Comment was deleted successfully!"
    # redirect_to recipe_path(session[:recipe_comment_id]) #passed from _comments.html.erb on _recipe partial
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def render_message(message)
    render(partial: 'message', locals: { message: message})
  end
end
