class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    #receiver = User.find(params[:user_id])

    message = Message.new(message_params)
    message.sender = current_user
    #message.receiver = receiver

    if message.save
      redirect_to "/mypage/messages/users/#{message.receiver_id}"
    else
      # TODO: エラー処理
      @messages = Message.where(["(sender_id = :user1_id and receiver_id = :user2_id) or (sender_id = :user2_id and receiver_id = :user1_id)", { user1_id: current_user.id, user2_id: receiver.id }]).order(:id)
      @message = message

      render "index"
    end
  end

  private
    def message_params
      params.require(:message).permit(:receiver_id, :body)
    end

    # 自分自身に対してはメッセージ機能を実施しない
    def check_self_message!
      receiver = User.find(params[:user_id])

      if current_user.id == receiver.id
        redirect_to root_path, notice: "自分にメッセージは送れません。"  # TODO: 多言語
      end
    end
end
