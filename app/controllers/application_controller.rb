class ApplicationController < ActionController::API
  # 安全なエンドポイントを守るための認証アクションを提供するモジュール
  include JWTSessions::RailsAuthorization
  # 例外処理
  rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized

  private

  def current_user
    @current_user ||= User.find(payload['user_id'])
  end

  def not_authorized
    render json: { error: 'Not authorized' }, status: :unauthorized
  end
end
