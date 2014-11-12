# Esqueleto de aplicación con creación, edición, carga y descarga de data.frame
# Autor: Manuel Muñoz Márquez (manuel.munoz@uca.es)
# Licencia: GNU-GPL >= 3
# Proyecto: Proyecto R-UCA (http://knuth.uca.es/R)
#
library(shiny)
#library(orloca)

# Definición de la interfaz para la recogida de datos
shinyUI(pageWithSidebar(

  # Título de la aplicación
  headerPanel("Esqueleto de aplicación con creación, edición, carga y descarga de data.frame"),

  # Definición del panel lateral para la introducción de datos
  sidebarPanel(
    a('Menú Principal', href='http://knuth.uca.es/shiny/'),
    selectInput('action', 'Acción', c('Añadir columna', 'Añadir fila', 'Borrar columna', 'Borrar fila', 'Cargar datos', 'Renombrar columna', 'Renombrar fila', 'Reiniciar'), selected = 5),
    conditionalPanel(condition = "input.action == 'Añadir columna'", textInput('col.name', 'Nombre:', value = '')),
#    conditionalPanel(condition = "input.action == 'Añadir columna'", selectInput('col.type', 'Tipo:', c('Numérico'))),
    conditionalPanel(condition = "input.action == 'Borrar columna'", numericInput('col.del', 'Columna a borrar:', value = '')),
    conditionalPanel(condition = "input.action == 'Borrar fila'", numericInput('row.del', 'Fila a borrar:', value = '')),
    conditionalPanel(condition = "input.action == 'Renombrar columna'", numericInput('col.mv', 'Columna a renombrar:', value = '')),
    conditionalPanel(condition = "input.action == 'Renombrar fila'", numericInput('row.mv', 'Fila a renombrar:', value = '')),
    conditionalPanel(condition = "input.action == 'Cargar datos'", fileInput(inputId = "input.file", label = "Fichero:", accept =c("txt/csv", "text/comma-separated-values,text/plain", ".csv"))), 
    actionButton('goButton', 'Hacer'),
    hr(),
    downloadButton('downloadData', 'Descargar datos')
  ),

  # Muestra los resultados
  mainPanel(
      tabsetPanel(
          tabPanel('Información',
                   p("Aplicación que permite la carga de un fichero csv con datos. Ha sido desarrollada para ser rehusada como esqueleto para nuevas aplicaciones."),
                   p("Para comenzar introduzca los valores de los parámetros, seleccione una acción y pulse en el botón \"Hacer\". Seleccione la pestaña que desea visualizar. Puede introducir nuevos valores y se actualizarán los resultados automáticamente."),
                   p("Realizado con shiny por", a("M. Muñoz-Márquez", href="mailto:manuel.munoz@uca.es"), "bajo licencia GNU-GPL como parte del", a("Proyecto R-UCA", href="http://knuth.uca.es/R"), "."),
                   hr(),
                   p("This application allows load a csv data file. It has been developed as starting point for new applications."),
                   p("To start input values for parameters, select an action, and press \"Hacer\". Select the tab to show. You can enter new values and the results will be updated automatically."),
                   p("Developed using shiny by", a("M. Muñoz-Márquez", href="mailto:manuel.munoz@uca.es"), "under GNU-GPL licence inside ", a("R-UCA Project", href="http://knuth.uca.es/R"), ".")
                   ),
          tabPanel('Datos',
                   tableOutput('Data')
          ),
          tabPanel('Gráfico',
                   plotOutput("Plot")
          ),
          tabPanel('Solución',
                   tableOutput('Solution')
          )
       )      
    )
))
