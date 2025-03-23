require 'rails_helper'

RSpec.describe PriceCalculator do
  #chargement de l'environement rails
  describe '.calculate' do
    #calculate sert a organier les tests 
    it 'calcule le prix pour AI Meeting avec moins de 10 licences' do
      result = described_class.calculate(5, 'ai_meeting')
      expect(result[:monthly]).to eq(5 * 29)
      expect(result[:annually]).to eq((5 * 29 * 12 * 0.9).round(2))
    end

    it 'calcule le prix pour AI Meeting avec 10 à 49 licences' do
      result = described_class.calculate(10, 'ai_meeting')
      expect(result[:monthly]).to eq(10 * 25)
      expect(result[:annually]).to eq((10 * 25 * 12 * 0.9).round(2))
    end

    it 'calcule le prix pour AI Meeting avec 50 licences ou plus' do
      result = described_class.calculate(50, 'ai_meeting')
      expect(result[:monthly]).to eq(50 * 15)
      expect(result[:annually]).to eq((50 * 15 * 12 * 0.9).round(2))
    end

    it 'calcule le prix pour Enterprise avec 10 à 49 licences' do
      result = described_class.calculate(10, 'enterprise')
      expect(result[:monthly]).to eq(10 * 55)
      expect(result[:annually]).to eq((10 * 55 * 12 * 0.9).round(2))
    end

    it 'calcule le prix pour Enterprise avec 50 licences ou plus' do
      result = described_class.calculate(50, 'enterprise')
      expect(result[:monthly]).to eq(50 * 40)
      expect(result[:annually]).to eq((50 * 40 * 12 * 0.9).round(2))
    end

    it 'lève une erreur pour Enterprise avec moins de 10 licences' do
      expect {
        described_class.calculate(5, 'enterprise')
      }.to raise_error('Le plan Enterprise requiert au moins 10 licences')
    end

    it 'lève une erreur pour un plan inconnu' do
      expect {
        described_class.calculate(10, 'inconnu')
      }.to raise_error('Plan inconnu')
    end
  end
end
