class ApplicationController < ActionController::Base
  #アクション前処理
  before_action :basic_auth


  #プライベートメソッド
  private

  #Basic認証
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

end
