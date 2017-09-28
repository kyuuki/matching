class Mypage::AppointmentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @appointments = Appointment.where(user: current_user).order({ datetime: :desc })

    render layout: "mypage"
  end
end
