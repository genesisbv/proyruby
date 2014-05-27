class Profesor < ActiveRecord::Base

require 'rubygems'
require  'spreadsheet'

has_no_table
column :ruta, :string

validates_presence_of :ruta, message: "Debe seleccionar una materi"

 /metodo para caragar archivo de excel/ 
 def uploadFile(materia)
    Spreadsheet.client_encoding = 'UTF-8'
    book = Spreadsheet.open '../calculo2.xls'

    if materia ==1
       sheet = book.worksheet 0
    else
        if materia == 2
           sheet = book.worksheet 1  
        else
           sheet = book.worksheet 2
        end
    end
    
    j=1
    
    sheet.each do |row|
        /aca llamamos al metodo para escribir en el drive por cada fila del excel/
        actualizar_hoja_calculo(row, j)
        j=j+1
    end
     
 end

/metodo para escribir en google drive/
 def actualizar_hoja_calculo(nombres, filas)
    connection = GoogleDrive.login(ENV["GMAIL_USERNAME"], ENV["GMAIL_PASSWORD"]) 
    ss = connection.spreadsheet_by_title('Contactos p')
    
    if ss.nil? 
       ss = connection.create_spreadsheet('Contactos p') 
    end 

     
    if materia ==1
       ws = ss.worksheets[0] 
    else
        if materia == 2
            ws = ss.worksheets[1]     
        else
            ws = ss.worksheets[2]
        end
    end        
    i = 1
    nombres.each do |info|
        if filas==1 
            ws[filas , i] = info
            if i==6
                filas = filas+1
            end        
        else     
            ws[filas, i] = info
        end
         i = i+1 
         ws.save 
    end  
end 

/metodo que sirve para leer las notas de todos los estudiantes del drive/
def leer_notas(materia)
    connection = GoogleDrive.login(ENV["GMAIL_USERNAME"], ENV["GMAIL_PASSWORD"]) 
    ss = connection.spreadsheet_by_title('Contactos p')
    
    if ss.nil? 
       ss = connection.create_spreadsheet('Contactos p') 
    end 
   

    ws = ss.worksheets[0]   


    i = 2
    
    filas = ws.num_rows 
    notas = Array.new(filas-1)

    filas.times do
        j = 1
        estudiante = Array.new(6)
        6.times do 
            estudiante[j-1] = ws[i,j]
            j = j + 1
        end   

        notas[i] = estudiante

        i = i+1 
    end    
     return notas
end 


end