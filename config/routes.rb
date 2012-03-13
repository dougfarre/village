Vms::Application.routes.draw do
  devise_for :users

	match '/fix_ajaxterm', :to => 'application#fix_ajaxterm', :as => 'fix_ajaxterm'

	match '/slots/import_shifts_function', :to => 'slots#import_shift_function', :as => 'import_shift_function'
	
	match '/events/maintain', :to => 'events#maintain', :as => 'maintain'

	match '/home/email_send', :to => 'home#email_send', :as => 'email_send'

	match '/volunteers/unassociate_event', :to => 'volunteers#unassociate_event', :as => 'unassociate_event'

	match '/volunteers/emailer', :to => 'volunteers#emailer', :as => 'volunteer_emailer' 

	match '/volunteers/send_emailer', :to => 'volunteers#send_emailer', :as => 'volunteer_send_emailer' 
	
	match '/volunteers/volunteer_invite', :to => 'volunteers#volunteer_invite', :as => 'volunteer_invite'

	match '/volunteers/save_volunteer_invite', :to => 'volunteers#save_volunteer_invite', :as => 'save_volunteer_invite'
	
	match '/volunteers/volunteer_dashboard', :to => 'volunteers#volunteer_dashboard', :as => 'volunteer_dashboard'
	
	match '/volunteers/associate_event', :to => 'volunteers#associate_event', :as => 'associate_event' 

	match '/volunteers/volunteer_mixer', :to => 'volunteers#volunteer_mixer', :as => 'volunteer_mixer'

	match '/volunteers/save_volunteers', :to => 'volunteers#save_volunteers', :as => 'save_volunteers'

	match '/volunteers/availability', :to => 'volunteers#availability', :as => 'availability' 

	match '/avails/save_volunteers_to_area', :to => 'avails#save_volunteers_to_area', :as => 'save_volunteers_to_area' 

	match '/areas/get_areas', :to => 'areas#get_areas', :as => 'get_areas'

	match '/home/index', :to => 'home#index', :as => 'index'

	match '/home/ajax_index', :to => 'home#ajax_index', :as => 'ajax_index'
	  
  resources :volunteers

  resources :avails

  resources :shifts

  resources :slots

  resources :areas

	resources :data_files

  resources :events do
  	resources :villages do
			resources :areas
		end
	end

  	resources :villages do
			resources :areas
		end
	
  # get "home/index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
