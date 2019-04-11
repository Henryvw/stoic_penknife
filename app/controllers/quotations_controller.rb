class QuotationsController < ApplicationController
  # Load CanCan roles for Controller
  load_and_authorize_resource

  before_action :set_quotation, only: %i[show edit update destroy]

  # GET /quotations
  # GET /quotations.json
  def index
    @quotations = Quotation.all
  end

  # GET /quotations/1
  # GET /quotations/1.json
  def show; end

  # GET /quotations/new
  def new
    @quotation = Quotation.new
  end

  # GET /quotations/1/edit
  def edit; end

  # POST /quotations
  # POST /quotations.json
  def create
    @quotation = Quotation.new(quotation_params)
    respond_to do |format|
      if @quotation.save
        format.html { redirect_to @quotation, notice: 'New quotation added!' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /quotations/1
  # PATCH/PUT /quotations/1.json
  def update
    respond_to do |format|
      if @quotation.update(quotation_params)
        format.html do
          redirect_to @quotation,
                      notice: 'Quotation was successfully updated.'
        end
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /quotations/1
  # DELETE /quotations/1.json
  def destroy
    @quotation.destroy
    respond_to do |format|
      format.html { redirect_to quotations_url }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_quotation
    @quotation = Quotation.find(params[:id])
  end

  # Never trust parameters from the scary internet
  def quotation_params
    params.require(:quotation).permit(:title,
                                      :passage,
                                      :tag_list,
                                      :publish)
  end
end
