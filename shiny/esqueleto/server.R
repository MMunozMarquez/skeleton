## Esqueleto de aplicación con creación, edición, carga y descarga de un conjunto de datos (data.frame)
## Autor: Manuel Muñoz Márquez (manuel.munoz@uca.es)
## Licencia: GNU-GPL >= 3
## Proyecto: Proyecto R-UCA (http://knuth.uca.es/R)
## Versión on-line: http://knuth.uca.es/shiny/esqueleto/
## Repositorio: http://knuth.uca.es/repos/R-contribuciones/shiny/esqueleto/
##

## Load common functions
source('common.R')

## Load user function
source('user.R')

## Load libraries
require('readODS')
require('xlsx')

## Define la lógica para el cálculo de los resultados
## Los datos de entrada se reciben en input
## Los resultados se guardan en output
shinyServer(function(input, output) {
    
    ## Initialize data
    data <- new.data()

    ## renderPlot muestra la gráfica y la convierte en reactiva, es decir,
    dataInput <- reactive({
        input$goButton
        action <- isolate(input$action)
        col.number <- isolate(ifelse(is.numeric(input$col.number), round(input$col.number), 0))
        new.name <- isolate(input$new.name)
        new.value <- isolate(input$new.value)
        col.type <- isolate(input$col.type)
        row.number <- isolate(ifelse(is.numeric(input$row.number), round(input$row.number), 0))
        if (action == actions['add_column'] && new.name != '') {
            .data <- switch(col.type,
                            Numérico = ,
                            Numeric = as.numeric(rep(NA, nrow(data))),
                            Factor = as.factor(as.numeric(rep(NA, nrow(data)))),
                            Carácter = ,
                            Character = as.character(rep(NA, nrow(data)))
                            )
            .data <- data.frame(.data, stringsAsFactors = FALSE)
            colnames(.data) <- new.name
            if (ncol(data) > 0) {
                data <<- cbind(data, .data)
            } else {
                data <<- .data
            }
        }
        if (action == actions['add_row'] && ncol(data) > 0) {
            if (ncol(data) > 0) data[nrow(data)+1,] <<- rep(NA, ncol(data))
        }
        if (action == actions['delete_cell'] && row.number > 0 && row.number <= nrow(data) && col.number > 0 && col.number <= ncol(data)) data[row.number, col.number] <<- NA
        if (action == actions['edit_cell'] && new.value != '' && row.number > 0 && row.number <= nrow(data) && col.number > 0 && col.number <= ncol(data)) {
            if (is.numeric(data[, col.number])) {
                new.value <- as.numeric(new.value)
                if (!is.na(new.value)) data[row.number, col.number] <<- new.value
            } else {
                if (is.factor(data[, col.number])) {
                    .factor <- data[, col.number]
                    .factor <- factor(.factor, levels = unique(c(levels(.factor), new.value)))
                    .factor[row.number] <- new.value
                    data[, col.number] <<- .factor
                } else data[row.number, col.number] <<- new.value
            }
        }
        if (action == actions['drop_column'] && col.number > 0 && col.number <= ncol(data)) data[,col.number] <<- NULL
        if (action == actions['drop_row'] && row.number > 0 && row.number <= nrow(data)) data <<- data[-row.number,]
        if (action == actions['load_data'] && !isolate(is.null(input$input.file$datapath))) {
            sep <- isolate(input$input.sep)
            sep <- ifelse(sep == text['space'], ' ', sep)
            dec <- isolate(input$input.dec)
            data <<- read.csv(isolate(input$input.file$datapath), sep = sep, dec = dec, stringsAsFactors = FALSE)
        }
        if (action == actions['load_example']) data <<- read.csv(isolate(input$example.file), stringsAsFactors = FALSE)
        if (action == actions['reset']) data <<- new.data()
        if (action == actions['rename_column'] && new.name != '' && col.number > 0 && col.number <= ncol(data)) colnames(data)[col.number] <<- new.name
        if (action == actions['rename_row'] && new.name != '' && row.number > 0 && row.number <= nrow(data)) rownames(data)[row.number] <<- new.name
        if (action == actions['renumerate_row'] && nrow(data) > 0) rownames(data) <<- 1:nrow(data)
        if (action == actions['transform_into_factor'] && col.number > 0  && col.number <= ncol(data)) data[, col.number] <<- as.factor(data[,col.number])
        data
    })
    
    ## se recalcula cuando cambian los parámetros de entrada
    output$Graphic <- renderPlot({
        dataInput()
        graphic.plot(data)
    })

    ## Output data
    output$Data <- renderTable({
        dataInput()
        data
    })
    
    ## Output solution
    output$Results <- renderPrint({
        dataInput()
        results(data)
    })

    ## Download data
    output$downloadData <- downloadHandler(
        filename = function() {
            paste('data-', Sys.Date(), isolate(input$file.type), sep='')
        },
        content = function(file) {
            filetype <- isolate(input$file.type)
            if (filetype == '.csv') {
                write.csv(data, file = file, row.names = FALSE)
            } else if (filetype == '.ods') {
                write_ods(data, path = file, row_names = FALSE)
            } else if (filetype == '.xls') {
                write.xlsx(data, file = file, row.names = FALSE)
            }
        }
    )
    
    
})
