class SaqueController < ApplicationController
  before_action :authenticate_user!
  before_action :set_saque, only: [:show, :edit, :update, :destroy]

  # GET /saque
  # GET /saque.json
  def index
    @saque = Saque.all
  end

  # GET /saque/1
  # GET /saque/1.json
  def show
  end

  # GET /saque/new
  def new
    @saque = Saque.new(:conta_id => params[:conta_id])
  end

  # GET /saque/1/edit
  def edit
  end

  # POST /saque
  # POST /saque.json
  def create
    @saque = Saque.new(saque_params)

    respond_to do |format|
      if @saque.save
        format.html { redirect_to @saque, notice: 'Saque was successfully created.' }
        format.json { render :show, status: :created, location: @saque }
      else
        format.html { render :new }
        format.json { render json: @saque.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /saque/1
  # PATCH/PUT /saque/1.json
  def update
    respond_to do |format|
      if @saque.update(saque_params)
        format.html { redirect_to @saque, notice: 'Saque was successfully updated.' }
        format.json { render :show, status: :ok, location: @saque }
      else
        format.html { render :edit }
        format.json { render json: @saque.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /saque/1
  # DELETE /saque/1.json
  def destroy
    @saque.destroy
    respond_to do |format|
      format.html { redirect_to saque_index_url, notice: 'Saque was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_saque
      @saque = Saque.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def saque_params
      params.require(:saque).permit(:valor, :created_at, :conta_id, :valorProvisorio)
    end
end
