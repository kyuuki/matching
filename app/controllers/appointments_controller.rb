class AppointmentsController < ApplicationController
  before_action :authenticate_user!

  def create
    appointment = Appointment.new(appointment_params)
    appointment.user = current_user

    # 自分のチケットは予約はできない
    if appointment.item.user == current_user
      @item = appointment.item

      redirect_to @item, notice: "ご自身のチケットは予約できません。"  # TODO: 多言語
      return
    end

    if appointment.save
      redirect_to mypage_appointments_path, notice: "予約完了しました。"  # TODO: 多言語
    else
      # 一つ前が item ページという前提
      @item = appointment.item

      # TODO: エラー時の処理を要検討
      # TODO: 短期間の予約のチェック
      redirect_to @item, notice: "日時を入れてください。"  # TODO: 多言語
    end
  end

  private
    def appointment_params
      params.require(:appointment).permit(:item_id, :place, :datetime, :memo)
    end
end
