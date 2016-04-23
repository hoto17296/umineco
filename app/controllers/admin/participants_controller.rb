class Admin::ParticipantsController < Admin::ApplicationController
  before_action :set_sailing, only: [:create]
  before_action :set_participant, only: [:destroy]

  # POST /participants
  # POST /participants.json
  def create
    participant_params = params.require(:participant).permit(:user_id)
    @participant = Participant.new(participant_params)
    @participant.sailing = @sailing

    respond_to do |format|
      if @participant.save
        # 参加者がまだコミュニティメンバーでなければ guest として追加する
        @sailing.community.add_member(current_user) if @sailing.community.present?

        format.html { redirect_to admin_sailing_path(@sailing), notice: '参加者を追加しました' }
        format.json { render :show, status: :created, location: @participant }
      else
        format.html { redirect_to admin_sailing_path(@sailing), alert: 'エラーが発生しました' }
        format.json { render json: @participant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /participants/1
  # DELETE /participants/1.json
  def destroy
    @participant.destroy
    respond_to do |format|
      format.html { redirect_to admin_sailing_path(@participant.sailing), notice: '参加者を外しました' }
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

end
