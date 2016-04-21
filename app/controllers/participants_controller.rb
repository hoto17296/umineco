class ParticipantsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_sailing
  before_action :set_participant, only: [:show, :edit, :update, :destroy]

  # GET /participants
  # GET /participants.json
  def index
    @participants = Participant.all
  end

  # GET /participants/1
  # GET /participants/1.json
  def show
  end

  # GET /participants/new
  def new
    @participant = Participant.new
  end

  # GET /participants/1/edit
  def edit
  end

  # POST /participants
  # POST /participants.json
  def create
    @participant = Participant.new
    @participant.user = current_user
    @participant.sailing = @sailing

    has_error = false
    begin
      # Facebook にシェア
      params = participant_params
      if params[:share]
        graph = Koala::Facebook::API.new(current_user.token)
        message = params[:share_body]
        link = community_url @sailing.community
        graph.put_connections('me', 'feed', message: message, link: link)
      end

      # Slack に通知
      Slack.chat_postMessage(
        text: "#{current_user.name} さんが仮予約しました\n#{community_url(@sailing.community)}",
        username: "umineco app",
        channel: ENV['SLACK_NOTIFICATION_CHANNEL']
      )
    rescue => e
      has_error = true
      logger.warn e.message
    end

    respond_to do |format|
      if ! has_error and @participant.save
        # 参加者がまだコミュニティメンバーでなければ guest として追加する
        @sailing.community.add_member(current_user) if @sailing.community.present?

        format.html { redirect_to @sailing.community, notice: '仮予約を受け付けました。' }
        format.json { render :show, status: :created, location: @participant }
      else
        format.html { redirect_to @sailing.community, alert: 'エラーが発生しました。' }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /participants/1
  # PATCH/PUT /participants/1.json
  def update
    respond_to do |format|
      if @participant.update(participant_params)
        format.html { redirect_to @participant, notice: 'Participant was successfully updated.' }
        format.json { render :show, status: :ok, location: @participant }
      else
        format.html { render :edit }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /participants/1
  # DELETE /participants/1.json
  def destroy
    @participant.destroy
    respond_to do |format|
      format.html { redirect_to participants_url, notice: 'Participant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_sailing
      @sailing = Sailing.find(params[:sailing_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_participant
      @participant = Participant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def participant_params
      _params = params.require(:participant).permit(:share, :share_body)
      _params[:share] = ( _params[:share].to_i === 1 )
      _params
    end
end
