class PlayersController < ApplicationController
  before_action :set_game
  before_action :set_game_player, only: [:show, :update, :destroy, :roll, :zeroizeAll, :zeroize]

  # GET /games/:game_id/players
  def index
    json_response(@game.players)
  end

  # GET /games/:game_id/players/:id
  def show
    json_response(@player)
  end

  # POST /games/:game_id/players
  def create
    @game.players.create!(player_params)
    json_response(@game, :created)
  end

  # PUT /games/:game_id/players/:id
  def update
    @player.update(player_params)
    head :no_content
  end

  # DELETE /games/:game_id/players/:id
  def destroy
    @player.destroy
    head :no_content
  end

  # POST /games/:game_id/players/:id/roll
  def roll

    puts "#{:pins} = #{pin_params[:pins]}"
    puts "#{@player.roll(pin_params[:pins], @player.frames)}" 
    @player.save
    # puts "#{@player.frames[1].isSpare()} + #{@player.frames[2].id}"
    # # @frame = @player.frames.find_by!(id: params[:id]) if @player
    # @previous = @frame.id-1
    # @previous_frame = @player.frames[@previous]
    # puts "previous frame (#{@frame.id} -> #{@previous_frame.id}) #{Frame.isStrike(@previous_frame)}"
    # puts "is it spare? #{Frame.isSpare()}"
    # puts "is it strike? #{Frame.isStrike(@previous_frame)}"

    # frame_params = Frame.roll(params[:pins], @frame)
    # # @frame.update(frame_params)
    # # # @score = Frame.roll(params[:pins])
    # # # frame_params = {"score"=>@score}
    # # json_response(@frame)
    
  end

  # GET /games/:game_id/players/:id
  def zeroizeAll
    @player.zeroizeAll(@player.frames)
    @player.save
  end

  # POST /games/:game_id/players/:id
  def zeroize
    index = frame_params[:frame] - 1
    @player.zeroize(@player.frames[index])
    @player.save
  end

  private

  def player_params
    params.permit(:name, :score)
  end

  def pin_params
    params.permit(:pins)
  end

  def frame_params
    params.permit(:frame)
  end

  def set_game
    @game = Game.find(params[:game_id])
  end

  def set_game_player
    @player = @game.players.find_by!(id: params[:id]) if @game
  end
end
