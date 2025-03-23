
class PriceCalculator
  def self.calculate(number_of_licenses, plan)
    number_of_licenses = number_of_licenses.to_i
#Boucle avec condition pour le calcul total
    price_per_license = case plan
                        when 'ai_meeting'
                          if number_of_licenses < 10
                            29
                          elsif number_of_licenses < 50
                            25
                          else
                            15
                          end
                        when 'enterprise'
                          raise 'Le plan Enterprise requiert au moins 10 licences' if number_of_licenses < 10
                          number_of_licenses < 50 ? 55 : 40
                        else
                          raise 'Plan inconnu'
                        end

    monthly_total  = number_of_licenses * price_per_license
    annually_total = (monthly_total * 12 * 0.9).round(2)

    {
      monthly: monthly_total,
      annually: annually_total
    }
  end
end
