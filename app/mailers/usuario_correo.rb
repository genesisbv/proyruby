class UsuarioCorreo < ActionMailer::Base
  default from: "do-not-replay@example.com"

  def contacto_email(contacto)
  	#contacto.email es el correo del visitante
  	#owner_email email del propetario del site configurado en figara
  	@contacto = contacto
  	mail(to: ENV["OWNER_EMAIL"],from: @contacto.email,:subject => "Contacto Mascota")
  end
end
