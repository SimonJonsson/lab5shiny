sheet <- read_excel("data/2014_riksdagsval_per_valdistrikt.xls")
viz <- elect_viz$new(data = sheet)

#' The UI for the shiny application
#' @return a fluidPage object
#' @export
ui <- fluidPage(
  titlePanel("Swedish Election Results"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "county", label = strong("Trend index"),
                  choices = viz$get_counties(),
                  selected = viz$get_county())
    ),
    mainPanel(
      plotOutput(outputId = "distPlot")
    )
  )
)

#' The server component for the shiny application. Doing the backend of the visualization.
#' @param input Takes a Shiny input source
#' @param output Takes a shiny output source
#' @export
server <- function(input, output) {
  output$distPlot <- renderPlot({
    viz$set_county(input$county)
    p_vals <- viz$get_mean_p_vals()
    barplot(p_vals,
            main=viz$get_county(),
            col = c("#029CDB",
                    "#1E784E",
                    "#006AB2",
                    "#0059D8",
                    "#ED1B34",
                    "#FE0000",
                    "#0DA94B",
                    "#009DDC",
                    "#D93D96",
                    "black"))
  })
}

shinyApp(ui = ui, server = server)

#' Dataset containing all the election results of each election district from the Swedish elections 2014
#' @name 2014_riksdagsval_per_valdistrikt.xls
#' @source \url{http://www.val.se/val/val2014/statistik/index.html}
NULL

#' @title Visual Interaction Tool For Swedish Election Results
#'
#' @description
#' Implements an interactive tool for the Swedish election results where you can
#' see the results for each muniplicity. The default select is Stockholms Kommun.
#' Uses the elect_viz package
#'
#' @name lab5
#' @docType package
NULL

