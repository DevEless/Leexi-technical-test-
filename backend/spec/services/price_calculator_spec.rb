# spec/services/price_calculator_spec.rb
require 'rails_helper'

# Test unitaire du module PriceCalculator
RSpec.describe PriceCalculator do
  describe '.calculate' do

    # Cas : plan "ai_meeting", moins de 10 licences
    it 'calcule le prix pour AI Meeting avec moins de 10 licences' do
      result = described_class.calculate(5, 'ai_meeting', 'annually')

      # Prix mensuel = 5 licences * 29€
      expect(result[:monthly]).to eq(5 * 29)

      # En annuel, pour ai_meeting, pas de remise => juste * 12
      expect(result[:annually]).to eq((5 * 29 * 12).round(2))
    end

    # Cas : plan "ai_meeting", entre 10 et 49 licences
    it 'calcule le prix pour AI Meeting avec 10 à 49 licences' do
      result = described_class.calculate(10, 'ai_meeting', 'annually')

      # 10 licences * 25€
      expect(result[:monthly]).to eq(10 * 25)

      # Pas de remise en annuel pour ai_meeting
      expect(result[:annually]).to eq((10 * 25 * 12).round(2))
    end

    # Cas : plan "ai_meeting", 50 licences ou plus
    it 'calcule le prix pour AI Meeting avec 50 licences ou plus' do
      result = described_class.calculate(50, 'ai_meeting', 'annually')

      # 50 licences * 15€
      expect(result[:monthly]).to eq(50 * 15)

      # Pas de remise en annuel
      expect(result[:annually]).to eq((50 * 15 * 12).round(2))
    end

    # Cas : plan "enterprise", entre 10 et 49 licences
    it 'calcule le prix pour Enterprise avec 10 à 49 licences' do
      result = described_class.calculate(10, 'enterprise', 'annually')

      # 10 licences * 55€
      expect(result[:monthly]).to eq(10 * 55)

      # En annuel, remise de 10% => *12 puis *0.9
      expect(result[:annually]).to eq((10 * 55 * 12 * 0.9).round(2))
    end

    # Cas : plan "enterprise", 50 licences ou plus
    it 'calcule le prix pour Enterprise avec 50 licences ou plus' do
      result = described_class.calculate(50, 'enterprise', 'annually')

      # 50 licences * 40€
      expect(result[:monthly]).to eq(50 * 40)

      # En annuel, remise de 10%
      expect(result[:annually]).to eq((50 * 40 * 12 * 0.9).round(2))
    end

    # Cas : plan "enterprise" avec moins de 10 licences => doit échouer
    it 'lève une erreur pour Enterprise avec moins de 10 licences' do
      expect {
        described_class.calculate(5, 'enterprise', 'monthly')
      }.to raise_error('Le plan Enterprise requiert au moins 10 licences')
    end

    # Cas : plan inconnu => doit échouer
    it 'lève une erreur pour un plan inconnu' do
      expect {
        described_class.calculate(10, 'inconnu', 'monthly')
      }.to raise_error('Plan inconnu')
    end
  end
end
