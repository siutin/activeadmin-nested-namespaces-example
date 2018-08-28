class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  protected

  def after_sign_in_path_for(resource)
    if self.is_a?(ActiveAdmin::Devise::SessionsController) && resource.is_a?(AdminUser)
      stored_location_for(devise_mapping.name)
    else
      super
    end
  end

  def after_sign_out_path_for(resource)
    if self.is_a?(ActiveAdmin::Devise::SessionsController)
      request.referrer
    else
      super
    end
  end

end
