# Esqueleto de aplicación con entrada, salida y modificación de data.frame
# Autor: Manuel Muñoz Márquez (manuel.munoz@uca.es)
# Licencia: GNU-GPL >= 3
# Proyecto: Proyecto R-UCA (http://knuth.uca.es/R)
#
library(shiny)

# Initialize data
data <- data.frame()

# Define la lógica para el cálculo de los resultados
# Los datos de entrada se reciben en input
# Los resultados se guardan en output
shinyServer(function(input, output) {
  # renderPlot muestra la gráfica y la convierte en reactiva, es decir,
  dataInput <- reactive({
      input$goButton
      isolate(if (input$action == 'Reiniciar') data <<- data.frame())
      isolate(if (input$action == 'Cargar datos' && !is.null(input$input.file$datapath)) isolate(data <<- read.csv(input$input.file$datapath)))
      isolate(if (input$action == 'Borrar fila') {
        if (input$row.del > 0 && input$row.del <= nrow(data)) data <<- data[-input$row.del,]
      })
      isolate(if (input$action == 'Borrar columna') {
        if (input$col.del > 0 && input$col.del <= nrow(data)) data <<- data[,-input$col.del]
      })
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
  output$Solution <- renderTable({
     data <- dataInput()
     if (nrow(data) > 0) {
         summary(data)
     }
  })
                                
})
