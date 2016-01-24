class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from 'Acl9::AccessDenied', :with => :negar_acesso

  def negar_acesso
    if current_user
      render :template => 'acesso_negado'
    else
      flash[:notice] = 'Acesso negado. Você precisa estar logado.'
      redirect_to login_path
    end
  end

  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(User)
      if (current_user.correntista_id.nil?)
        return new_correntista_path
      end
      correntista_path(current_user.correntista_id)
    else
      super
    end
  end

  # before_action :configure_permitted_parameters, if: :devise_controller?

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.for(:sign_up) << :name
  # end

  # Leia mais em: Ruby on Rails: Implementando Autenticação de Usuário http://www.devmedia.com.br/ruby-on-rails-implementando-autenticacao-de-usuario/32124#ixzz3xtdRfn00


end
