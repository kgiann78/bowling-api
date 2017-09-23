class PlayersController < ApplicationController
  before_action :set_game
  before_action :set_game_player, only: [:show, :update, :destroy]

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

  private

  def player_params
    params.permit(:name, :score)
  end

  def set_game
    @game = Game.find(params[:game_id])
  end

  def set_game_player
    @player = @game.players.find_by!(id: params[:id]) if @game
  end
end
