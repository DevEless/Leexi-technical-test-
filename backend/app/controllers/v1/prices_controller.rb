class V1::PricesController < ApplicationController
    # Contrôleur API (hérite d'ActionController::API en mode API)
    def create
      number = params[:number_of_licenses].to_i
      plan   = params[:plan]
      period = params[:period]  # ce paramètre n'est pas utilisé dans le calcul, mais pourrait servir à d'autres fins
      
      # Validation basique des paramètres requis
      if number <= 0 || plan.nil? || period.nil?
        render json: { error: 'Paramètres invalides' }, status: :bad_request
        return
      end
  
      # Règle spéciale !! le plan Enterprise requiert au moins 10 licences
      if plan == 'enterprise' && number < 10
        render json: { error: 'Le plan Enterprise requiert au moins 10 licences' }, status: :unprocessable_entity
        return
      end
  
      # Calcul des prix via le service dédié
      result = PriceCalculator.calculate(number, plan)
      render json: { prices: result }, status: :ok
    rescue StandardError => e
      # Gestion d'erreur (par exemple plan inconnu)
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end
  