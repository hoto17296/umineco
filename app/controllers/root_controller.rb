class RootController < ApplicationController

  def index
  end

  def about
  end

  def company
  end

  def terms
  end

  # POST /contact
  def contact
    contact_params = params.permit :body, :email
    if current_user
      name = current_user.name
    else
      name = '未ログインユーザー'
    end

text = <<"EOS"
#{name} さんからお問い合わせがありました。
Email: #{contact_params[:email]}
IP Address: #{request.remote_ip}
Referrer: #{request.referrer}
Body:
#{contact_params[:body]}
EOS

    # Slack に通知
    Slack.chat_postMessage(
      text: text,
      username: "umineco app",
      channel: ENV['SLACK_NOTIFICATION_CHANNEL']
    )
    respond_to do |format|
      format.html { redirect_to :root, notice: 'お問い合わせ内容を送信しました。' }
      format.json { render json: { error: false }, status: :ok }
    end
  end

end
