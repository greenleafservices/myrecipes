class ChatroomsController < ApplicationController
  before_action :require_user #from ApplicationController

  def show
    @message = Message.new
    #@messages = Message.most_recent #most_recent in message model
    @messages = Message.sorted_by_time
  end

end
