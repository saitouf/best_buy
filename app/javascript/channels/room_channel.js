import consumer from "./consumer"

$(function(){
    const chatChannel = consumer.subscriptions.create({ channel: 'RoomChannel', group: $('#messages').data('room_id') }, {
      connected() {
    // Called when the subscription is ready for use on the server
  },

  received: function(data) {
    return $('#messages').append(data['message']);
  },

  speak: function(message,group_id) {
    return this.perform('speak', {message: message, group: group_id });
  }
});

  $(document).on('keypress', '[data-behavior~=room_speaker]', function(event) {
   if (event.key === 'Enter') {
    chatChannel.speak(event.target.value,$('#messages').data('room_id'));
    event.target.value = '';
    return event.preventDefault();
  }
  });
});
