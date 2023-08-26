require 'rails_helper'

RSpec.describe GameMatchesController, type: :controller do
  describe "GET show" do
    it "returns http success" do
      # Crie um novo objeto GameMatch e salve-o no banco de dados
      game_match = GameMatch.create!(name: "Sample Game", score: 100)

      # Chame a ação 'show' e passe o ID do objeto criado
      get :show, params: { id: game_match.id }

      # Verifique se a resposta é bem-sucedida (HTTP status 200)
      expect(response).to have_http_status(:success)
    end
  end
end


