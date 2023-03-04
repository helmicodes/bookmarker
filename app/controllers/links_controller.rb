class LinksController < ApplicationController
  before_action :require_signin
  before_action :set_link, only: %i[ show edit update destroy ]

  # GET /links or /links.json
  def index
    @link = Link.new
    @links = Link.search(params)
    @link_categories = Link.pluck(:category).uniq.compact
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
      title: link_title,
      image_url: link_image_url,
      category: link_category
    )

    respond_to do |format|
      if @link.save
        # format.html { redirect_to link_url(@link), notice: "Link was successfully created." }
        # format.json { render :show, status: :created, location: @link }

        @new_link = Link.new

        format.turbo_stream
        format.html { redirect_to links_url }

        # flash.now[:notice] = "Saved"
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

    respond_to do |format|
      format.html { redirect_to links_url, notice: "Link was successfully destroyed." }
      format.json { head :no_content }
    end
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

  def link_category
    return "Videos" if URI(params[:link][:url]).host.include?("youtube") || URI(params[:link][:url]).host.include?("vimeo")
    "Articles"
  end

  def link_title
    Mechanize.new.get(params[:link][:url]).title
  end

  def link_image_url
    Mechanize.new.get(params[:link][:url]).at('meta[property="og:image"]')&.[]('content')
  end
end
