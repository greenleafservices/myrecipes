App.comments = App.cable.subscriptions.create "CommentsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $('#comment_messages').prepend(data)
    $('#comment_description').val '' # clear the last message on the recipe comment form on the recipe show page - you can find the id by using the inspect element process while the form is active
    # Called when there's incoming data on the websocket for this channel
