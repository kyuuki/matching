class Mypage::MessagesController < ApplicationController
  before_action :authenticate_user!

  # メッセージやり取りしているユーザー一覧
  def users
    # TODO: やりとりしているユーザーを保存するテーブルを追加
    # TODO: 最後のメッセージ順に並べる (↑と一緒にやる)

    receiver_ids = Message.where(sender_id: current_user).select("receiver_id").pluck :receiver_id
    sender_ids = Message.where(receiver_id: current_user).select("sender_id").pluck :sender_id
    ids = receiver_ids | sender_ids

    @users = User.where(id: ids)

    render layout: "mypage"
  end

  def index
    # TODO: 存在しない
    receiver = User.find(params[:id])

    @messages = Message.where(["(sender_id = :user1_id and receiver_id = :user2_id) or (sender_id = :user2_id and receiver_id = :user1_id)", { user1_id: current_user.id, user2_id: receiver.id }]).order(:id)
    @message = Message.new
    @message.receiver = receiver

    render layout: "mypage"
  end
end
