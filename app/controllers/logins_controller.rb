class LoginsController < ApplicationController 

	def new 
		@login = Login.new	

	end

	def create
		@login = Login.new(secure_params)
		@respuesta = @login.validarLogin 
		case 

		when (@respuesta[0] == 1)
			session[:nombre] = @login[:usuario]
			session[:materia] = @respuesta[1]
			redirect_to :controller => 'profesors', :action => 'new'

		when (@respuesta[0] > 1)
			session[:nombre] = @login[:usuario]
			session[:cedula] = @respuesta[0]
			session[:materia] = @respuesta[1]
			redirect_to :controller => 'estudiantes', :action => 'new'
			
		else			
			flash[:notice] = "ESTE USUARIO NO ESTA REGISTRADO"
			session[:nombre] = nil
			redirect_to root_path
		end	
		
	end

	/metodo para cerrar sesion/
	def logout
		@login = Login.new
		session[:nombre] == nil
		session[:materia] == nil
		session[:cedula] == nil
		render 'new'

	end
	
	private 
	def secure_params
		params.require(:login).permit(:usuario, :contrasena)
	end

	


end