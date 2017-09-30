require 'rails_helper'

RSpec.describe 'Players API' do
  # Initialize the test data
  let!(:game) { create(:game) }
  let!(:players) { FactoryGirl.create_list(:player, 20, score: 10, game_id: game.id) }
  # let!(:players) { 20.times.map { |i| Player.create!(name: "player_#{i}", score: 4, game_id: game.id ) } }

  let(:game_id) { game.id }
  let(:id) { players.first.id }

  # Test suite for GET /games/:game_id/players
  describe 'GET /games/:game_id/Players' do
    before { get "/games/#{game_id}/players" }

    context 'when game exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all game players' do
        expect(json.size).to eq(20)
      end
    end

    context 'when game does not exist' do
      let(:game_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Game/)
      end
    end
  end

  # Test suite for GET /games/:game_id/players/:id
  describe 'GET /games/:game_id/players/:id' do
    before { get "/games/#{game_id}/players/#{id}" }

    context 'when game player exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the player' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when game player does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Player/)
      end
    end
  end

  # Test suite for POST /games/:game_id/players
  describe 'POST /games/:game_id/players' do
    let(:valid_attributes) { { name: 'Visit Narnia', score: 10, game_id: "#{game_id}" } }

    context 'when request attributes are valid' do
      before { post "/games/#{game_id}/players", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/games/#{game_id}/players", params: {  } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  # Test suite for PUT /games/:game_id/players/:id
  describe 'PUT /games/:game_id/players/:id' do
    let(:valid_attributes) { { name: 'Mozart', score: 13 } }

    before { put "/games/#{game_id}/players/#{id}", params: valid_attributes }

    context 'when player exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the player' do
        updated_player = Player.find(id)
        expect(updated_player.name).to match(/Mozart/)
      end
    end

    context 'when the player does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Player/)
      end
    end
  end

  # Test suite for DELETE /games/:game_id/players/:id
  describe 'DELETE /games/:game_id/players/:id' do
    before { delete "/games/#{game_id}/players/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end