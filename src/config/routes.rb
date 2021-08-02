Rails.application.routes.draw do

devise_for :users

root to: 'staticpages#top'

resources :users do
end


end
