class SailingsController < ApplicationController
  before_action :set_sailing, only: [:show, :edit, :update, :destroy, :interest]

  # GET /sailings
  # GET /sailings.json
  def index
    @sailings = Sailing.all
  end

  # GET /sailings/1
  # GET /sailings/1.json
  def show
  end

  # GET /sailings/new
  def new
    @sailing = Sailing.new
  end

  # GET /sailings/1/edit
  def edit
  end

  # POST /sailings
  # POST /sailings.json
  def create
    @sailing = Sailing.new(sailing_params)

    respond_to do |format|
      if @sailing.save
        format.html { redirect_to @sailing, notice: 'Sailing was successfully created.' }
        format.json { render :show, status: :created, location: @sailing }
      else
        format.html { render :new }
        format.json { render json: @sailing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sailings/1
  # PATCH/PUT /sailings/1.json
  def update
    respond_to do |format|
      if @sailing.update(sailing_params)
        format.html { redirect_to @sailing, notice: 'Sailing was successfully updated.' }
        format.json { render :show, status: :ok, location: @sailing }
      else
        format.html { render :edit }
        format.json { render json: @sailing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sailings/1
  # DELETE /sailings/1.json
  def destroy
    @sailing.destroy
    respond_to do |format|
      format.html { redirect_to sailings_url, notice: 'Sailing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sailing
      @sailing = Sailing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sailing_params
      sailing = params.require(:sailing).permit(:name, :community_id, :duration_begin, :duration_end)
      if sailing[:duration_begin].present? and sailing[:duration_end].present?
        sailing[:duration] = DateTime.parse(sailing[:duration_begin])..DateTime.parse(sailing[:duration_end])
      end
      sailing.delete :duration_begin
      sailing.delete :duration_end
      sailing
    end
end
