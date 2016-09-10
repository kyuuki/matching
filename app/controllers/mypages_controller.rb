class MypagesController < ApplicationController
  before_action :authenticate_user!

  def show
    render layout: "mypage"
  end
end
