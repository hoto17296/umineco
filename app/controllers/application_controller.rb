class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # スマホビューの自動振り分け
  include Jpmobile::ViewSelector

  before_action :set_javascript_data

  def set_javascript_data
    gon.request = {
      controller: controller_name,
      action: action_name,
      sp: !! request.smart_phone?,
    }
    # 各ページごとに渡したいデータがあれば params に入れる
    gon.params = {};
  end

  # 管理ユーザーでなければ 403 を返す
  def authenticate_admin_user!
    authenticate_user!
    unless current_user.admin?
      redirect_to :root, status: :forbidden, alert: '権限がありません'
    end
  end

end
