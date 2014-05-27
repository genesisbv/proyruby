class ProfesorsController < ApplicationController 

	def new 
		@profesor = Profesor.new	

	end

	def create
		@profesor = Profesor.new(secure_params)
		if @profesor.valid?
			materia = session[:materia]
			Rails.logger.info(materia)
			@profesor.uploadFile(materia)
			flash[:notice] = "cargado archivo"	
		else
			flash[:notice] = "archivo vacio"	
		end	
		redirect_to action: 'new'

	end

	/metodo para listar todas las notas de todos los estudiantes/
	def leer_notas
		if session[:nombre] == nil
			flash[:notice] = "logearse para continuar"
			redirect_to :controller => 'logins', :action => 'new'
			
		else
			@profesor = Profesor.new()
			@notas = @profesor.leer_notas(session[:materia])
			render 'verNotas'	
		end	
	end


	private 
	def secure_params
		params.require(:profesor).permit(:ruta)
	end



end