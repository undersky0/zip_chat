class ChatRoomsController < ApplicationController
  before_action :set_chat_room, only: [:show, :edit, :update, :destroy]
  include Guest
  # GET /chat_rooms
  def index
    @pagy, @chat_rooms = pagy(ChatRoom.sort_by_params(params[:sort], sort_direction))
  end

  # GET /chat_rooms/1 or /chat_rooms/1.json
  def show
    @messages = @chat_room.messages.without_system.includes(:user).order(:created_at)
  end

  # GET /chat_rooms/new
  def new
    @chat_room = ChatRoom.new
  end

  # GET /chat_rooms/1/edit
  def edit
  end

  # POST /chat_rooms or /chat_rooms.json
  def create
    @chat_room = ChatRoom.new(
      user: current_or_guest_user,
      name: "#{DateTime.now.strftime("%Y-%m-%d %H:%M:%S")} Chat"
    )
    @chat_room.save
    @chat_room.messages.create(
      content: "Welcome to the shoppy! I'm here to help you find the products you want. You can ask me about any product, and I'll do my best to provide you with the information you need. If you're ready to make a purchase, just let me know, and I'll guide you through the checkout process.",
      role: "assistant"
    )
  end

  # PATCH/PUT /chat_rooms/1 or /chat_rooms/1.json
  def update
    respond_to do |format|
      if @chat_room.update(chat_room_params)
        format.html { redirect_to @chat_room, notice: "Chat room was successfully updated." }
        format.json { render :show, status: :ok, location: @chat_room }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @chat_room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chat_rooms/1 or /chat_rooms/1.json
  def destroy
    @chat_room.destroy!
    respond_to do |format|
      format.html { redirect_to chat_rooms_url, status: :see_other, notice: "Chat room was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_chat_room
    @chat_room = ChatRoom.find(params[:id])

    # Uncomment to authorize with Pundit
    # authorize @chat_room
  rescue ActiveRecord::RecordNotFound
    redirect_to chat_rooms_path
  end

  # Only allow a list of trusted parameters through.
  def chat_room_params
    params.require(:chat_room).permit(:name)

    # Uncomment to use Pundit permitted attributes
    # params.require(:chat_room).permit(policy(@chat_room).permitted_attributes)
  end
end
