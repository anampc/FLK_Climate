#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyjs)
library(RMySQL)
library(data.table)

# Define UI for application that retrieves data from the AOML Coral database
ui <- fluidPage(
    useShinyjs(),

    # Application title
    titlePanel("AOML Coral Database Example"),
    mainPanel(
    fluidRow(
        column(4,actionButton("button.1database","Step 1: Database/Local")),
        column(8,textOutput("text.1database"))),
    fluidRow(
        column(4,actionButton("button.2runquery","Step 2: Run Query")),
        column(8,dataTableOutput("datatable.2runquery"))))
)

# Define server logic required to access AOML Coral data
server <- function(input, output) {

    # Database/Local parameters: login to database
    # (these are suggested/default values for the user)
    database.vals <- reactiveValues(
        username = "coraluser",
        database = "accretedb",
        machine = "coraldepot.aoml.noaa.gov",
        portnum = 3306,
        mydb = NULL
    )
    
    # RunQuery parameters: sample data to query from the database
    runquery.vals <- reactiveValues(
        dt = NULL
    )
    
    # Step 1: modal dialog to login to database
    observeEvent(input$button.1database, {
        database.dialog <- modalDialog(
            title = "Enter Database Connection details",
            textInput("text.username", "Database username:", value=database.vals$username),
            passwordInput("password", "Database password:"),
            textInput("text.database", "Database name:", value=database.vals$database),
            textInput("text.machine", "Machine name:", value=database.vals$machine),
            numericInput("numeric.portnum", "Port Number:", value=database.vals$portnum),
            footer = tagList(actionButton("button.database.ok", "OK"))
        )
        showModal(database.dialog)
    })
    
    # Step 2: run query!
    observeEvent(input$button.2runquery, {
        # run the query and populate the display table
        bottle.data = dbGetQuery(database.vals$myDB, "SELECT *
FROM bot_final_query_with_ph_v
WHERE project_code = 'Cheeca CalVal - Oct 2019'
AND avg_dic_kg_corrected IS NOT NULL
AND avg_ta_kg_corrected IS NOT NULL")
        
        # create data.table with selected columns
        runquery.vals$dt = data.table(sample_id=bottle.data$sample_id,
                                      bottle=bottle.data$bottle_letters,
                                      Sal=bottle.data$calc_salinity,
                                      DIC=bottle.data$avg_dic_kg_corrected,
                                      TA=bottle.data$avg_ta_kg_corrected)

        output$datatable.2runquery <- renderDataTable({runquery.vals$dt})
    })

    # Processing the inputs from Step 1 (database login dialog)
    observeEvent(input$button.database.ok, {
        database.vals$username = input$text.username
        database.vals$database = input$text.database
        database.vals$machine = input$text.machine
        database.vals$portnum = input$numeric.portnum
        removeModal()
        
        # disconnect from database if already connected
        if (!is.null(database.vals$myDB)) {
            dbDisconnect(database.vals$myDB)
        }
        
        # connect to database! grab its version info to prove we connected
        tryCatch({
            database.vals$myDB <- dbConnect(MySQL(), user=database.vals$username, password=input$password, dbname=database.vals$database, host=database.vals$machine, port=database.vals$portnum)
            dbVersion <- dbGetQuery(database.vals$myDB, "select VERSION()")[[1]]
            output$text.1database <- renderText({paste0("Successfully connected to MySQL database v",dbVersion)})
        }, warning = function(w){
            output$text.1database <- renderText({paste0("MySQL warning [",w,"]")})
        }, error = function(e) {
            output$text.1database <- renderText({paste0("MySQL errpr [",e,"]")})
        })
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
