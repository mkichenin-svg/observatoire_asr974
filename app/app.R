# Charger les packages ------------------------------------------

library(shiny)
library(reactable)
library(bslib)
library(bsicons)
library(shiny)
library(reticulate)
library(rnaturalearth)
library(rnaturalearthdata)
library(maps)
library(mapdata)
library(treemap)
library(treemapify)
library(cowplot)
library(ggplot2)
library(sf)
library(viridisLite)
library(here)
library(jsonlite)


ui <- page_navbar( 
  title =  "Observatoire ASR ",
  theme = bs_theme(bg = "white", fg = "black", primary = "blue",
                   base_font = font_google("Space Mono"),
                   code_font = font_google("Space Mono")),
  
  sidebar =  sidebarPanel(
    
    width = 250,
    
    imageOutput("image", height = 150), 
    
    checkboxGroupInput(
      "checkGroup",
      "Segment d'achat",
      choices = list("Travaux" = 1, "Services" = 2, "Fournitures" = 3, "Prestations intellectuelles" = 4),
      selected = 1),
    
    selectInput(
      "zone",
      "Sélectionnez la zone d'activité",
      choices = c("Nord", "Sud", "Ouest", "Est")),
    
    plotOutput("map", width = 250, height = 250)
    
    
  ),
  
  
  
  # Première page
  
  nav_panel("", p(
    
    layout_column_wrap(
      value_box(title = "", value = "", height = 50),
      value_box(title = "", value = ""),
      value_box(title = "", value = ""),
    ),
    
    layout_column_wrap(
      
      card(
        card_header(""),
        
      ),
      
      card(
        card_header("")
      ),
      
      card(
        card_header("")
      ),
      
      card(
        card_header("")
      )
      
      
    ))),
  
  # Deuxième page
  
  nav_panel("", p("Content for Page ")),
  
  # Troisième page
  
  nav_panel("", p(
    
    
    
  ))
  
  # fin corps
  
  
)


# Define server logic required to draw a histogram ----
server <- function(input, output) {
  
  # Histogram of the Old Faithful Geyser Data ----
  # with requested number of bins
  # This expression that generates a histogram is wrapped in a call
  # to renderPlot to indicate that:
  #
  # 1. It is "reactive" and therefore should be automatically
  #    re-executed when inputs (input$bins) change
  # 2. Its output type is a plot
  output$distPlot <- renderPlot({
    
    x    <- faithful$waiting
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    hist(x, breaks = bins, col = "#007bc2", border = "white",
         xlab = "Waiting time to next eruption (in mins)",
         main = "Histogram of waiting times")
    
  })
  
}


# Run the app ----
shinyApp(ui = ui, server = server)



