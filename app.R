# Load packages used by the app. Install missing packages, if needed.
library(shiny)
library(bslib)
library(thematic)
library(tidyverse)
library(gitlink)




# load data

# Dessiner le tableau de bord

ui <- page_sidebar(
  title =  "TABLEAU DE BORD DE VOS VENTES", 
  sidebar = sidebar("Les services",
                    
                    selectInput(
                      "var",
                      label = "Choisir une zone",
                      choices = 
                        c("Nord",
                          "Sud",
                          "Est",
                          "Ouest", "Plusieurs zones"),
                      selected =  c("Nord",
                                    "Sud",
                                    "Est",
                                    "Ouest", "Plusieurs zones")
                    ),
                    
                  
                    
  ),
  
  card(
    card_header("Département fruit/légumes"),
    textOutput("selected_montant"),
    textOutput("selected_var")
    
  ),
  card(
    card_header("Département épicerie"),
    
  ),
)

# Création du serveur

server <- function (input,output, session) { 
  
  output$selected_var <- renderText({
    paste("Zone d'activité :", input$var)
  })
  
  output$selected_montant <- renderText({
    paste("Montant:", input$Montant)
    
    
  })
  
}


# Déclenchement de l'application

shinyApp(ui = ui, server = server)

rsconnect::writeManifest()
shiny::runApp(appDir = "C:\Users\mkichenin\Desktop\Observatoire\Observatoire_quantitatif\observatoire_asr974")
