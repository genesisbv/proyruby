class EstudiantesController < ApplicationController 


	def new 
		if session[:nombre] == nil
			flash[:notice] = "logearse para continuar"
			redirect_to :controller => 'logins', :action => 'new'
		else
			@estudiante = Estudiante.new()	

		end	
	end


	def create
		if session[:nombre] == nil
			flash[:notice] = "logearse para continuar"
			redirect_to :controller => 'logins', :action => 'new'
			
		else
			@estudiante = Estudiante.new()
			render 'new'
		end
	end

	/metodo para listar las notas del estudiante logeado/
	def verNotas
		if session[:nombre] == nil
			flash[:notice] = "logearse para continuar"
			redirect_to :controller => 'logins', :action => 'new'
			
		else
			@estudiante = Estudiante.new()
			@cedula = session[:cedula]
			@notas = @estudiante.leer_notas("#{@cedula}")
			render 'verNotas'	
		end	
	end

	/metodo para suscribirse a una lista de correos de una materia/
	def suscribirse
		if session[:nombre] == nil
			flash[:notice] = "logearse para continuar"
			redirect_to :controller => 'logins', :action => 'new'
			
		else
			@estudiante = Estudiante.new(secure_params)
			if @estudiante.subscripcion
				flash[:notice] = "registrado en nuestra lista de correo"
				render 'new'
			else
				flash[:notice] = "No se pudo registrar en nuestra lista de correo"
				render 'new'
			end
		end
	end	

	private 
	def secure_params
		params.require(:estudiante).permit(:email)
	end
		

end