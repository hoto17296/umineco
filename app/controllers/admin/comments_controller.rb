class Admin::CommentsController < Admin::ApplicationController
  before_action :set_sailing, only: [:new, :create]
  before_action :set_comment, only: [:edit, :update, :destroy]

  # GET /comments/new
  def new
    @comment = Comment.new
    @comment.sailing = @sailing
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)
    @comment.sailing = @sailing

    respond_to do |format|
      if @comment.save
        format.html { redirect_to admin_sailing_path(@sailing), notice: 'コメントを追加しました' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to admin_sailing_path(@comment.sailing), notice: 'コメントを保存しました' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to admin_sailing_path(@comment.sailing), notice: 'コメントを削除しました' }
      format.json { head :no_content }
    end
  end

  private
    def set_sailing
      @sailing = Sailing.find(params[:sailing_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.fetch(:comment).permit(:user_id, :rating, :title, :body)
    end
end
