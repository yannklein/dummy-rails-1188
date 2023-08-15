require "open-uri"
require 'docx'


class NovelsController < ApplicationController
  before_action :set_novel, only: %i[ show edit update destroy ]

  # GET /novels or /novels.json
  def index
    @novels = Novel.all
  end

  # GET /novels/1 or /novels/1.json
  def show
  end

  # GET /novels/new
  def new
    @novel = Novel.new
  end

  # GET /novels/1/edit
  def edit
  end

  # POST /novels or /novels.json
  def create
    @novel = Novel.new(novel_params)
    respond_to do |format|
      if @novel.save
        url =  @novel.doc_asset.url
        raw = URI.open(url).read
        docx = Docx::Document.open(raw)
        docx.paragraphs.each do |p|
          raise
        end
        format.html { redirect_to novel_url(@novel), notice: "Novel was successfully created." }
        format.json { render :show, status: :created, location: @novel }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @novel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /novels/1 or /novels/1.json
  def update
    respond_to do |format|
      if @novel.update(novel_params)
        format.html { redirect_to novel_url(@novel), notice: "Novel was successfully updated." }
        format.json { render :show, status: :ok, location: @novel }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @novel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /novels/1 or /novels/1.json
  def destroy
    @novel.destroy

    respond_to do |format|
      format.html { redirect_to novels_url, notice: "Novel was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_novel
      @novel = Novel.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def novel_params
      params.require(:novel).permit(:title, :doc_asset)
    end
end
