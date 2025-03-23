require 'rails_helper'

RSpec.describe PriceCalculator do
  describe '.calculate' do
    context 'Plan AI Meeting' do
      it 'calcule le prix avec moins de 10 licences (mensuel)' do
        resultat = described_class.calculate(5, 'ai_meeting', 'monthly')
        expect(resultat[:monthly]).to eq(5 * 29)
      end

      it 'calcule le prix avec 20 licences (annuel, sans remise)' do
        resultat = described_class.calculate(20, 'ai_meeting', 'annually')
        expect(resultat[:annually]).to eq((20 * 25 * 12).round(2))
      end
    end

    context 'Plan Enterprise' do
      it 'calcule le prix avec 10 licences (annuel, avec remise)' do
        resultat = described_class.calculate(10, 'enterprise', 'annually')
        expect(resultat[:annually]).to eq((10 * 55 * 12 * 0.9).round(2))
      end

      it 'calcule le prix avec 15 licences (mensuel)' do
        resultat = described_class.calculate(15, 'enterprise', 'monthly')
        expect(resultat[:monthly]).to eq(15 * 55)
      end

      it 'lève une erreur avec moins de 10 licences' do
        expect {
          described_class.calculate(5, 'enterprise', 'monthly')
        }.to raise_error('Le plan Enterprise requiert au moins 10 licences')
      end
    end

    context 'Plan inconnu' do
      it 'lève une erreur pour un plan non valide' do
        expect {
          described_class.calculate(10, 'inconnu', 'monthly')
        }.to raise_error('Plan inconnu')
      end
    end
  end
end
