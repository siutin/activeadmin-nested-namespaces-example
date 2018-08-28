def register_namespaces(*namespaces, &block)
  namespaces.each do |namespace|
    (namespace.is_a?(Array) ? namespace.reverse : [namespace])
        .inject(Proc.new { block.call(namespace) if block && block.is_a?(Proc) }) { |n, c| Proc.new { namespace c, &n } }.call
  end
end

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  register_namespaces(:site1, :site2, [:site3, :demo]) do |namespace|
    devise_for :admin_users, ActiveAdmin::Devise.config
  end
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
