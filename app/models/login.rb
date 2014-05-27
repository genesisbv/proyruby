class Login < ActiveRecord::Base
has_no_table

column :usuario, :string
column :contrasena, :string

validates_presence_of :usuario, message: "Debe ingresar un usuario"
validates_presence_of :contrasena, message: "Debe ingresar una contrasena"

/validamos si el usuario y la contrasena coinciden y si son prof o est./
def validarLogin
	@respuesta = Array.new(2) 
	@respuesta[0] = nil

	case
	when (usuario == "gene" and contrasena == "1234") 
		@respuesta[0] = 1
		@respuesta[1] = 1

	when(usuario == "leo" and contrasena == "1234") 
		@respuesta[0] = 1
		@respuesta[1] = 2

	when(usuario == "ani" and contrasena == "1234")
		@respuesta[0] = 1
		@respuesta[1] = 3

	when(usuario == "fabi" and contrasena == "1234") 
		@respuesta[0] = 22547654
		@respuesta[1] = 1

	when(usuario == "humberto" and contrasena == "1234")
		@respuesta[0] = 6452722
		@respuesta[1] = 2

	when (usuario == "paul" and contrasena == "1234")
		@respuesta[0] = 343443
		@respuesta[1] = 3
	
	else
		@respuesta[0] = nil
	end	

	return @respuesta
end			




end