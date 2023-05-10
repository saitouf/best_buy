class RoomChannel < ApplicationCable::Channel
  def subscribed
    # room_channel.rbとroom_channel.jsでデータの送受信ができるようになる。
    stream_from "room_channel_#{params['group']}" 
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    # jsで実行されたspeakのmessageを受け取り、room_channelのreceivedにブロードキャストする
    Message.create! content: data['message'], customer_id: current_customer.id, group_id: params['group']
  end
end
