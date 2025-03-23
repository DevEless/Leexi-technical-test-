module V1
  class PricesController < ApplicationController
    # Action pour calculer un prix en fonction des paramètres reçus.
    def create
      # Récupération et normalisation des paramètres requis depuis la requête.
      plan = params[:plan]                      
      period = params[:period]                  
      licenses = params[:number_of_licenses].to_i 
      
      # Vérification que le plan est bien reconnu parmi les plans supportés.
      allowed_plans = ['enterprise', 'ai_meeting']
      unless allowed_plans.include?(plan)
        # Si le plan est inconnu, on renvoie une réponse JSON d'erreur avec un statut 422 (Unprocessable Entity).
        render json: { error: 'Unknown plan' }, status: :unprocessable_entity and return
      end
      
      # Vérification que la période est valide (mensuel ou annuel).
      allowed_periods = ['monthly', 'annually']
      unless allowed_periods.include?(period)
        # Si la période est invalide, on renvoie un message d'erreur approprié (422).
        render json: { error: 'Unknown period. Must be monthly or annually' }, status: :unprocessable_entity and return
      end
      
      # Vérification que le nombre de licences est suffisant (au moins 1).
      if licenses < 1
        # Si le nombre de licences est inférieur à 1, on renvoie un message d'erreur (422).
        render json: { error: 'Number of licenses must be at least 1' }, status: :unprocessable_entity and return
      end
      
      # Règle métier : le plan "enterprise" nécessite un minimum de 10 licences.
      if plan == 'enterprise' && licenses < 10
        # Si on a moins de 10 licences pour le plan enterprise, on renvoie un message d'erreur (422).
        render json: { error: 'Enterprise plan requires at least 10 licenses' }, status: :unprocessable_entity and return
      end
      
      # Appel du service PriceCalculator pour calculer le prix total avec les 3 paramètres.
      price = PriceCalculator.calculate(licenses, plan, period)
      
      # Envoi de la réponse JSON avec le prix calculé et un statut 200 (OK) pour indiquer le succès.
      render json: { price: price }, status: :ok
    end
  end
end
