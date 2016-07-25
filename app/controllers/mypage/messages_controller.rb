class Mypage::MessagesController < ApplicationController
  before_action :authenticate_user!, :check_self_message!
  def index
    # TODO: 存在しない
    receiver = User.find(params[:user_id])

    @messages = Message.where(["(sender_id = :user1_id and receiver_id = :user2_id) or (sender_id = :user2_id and receiver_id = :user1_id)", { user1_id: current_user.id, user2_id: receiver.id }]).order(:id)
    @message = Message.new
  end

  def create
    receiver = User.find(params[:user_id])

    message = Message.new(message_params)
    message.sender = current_user
    message.receiver = receiver

    if message.save
      redirect_to mypage_user_messages_path
    else
      @messages = Message.where(["(sender_id = :user1_id and receiver_id = :user2_id) or (sender_id = :user2_id and receiver_id = :user1_id)", { user1_id: current_user.id, user2_id: receiver.id }]).order(:id)
      @message = message

      render "index"
    end
  end

  private
    def message_params
      params.require(:message).permit(:body)
    end

    # 自分自身に対してはメッセージ機能を実施しない
    def check_self_message!
      receiver = User.find(params[:user_id])

      if current_user.id == receiver.id
        redirect_to root_path
      end
    end
end
