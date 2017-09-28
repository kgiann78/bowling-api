class FramesController < ApplicationController
  before_action :set_game
  before_action :set_game_player
  before_action :set_game_player_frame, only: [:show, :update, :destroy, :roll]

  # GET /games/:game_id/players/:player_id/frames
  def index
    json_response(@player.frames)
  end

  # GET /games/:game_id/players/:player_id/frames/:id
  def show
    json_response(@frame)
  end

  # POST /games/:game_id/players/:player_id/frames
  def create
    @frame = @player.frames.find_or_create_by!(number: frame_params[:number], player_id: @player.id)
    json_response(@frame, :created)
  end

  # PUT /games/:game_id/players/:player_id/frames/:id
  def update
    @frame.update(frame_params)
    head :no_content
  end

  # DELETE /games/:game_id/players/:player_id/frames/:id
  def destroy
    @frame.destroy
    head :no_content
  end

  private

  def frame_params
    params.permit(:number, :tries, :score)
  end

  def set_game
    @game = Game.find(params[:game_id])
  end

  def set_game_player
    @player = @game.players.find_by!(id: params[:player_id]) if @game
  end

  def set_game_player_frame
    @frame = @player.frames.find_by!(id: params[:id]) if @player
  end
end
