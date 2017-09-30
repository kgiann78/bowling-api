require 'rails_helper'

RSpec.describe 'Frames API' do
  # Initialize the test data
  let!(:game) { create(:game) }
  let!(:player) { FactoryGirl.create(:player, name: "Vangelis", score: 10, game_id: game.id) }
  let!(:frames) { FactoryGirl.create_list(:frame, 10, score: 1, tries: 2, player_id: player.id) }
  # The following line is work arround when create_list above wasn't available
  # let!(:frames) { 10.times.map { |i| Frame.create!(number: i, score: 0, tries: 2, player_id: player.id ) } }

  let(:game_id) { game.id }
  let(:player_id) { player.id }
  let(:id) { frames.first.id }

  # Test suite for GET /games/:game_id/players/:player_id/frames
  describe 'GET /games/:game_id/players/:player_id/frames' do
    before { get "/games/#{game_id}/players/#{player_id}/frames" }

    context 'when game exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all player frames' do
        expect(json.size).to eq(20) 
        # The total frames should be 20 because when a player is created, 
        # 10 frames are created and assigned to him
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

    context 'when game player does not exists' do
      let(:player_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Player/)
      end
    end
  end

  # Test suite for GET /games/:game_id/players/:player_id/frames/:id
  describe 'GET /games/:game_id/players/:player_id/frames/:id' do
    before { get "/games/#{game_id}/players/#{player_id}/frames/#{id}" }

    context 'when player frame exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the frame' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when player frame does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Frame/)
      end
    end
  end

  # Test suite for POST /games/:game_id/players/:player_id/frames
  describe 'POST /games/:game_id/players/:player_id/frames' do
    let(:valid_attributes) { { number: 10, tries: 3, score: 10, player_id: "#{player_id}" } }

    context 'when request attributes are valid' do
      before { post "/games/#{game_id}/players/#{player_id}/frames", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/games/#{game_id}/players/#{player_id}/frames", params: {  } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Number can't be blank/)
      end
    end
  end

  # Test suite for PUT /games/:game_id/players/:player_id/frames/:id
  describe 'PUT /games/:game_id/players/:player_id/frames/:id' do
    let(:valid_attributes) { { number: 10, tries: 2, score: 20 } }

    before { put "/games/#{game_id}/players/#{player_id}/frames/#{id}", params: valid_attributes }

    context 'when frame exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the frame' do
        updated_frame = Frame.find(id)
        expect(updated_frame.score).to eq(20)
      end
    end

    context 'when the frame does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Frame/)
      end
    end
  end

  # Test suite for DELETE /games/:game_id/players/:player_id/frames/:id
  describe 'DELETE /games/:game_id/players/:player_id/frames/:id' do
    before { delete "/games/#{game_id}/players/#{player_id}/frames/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end