import consumer from "./consumer"

$(function(){
    const chatChannel = consumer.subscriptions.create({ channel: 'RoomChannel', group: $('#messages').data('group_id') }, {
      connected() {
    // Called when the subscription is ready for use on the server
  },

  received: function(data) {
    return $('#messages').append(data['message']);
  },

  speak: function(message) {
    return this.perform('speak', {message: message});
  }
});

  $(document).on('keypress', '[data-behavior~=room_speaker]', function(event) {
   if (event.key === 'Enter') {
    chatChannel.speak(event.target.value);
    event.target.value = '';
    return event.preventDefault();
  }
  });
});
