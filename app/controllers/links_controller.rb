class LinksController < ApplicationController
  before_action :require_signin
  before_action :set_link, only: %i[ show edit update destroy ]

  # GET /links or /links.json
  def index
    @link = Link.new
    @links = current_user.links.search(params)
    @link_categories = current_user.links.pluck(:category).uniq.compact
  end

  # GET /links/1 or /links/1.json
  def show
  end

  # GET /links/new
  def new
    @link = Link.new
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links or /links.json
  def create
    @link = Link.new(
      url: params[:link][:url],
      user_id: current_user.id
    )

    respond_to do |format|
      if @link.save
        UpdateLinkDataJob.perform_later(@link)
        @new_link = Link.new

        flash.now[:notice] = "Saved"
        format.turbo_stream
        format.html { redirect_to links_url }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1 or /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to link_url(@link), notice: "Link was successfully updated." }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1 or /links/1.json
  def destroy
    @link.destroy

    flash.now[:notice] = "Deleted"
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_link
    @link = Link.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def link_params
    params.require(:link).permit(:url)
  end
end
