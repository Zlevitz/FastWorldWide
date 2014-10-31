class PinsController < ApplicationController
  before_action :set_pin, only: [ :edit, :update, :destroy, :upvote, :downvote, :score]

  def index
    @top = Pin.highest_voted.limit(5)
    @pins = Pin.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 50)
  end

  def show
    @pin = Pin.find(params[:id])
    @comments = @pin.comment_threads.order('created_at desc')
    @new_comment = Comment.build_from(@pin, current_user.id, "")
  end

  def new
    @site_options = Site.all.map{|u| [u.location,u.id]}
    @pin = current_user.pins.build
  end

  def edit
  end

  def create
    @pin = current_user.pins.build(pin_params)
    if @pin.save
      redirect_to @pin, notice: 'Pin was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @pin.update(pin_params)
      redirect_to @pin, notice: 'Pin was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @pin.destroy
    redirect_to pins_url
  end

  def upvote
      @pin.upvote_by current_user
      redirect_to pins_path
  end

  def downvote
    @pin.downvote_by current_user
    redirect_to pins_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pin
      @pin = Pin.find(params[:id])
    end

    def correct_user
      @pin = current_user.pins.find_by(id: params[:id])
      redirect_to pins_path, notice: "Not authorized to edit this pin" if @pin.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pin_params
      params.require(:pin).permit(:description, :image)
    end
end