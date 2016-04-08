class CommunitiesController < ApplicationController
  before_action :authenticate_admin_user!, except: [:show, :interest, :another_time]
  before_action :set_community, only: [:show, :edit, :update, :destroy, :interest, :another_time]

  # GET /communities
  # GET /communities.json
  def index
    @communities = Community.all
  end

  # GET /communities/1
  # GET /communities/1.json
  def show
  end

  # GET /communities/new
  def new
    @community = Community.new
  end

  # GET /communities/1/edit
  def edit
  end

  # POST /communities
  # POST /communities.json
  def create
    @community = Community.new(community_params)

    respond_to do |format|
      if @community.save
        format.html { redirect_to @community, notice: 'Community was successfully created.' }
        format.json { render :show, status: :created, location: @community }
      else
        format.html { render :new }
        format.json { render json: @community.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /communities/1
  # PATCH/PUT /communities/1.json
  def update
    respond_to do |format|
      if @community.update(community_params)
        format.html { redirect_to @community, notice: 'Community was successfully updated.' }
        format.json { render :show, status: :ok, location: @community }
      else
        format.html { render :edit }
        format.json { render json: @community.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /communities/1
  # DELETE /communities/1.json
  def destroy
    @community.destroy
    respond_to do |format|
      format.html { redirect_to communities_url, notice: 'Community was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # 「興味あります」
  def interest
    # コメントをフィードとして保存
    feed_params = params.fetch(:feed, {}).permit(:body)
    feed = Feed.new({
      body: feed_params[:body],
      type: :interest,
      community: @community,
      user: current_user,
    })

    Slack.chat_postMessage(
      text: "#{current_user.name} さんが興味があると言っています\nメッセージ： #{feed_params[:body]}",
      username: "umineco app",
      channel: ENV['SLACK_NOTIFICATION_CHANNEL']
    )

    respond_to do |format|
      if feed.save
        # 参加者がまだコミュニティメンバーでなければ guest として追加する
        @community.add_member(current_user)
        format.html { redirect_to @community, notice: '興味がある旨を送信しました。' }
        format.json { render :show, status: :ok, location: @community }
      else
        format.html { render :edit }
        format.json { render json: @community.errors, status: :unprocessable_entity }
      end
    end
  end

  # 「別日程なら参加したい」
  def another_time
    # コメントをフィードとして保存
    feed_params = params.fetch(:feed, {}).permit(:body)
    feed = Feed.new({
      body: feed_params[:body],
      type: :another_time,
      community: @community,
      user: current_user,
    })

    respond_to do |format|
      if feed.save
        # 参加者がまだコミュニティメンバーでなければ guest として追加する
        @community.add_member(current_user)
        format.html { redirect_to @community, notice: 'Community was successfully updated.' }
        format.json { render :show, status: :ok, location: @community }
      else
        format.html { render :edit }
        format.json { render json: @community.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_community
      @community = Community.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def community_params
      params.require(:community).permit(:name)
    end
end
