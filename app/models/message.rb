class Message < ApplicationRecord

  belongs_to :customer
  belongs_to :group

  validates :content, presence: true
  # データ保存後にMessageBroadcastJobのperformメソッドを実行,引数はself
  after_create_commit { MessageBroadcastJob.perform_later self }

end
