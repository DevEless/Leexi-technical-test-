class PriceCalculator
  def self.calculate(nombre_licences, plan, _periode = nil)
    nombre_licences = nombre_licences.to_i

    case plan
    when 'enterprise'
      raise 'Le plan Enterprise requiert au moins 10 licences' if nombre_licences < 10

      # Définition du tarif en fonction des paliers
      prix_unitaire = if nombre_licences >= 50
                        40
                      else
                        55
                      end
    when 'ai_meeting'
      prix_unitaire = if nombre_licences >= 50
                        15
                      elsif nombre_licences >= 10
                        25
                      else
                        29
                      end
    else
      raise 'Plan inconnu'
    end

    prix_mensuel = prix_unitaire * nombre_licences
    prix_annuel = (prix_mensuel * 12).round(2)

    # Remise de 10% uniquement pour plan enterprise en annuel
    prix_annuel *= 0.9 if plan == 'enterprise'

    {
      monthly: prix_mensuel,
      annually: prix_annuel.round(2)
    }
  end
end
