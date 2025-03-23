Rails.application.routes.draw do
  #crée un préfixe pour toutes les routes définies a l'intérieur du bloc
  namespace :v1 do
    #indique a rails que les controleurs correspondants sont dans le module v1
    post 'prices', to: 'prices#create'
  end
end
