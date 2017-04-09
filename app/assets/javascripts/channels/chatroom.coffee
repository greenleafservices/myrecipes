App.chatroom = App.cable.subscriptions.create "ChatroomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $('#messages').prepend(data)
    #$('#messages').append('message')
    #$('#messages').append data['message']
    $('#message_content').val '' # clear the last message on the form
    #message-span content
    #scrollToBottom()
    return
    # Called when there's incoming data on the websocket for this channel
