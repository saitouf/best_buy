class MessageBroadcastJob < ApplicationJob
  queue_as :default

  # ブロードキャスト(一つのネットワークの中にあるすべてのホストに対してデータを送る。)
  def perform(message)
    pp message
    ActionCable.server.broadcast "room_channel_#{message.group_id}", { message: render_message(message) }
  end


  private

  def render_message(message)
    ApplicationController.renderer.render(partial: 'public/messages/message', locals: { message: message })
  end
end
