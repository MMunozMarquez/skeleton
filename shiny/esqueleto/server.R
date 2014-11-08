# Esqueleto de aplicación con entrada, salida y modificación de data.frame
# Autor: Manuel Muñoz Márquez (manuel.munoz@uca.es)
# Licencia: GNU-GPL >= 3
# Proyecto: Proyecto R-UCA (http://knuth.uca.es/R)
#
library(shiny)

# Define la lógica para el cálculo de los resultados
# Los datos de entrada se reciben en input
# Los resultados se guardan en output
shinyServer(function(input, output) {
  # renderPlot muestra la gráfica y la convierte en reactiva, es decir,
  dataInput <- reactive({
      input$goButton
      data <- data.frame()
      isolate(if (input$action == 'Cargar datos' && !is.null(input$input.file$datapath)) isolate(data <- read.csv(input$input.file$datapath)))
      data
  })
  # se recalcula cuando cambian los parámetros de entrada
  output$Plot <- renderPlot({
      data <- dataInput()
      if (nrow(data) > 0) {
          plot(data, main = '')
      } else plot.new()
  })

# Output demand points
  output$Data <- renderTable({
      data <- dataInput()
  })
  
# Output solution
  output$Solucion <- renderTable({
     data <- dataInput()
     summary(data)
  })
                                
})
