# Charger les packages ------------------------------------------

library(shiny)
library(bslib)
library(ggplot2)
library(sf)
library(tibble)

shapefile <-read_sf("communes/communesPolygon.shp")

shapefile1 <- as.data.frame(shapefile)
shapefile1


ui <- page_navbar( 
  title =  "OBSERVATOIRE DE L’ACHAT SOCIALEMENT RESPONSABLE À LA RÉUNION (2025) ",
  theme = bs_theme(bootswatch = "minty"),
  sidebar =  sidebarPanel(
    
    width = 12,
    
    imageOutput("image", height = 150), 
    
    checkboxGroupInput(
      "checkGroup",
      "Segment d'achat",
      choices = list("Travaux" = 1, "Services" = 2, "Fournitures" = 3, "Prestations intellectuelles" = 4),
      selected = 1),
    
    selectInput(
      "zone",
      "Sélectionnez la zone d'activité",
      choices = c("Nord", "Est", "Sud", "Ouest")),
    
    plotOutput("map", width = 180, height = 200)
    
    
  ),
  
  
  
  # Première page
  
  nav_panel("Statistiques générales", p(
    
    layout_column_wrap(height = "1px",
      value_box(title = "NOMBRE DE MARCHÉS ATTRIBUÉS EN 2025", value = "", height = 200, theme = "green"),
      value_box(title = "NOMBRE DE MARCHÉS AVEC UNE CONSIDÉRATION SOCIALE ATTRIBUÉS EN 2025", value = "", height = 200, theme = "green"),
      value_box(title = "NOMBRE TOTAL D'HEURES RÉALISÉES EN 2025", value = "",height = 200, theme = "blue"),
    ),
    
    layout_column_wrap(
      
      card(
        card_header("Les outils utilisés"),
        
      ),
      
      card(
        card_header("Les acteurs de l'asr")
      ),
      
      
    ),
    
    layout_column_wrap(
      
      
      card(
        card_header("Comment abordez-vous la loi climat et résilience qui sera effective en août 2026")
      )
      
    )
    
    )),
  
  # Deuxième page
  
  nav_panel("La clause sociale d'insertion", p(
    
    layout_column_wrap(height = "1px",
                       value_box(title = "NOMBRE DE MARCHÉS AVEC UNE CLAUSE SOCIALE D'INSERTION AYANT GÉNÉRÉS DES HEURES D'INSERTION EN 2025", value = "", height = 200, theme = "green"),
                       value_box(title = "NOMBRE D'HEURES D'INSERTION RÉALISÉES EN 2025", value = "", height = 200, theme = "blue"),
                       value_box(title = "NOMBRE DE BÉNÉFICIAIRES AYANT RÉALISÉ DES HEURES D'INSERTION EN 2025", value = "",height = 200, theme = "blue"),
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
      
      layout_column_wrap(height = "1px",
                         value_box(title = "NOMBRE DE MARCHÉS RÉSERVÉS ATTRIBUÉS EN 2025", value = "", height = 200, theme = "green"),
                         value_box(title = "NOMBRE DE MARCHÉS RÉSERVÉS SIAE ATTRIBUÉS EN 2025", value = "", height = 200, theme = "green"),
                         value_box(title = "NOMBRE DE MARCHÉS RÉSERVÉS STPA ATTRIBUÉS EN 2025", value = "",height = 200, theme = "green"),
      ),  
    
      
      layout_column_wrap(
        
        card(
          card_header("SIAE (STRUCTURES D'INSERTION PAR L'ACTIVITÉ ÉCONOMIQUE)"),
          
        ),
      ),
      
      layout_column_wrap(
        
        card(
          card_header("STPA (SECTEUR DU TRAVAIL PROTÉGÉ ET ADAPTÉ)"),
          
        ),
        
      ),
      
    
    
  )),
  
  
  # page 4
  
  nav_panel("La clause de stage", p(
    
    layout_column_wrap(height = "1px",
                       value_box(title = "NOMBRE DE MARCHÉS AYANT GÉNÉRÉS DES HEURES DE STAGE EN 2025", value = "", height = 200, theme = "green"),
                       value_box(title = "NOMBRE D'HEURES DE STAGE RÉALISÉES EN 2025", value = "", height = 200, theme = "blue"),
                       value_box(title = "NOMBRE DE STAGIAIRE EN 2025", value = "",height = 200, theme = "blue"),
    ),  
    
    
    
  )),
  
  # page 5
  
  nav_panel("Les critères d'attribution", p(
    
    layout_column_wrap(height = "1px",
                       value_box(title = "NOMBRE DE MARCHÉS AVEC UN CRITÈRE D'ATTRIBUTION SOCIAL ATTRIBUÉS EN 2025", value = "", height = 200, theme = "green"),
                       value_box(title = "NIVEAU MOYEN DE PONDÉRATION RELATIF AU CRITÈRE D'ATTRIBUTION SOCIAL (%)", value = "", height = 200, theme = "green"),
  
    ),  
    
    
    
  )),
  
  # page 6
  
  nav_panel("SPASER", p(
    
  ))
  
  # fin corps
  
  
)


# Define server logic required to draw a histogram ----
server <- function(input, output) {
  

  
  
output$image <- renderImage( 
    { 
      list(src = "logo.png", height = "30%") 
    }, 
    deleteFile = FALSE 
  ) 
  
# carte
 
output$map <- renderPlot({ 
    
    
    r <-  ggplot() + geom_sf(data=shapefile, color = "black") +
      geom_sf(data= shapefile[5,], color = "blue")+
      geom_sf(data= shapefile[2,], color = "blue")+
      geom_sf(data= shapefile[1,], color = "blue")+
      theme(axis.text.x = element_blank(), axis.text.y = element_blank())
    
    Nord <- ggplot() + geom_sf(data=shapefile, color = "black") +
      geom_sf(data= shapefile[5,], color = "black", fill="blue")+
      geom_sf(data= shapefile[2,], color = "black", fill="blue")+
      geom_sf(data= shapefile[1,], color = "black", fill="blue")+
      theme_minimal()+
      theme(axis.text.x = element_blank(), axis.text.y = element_blank())
    
    
    Est <- ggplot() + geom_sf(data=shapefile, color = "black") +
      geom_sf(data= shapefile[3,], color = "black", fill="blue")+
      geom_sf(data= shapefile[4,],  color = "black", fill="blue")+
      geom_sf(data= shapefile[6,],  color = "black", fill="blue")+
      geom_sf(data= shapefile[7,],  color = "black", fill="blue")+
      geom_sf(data= shapefile[8,],  color = "black", fill="blue")+
      geom_sf(data= shapefile[9,],  color = "black", fill="blue")+
      theme_minimal()+
      theme(axis.text.x = element_blank(), axis.text.y = element_blank())
    
    
    
    Sud <- ggplot() + geom_sf(data=shapefile, color = "black") +
      geom_sf(data= shapefile[19,], color = "black", fill="blue")+
      geom_sf(data= shapefile[15,],  color = "black", fill="blue")+
      geom_sf(data= shapefile[22,],  color = "black", fill="blue")+
      geom_sf(data= shapefile[16,],  color = "black", fill="blue")+
      geom_sf(data= shapefile[13,],  color = "black", fill="blue")+
      geom_sf(data= shapefile[24,],  color = "black", fill="blue")+
      geom_sf(data= shapefile[23,],  color = "black", fill="blue")+
      geom_sf(data= shapefile[14,],  color = "black", fill="blue")+
      geom_sf(data= shapefile[12,],  color = "black", fill="blue")+
      geom_sf(data= shapefile[21,],  color = "black", fill="blue")+
      theme_minimal()+
     theme(axis.text.x = element_blank(), axis.text.y = element_blank())
    
    Ouest <- ggplot() + geom_sf(data=shapefile, color = "black") +
      geom_sf(data= shapefile[10,], color = "black", fill="blue")+
      geom_sf(data= shapefile[11,],  color = "black", fill="blue")+
      geom_sf(data= shapefile[17,],  color = "black", fill="blue")+
      geom_sf(data= shapefile[18,],  color = "black", fill="blue")+
      geom_sf(data= shapefile[20,],  color = "black", fill="blue")+
      theme_minimal()+
      theme(axis.text.x = element_blank(), axis.text.y = element_blank())
    
    
    switch(input$zone,
           "Nord" = Nord,
           "Sud" = Sud,
           "Ouest" = Ouest,
           "Est" = Est
    )
    
  }) 
  
  
    
  
}


# Run the app ----
shinyApp(ui = ui, server = server)



