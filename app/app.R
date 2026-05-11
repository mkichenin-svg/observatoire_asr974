# Charger les packages ------------------------------------------

library(shiny)
library(bslib)
library(ggplot2)

library(sf)





ui <- page_navbar( 
  title =  "Observatoire de l'achat socialement responsable ",
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
  
  nav_panel("Statistiques générales", p(
    
    layout_column_wrap(height = "1px",
      value_box(title = "NOMBRE DE MARCHÉS ATTRIBUÉS EN 2025", value = "", height = 200, theme = "blue"),
      value_box(title = "NOMBRE DE MARCHÉS AVEC UNE CONSIDÉRATION SOCIALE ATTRIBUÉS EN 2025", value = "", height = 200),
      value_box(title = "NOMBRE TOTAL D'HEURES RÉALISÉES EN 2025", value = "",height = 200),
    ),
    
    layout_column_wrap(
      
      card(
        card_header("Les outils utilisés"),
        
      ),
      
      card(
        card_header("Les acteurs de l'asr")
      ),
      
      card(
        card_header("Comment abordez-vous la loi climat et résilience qui sera effective en août 2026")
      )
      
    ))),
  
  # Deuxième page
  
  nav_panel("La clause sociale d'insertion", p(
    
    layout_column_wrap(height = "1px",
                       value_box(title = "NOMBRE DE MARCHÉS AVEC UNE CLAUSE SOCIALE D'INSERTION AYANT GÉNÉRÉS DES HEURES D'INSERTION EN 2025", value = "", height = 200, theme = "blue"),
                       value_box(title = "NOMBRE D'HEURES D'INSERTION RÉALISÉES EN 2025", value = "", height = 200),
                       value_box(title = "NOMBRE DE BÉNÉFICIAIRES AYANT RÉALISÉ DES HEURES D'INSERTION EN 2025", value = "",height = 200),
    ),
    
    layout_column_wrap(
      
      card(
        card_header("Âge des bénéficiaires"),
        
      ),
      
      card(
        card_header("QPV")
      ),
      
      card(
        card_header("Qualification")
      ),
      card(
        card_header("Homme/Femmes")
      ),
    ),
    
    layout_column_wrap(
      
      card(
        card_header("Les types de contrats"),
        
      ),
     
    ),
    
    
    )),
  
  # Troisième page
  
  nav_panel("Les marchés réservés", p(
    
    
    
  )),
  
  
  # page 4
  
  nav_panel("La clause de stage", p(
    
    
    
  )),
  
  # page 5
  
  nav_panel("Les critères d'attribution", p(
    
    
    
  )),
  
  # page 6
  
  nav_panel("SPASER", p(
    
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



