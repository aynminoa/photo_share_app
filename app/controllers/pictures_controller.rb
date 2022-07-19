class PicturesController < ApplicationController
  before_action :set_picture, only: [ :show, :edit, :update, :destroy ]

  # GET /pictures
  def index
    @pictures = Picture.all
  end

  # GET /pictures/1 
  def show
  end

  # GET /pictures/new
  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end

  # GET /pictures/1/edit
  def edit
  end

  # POST /pictures
  def create
  @picture = current_user.pictures.build(picture_params)
    if @picture.save
      redirect_to pictures_path, notice: "投稿が作成されました。" 
    else
      render :new 
    end
  end

  def confirm
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id 
    render :new if @picture.invalid?
  end

  # PATCH/PUT /pictures/1 
  def update
    if @picture.update(picture_params)
      redirect_to pictures_path, notice: "投稿が更新されました。" 
    else
      render :edit
    end
  end

  # DELETE /pictures/1 
  def destroy
    @picture.destroy
      redirect_to pictures_path, notice: "投稿が削除されました。" 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_picture
    @picture = Picture.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def picture_params
    params.require(:picture).permit(:image, :image_cache, :content)
  end
end
