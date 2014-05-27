class Estudiante < ActiveRecord::Base

require 'rubygems'
require  'spreadsheet'

has_no_table
column :nombre, :string
column :email, :string


def leer_notas(cedula)
    connection = GoogleDrive.login(ENV["GMAIL_USERNAME"], ENV["GMAIL_PASSWORD"]) 
    ss = connection.spreadsheet_by_title('Contactos p')
    
    if ss.nil? 
       ss = connection.create_spreadsheet('Contactos p') 
    end 
   

        ws = ss.worksheets[0]   


    i = 1
    j = 0
    filas = ws.num_rows 
    notas = Array.new(3) 
    filas.times do 
        if ws[i,3] == cedula
            3.times do 
                notas[j] = ws[i,4+j]
                j = j + 1
            end 
        end     
        i = i+1   
       
    end    
     return notas
end 


  def subscripcion
    mailchimp = Gibbon::API.new
    result = mailchimp.lists.subscribe({
              :id => ENV['MAILCHIMP_LIST_ID'], :email => {
                    :email => self.email},
                    :double_optin => false,#confirmacion del coreeo enviado al suscriptor
                    :update_existing => true,
                    :send_welcome => true
             })

    end
end