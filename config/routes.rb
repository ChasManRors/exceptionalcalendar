ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'meetings'

  map.resources :meetings do |meeting|
    meeting.resources :participants
  end

  map.resources :credits
  
end
