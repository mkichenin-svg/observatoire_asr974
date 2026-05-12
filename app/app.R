# Charger les packages ------------------------------------------

library(shiny)
library(bslib)
library(ggplot2)
library(sf)
library(tibble)
library(bsicons)

shapefile <-read_sf("communes/communesPolygon.shp")

shapefile1 <- as.data.frame(shapefile)
shapefile1


ui <- page_navbar( 
  title = div("OBSERVATOIRE DE L’ACHAT SOCIALEMENT RESPONSABLE À LA RÉUNION ", class="custom title"), 
  # Custom CSS to change title size
  header = tags$style(HTML("
    .navbar .navbar-brand {
      font-size: 15px;       /* Change this value to adjust size */
      font-weight: bold;     /* Optional: make it bold */
      color: #2c3e50;        /* Optional: change text color */
    }
  ")),
  imageOutput("image", height = 140),
  theme = bs_theme(version = 5, bootswatch = "superhero"),
  sidebar =  sidebarPanel(
  width = 12,
  height = 12,
    
# output sidebar

    imageOutput("image", height = 140), 
    
     checkboxGroupInput(
      "checkGroup",
      "Segment d'achat",
      choices = list("Travaux" = 1, "Services" = 2, "Fournitures" = 3, "Prestations intellectuelles" = 4),
      selected = 1),


     selectInput(
     "zone",
      "Zone d'activité",
      choices = c( "Vue d'ensemble","Nord", "Est", "Sud", "Ouest", "2 à 4 zones")),

     plotOutput("map", width = 197, height = 197),
    
    
  ),
  
  
  
  # Première page
  
  nav_panel("Statistiques générales", p(
    
    layout_column_wrap(height = "1px",
      value_box(title = "NOMBRE DE STRUCTURES INTEROGÉES ET CONCERNÉES", value = "0", height = 75, theme = "blue",showcase = bsicons::bs_icon('building-check')),
      value_box(title = "NOMBRE DE MARCHÉS ATTRIBUÉS EN 2025", value = "0", height = 400, theme = "blue"),
     
    ),
    
    layout_column_wrap(height = "1px",
                       value_box(title = "NOMBRE DE MARCHÉS AVEC UNE CONSIDÉRATION SOCIALE ATTRIBUÉS EN 2025", value = "0", height = 400, theme = "blue", showcase = bsicons::bs_icon('hand-thumbs-up')),
                       value_box(title = "NOMBRE TOTAL D'HEURES RÉALISÉES EN 2025", value = "0",height = 400, theme = "teal", showcase = bsicons::bs_icon('clock-history')),
    ),
    
    
    layout_column_wrap(
      
      card(
        card_header("LES OUTILS ASR UTILISÉS"),
        plotOutput("outils", height = 75)
        
      ),
      
      card(
        card_header("Comment abordez-vous la loi climat et résilience (effective en août 2026)?"),
        plotOutput("", height = 87)
      )
      
      
    ),
    
    
    )),
  
  # Deuxième page
  
  nav_panel("La clause sociale d'insertion", p(
    
    layout_column_wrap(
                       value_box(title = "NOMBRE DE MARCHÉS AVEC UNE CLAUSE SOCIALE D'INSERTION AYANT GÉNÉRÉS DES HEURES D'INSERTION EN 2025", value = "0", height = 200, theme = "blue"),
                       value_box(title = "NOMBRE D'HEURES D'INSERTION RÉALISÉES EN 2025", value = "0", height = 200, theme = "teal",showcase = bsicons::bs_icon('clock-history')),
                       value_box(title = "NOMBRE DE BÉNÉFICIAIRES AYANT RÉALISÉ DES HEURES D'INSERTION EN 2025", value = "0",height = 200, theme = "teal",showcase = bsicons::bs_icon('person-check')),
    ),
    
    layout_column_wrap(
      
      card(
        card_header("Âge des bénéficiaires"),
        plotOutput("", height = 85)
        
      ),
    
      
      card(
        card_header("Hommes/Femmes"),
        plotOutput("", height = 85)
      ),
      
      card(
        card_header("Bénéficaires provenant des QPV"),
        plotOutput("", height = 85)
      ),
      
    ),
    
    layout_column_wrap(
      
      card(
        card_header("Niveau de qualification des bénérficaires"),
        plotOutput("", height = 85)
      ),
      
      card(
        card_header("Les types de contrats"),
        plotOutput("", height = 85)
        
      ),
     
    ),
    
    
    )),
  
  # Troisième page
  
  nav_panel("Les marchés réservés", p(
      
      layout_column_wrap(height = "1px",
                         value_box(title = "NOMBRE DE MARCHÉS RÉSERVÉS ATTRIBUÉS EN 2025", value = "0", height = 200, theme = "blue"),
                         value_box(title = "NOMBRE DE MARCHÉS RÉSERVÉS SIAE ATTRIBUÉS EN 2025", value = "0", height = 200, theme = "blue"),
                         value_box(title = "NOMBRE DE MARCHÉS RÉSERVÉS STPA ATTRIBUÉS EN 2025", value = "0",height = 200, theme = "blue"),
      ),  
    
      
      layout_column_wrap(
        
        card(
          card_header("SIAE (STRUCTURES D'INSERTION PAR L'ACTIVITÉ ÉCONOMIQUE)"),
          height = 90,
          layout_column_wrap(
            plotOutput("siae"),
            value_box(title = "Nombre d'heures SIAE valorisées en 2025", value = "0", height = 200, theme = "teal",showcase = bsicons::bs_icon('clock-history'))
            
            )
        ),
      ),
      
      layout_column_wrap(
        
        card(
          card_header("STPA (SECTEUR DU TRAVAIL PROTÉGÉ ET ADAPTÉ)"),
          height = 90,
          layout_column_wrap(
          plotOutput("stpa"),
          value_box(title = "Nombre d'heures STPA valorisées en 2025", value = "0", height = 200, theme = "teal",showcase = bsicons::bs_icon('clock-history'))
          
          )
        ),
        
      ),
      
    
    
  )),
  
  
  # page 4
  
  nav_panel("La clause de stage", p(
    
    layout_column_wrap(height = "1px",
                       value_box(title = "NOMBRE DE MARCHÉS AYANT GÉNÉRÉS DES HEURES DE STAGE EN 2025", value = "0", height = 200, theme = "blue"),
                       value_box(title = "NOMBRE D'HEURES DE STAGE RÉALISÉES EN 2025", value = "0", height = 200, theme = "teal",showcase = bsicons::bs_icon('clock-history')),
                       value_box(title = "NOMBRE DE STAGIAIRE EN 2025", value = "0",height = 200, theme = "teal",showcase = bsicons::bs_icon('person-check')),
    ),  
    
    
    layout_column_wrap(
      
      card(
        card_header("Types de stagiaires"),
        p("Lycéens? Étudiants? Demandeurs d'emploi?"),
      ),

      
      card(
        card_header("Durée des stages"),
        p("< 1 mois, 1 à 3 mois, 4 à 6 mois, + 6 mois")
      
      ),
      
    ),  
    
    
  )),
  
  # page 5
  
  nav_panel("Les critères d'attribution", p(
    
    layout_column_wrap(height = "1px",
                       value_box(title = "NOMBRE DE MARCHÉS AVEC UN CRITÈRE D'ATTRIBUTION SOCIAL ATTRIBUÉS EN 2025", value = "0", height = 200, theme = "blue"),
                       value_box(title = "NIVEAU MOYEN DE PONDÉRATION RELATIF AU CRITÈRE D'ATTRIBUTION SOCIAL (%)", value = "0", height = 200, theme = "teal"),
  
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
      geom_sf(data= shapefile[5,], color = "black")+
      geom_sf(data= shapefile[2,], color = "black")+
      geom_sf(data= shapefile[1,], color = "black")+
      geom_sf(data= shapefile[3,], color = "black")+
      geom_sf(data= shapefile[4,],  color = "black")+
      geom_sf(data= shapefile[6,],  color = "black")+
      geom_sf(data= shapefile[7,],  color = "black")+
      geom_sf(data= shapefile[8,],  color = "black")+
      geom_sf(data= shapefile[9,],  color = "black")+
      geom_sf(data= shapefile[19,], color = "black")+
      geom_sf(data= shapefile[15,],  color = "black")+
      geom_sf(data= shapefile[22,],  color = "black")+
      geom_sf(data= shapefile[16,],  color = "black")+
      geom_sf(data= shapefile[13,],  color = "black")+
      geom_sf(data= shapefile[24,],  color = "black")+
      geom_sf(data= shapefile[23,],  color = "black")+
      geom_sf(data= shapefile[14,],  color = "black")+
      geom_sf(data= shapefile[12,],  color = "black")+
      geom_sf(data= shapefile[21,],  color = "black")+
      geom_sf(data= shapefile[10,], color = "black")+
      geom_sf(data= shapefile[11,],  color = "black")+
      geom_sf(data= shapefile[17,],  color = "black")+
      geom_sf(data= shapefile[18,],  color = "black")+
      geom_sf(data= shapefile[20,],  color = "black")+
      theme_minimal()+
      theme(axis.text.x = element_blank(), 
            axis.text.y = element_blank())
    
    Nord <- ggplot() + geom_sf(data=shapefile, color = "black") +
      geom_sf(data= shapefile[5,], color = "black", fill="royalblue")+
      geom_sf(data= shapefile[2,], color = "black", fill="royalblue")+
      geom_sf(data= shapefile[1,], color = "black", fill="royalblue")+
      theme_minimal()+
      theme(axis.text.x = element_blank(), axis.text.y = element_blank())
    
    
    Est <- ggplot() + geom_sf(data=shapefile, color = "black") +
      geom_sf(data= shapefile[3,], color = "black", fill="royalblue")+
      geom_sf(data= shapefile[4,],  color = "black", fill="royalblue")+
      geom_sf(data= shapefile[6,],  color = "black", fill="royalblue")+
      geom_sf(data= shapefile[7,],  color = "black", fill="royalblue")+
      geom_sf(data= shapefile[8,],  color = "black", fill="royalblue")+
      geom_sf(data= shapefile[9,],  color = "black", fill="royalblue")+
      theme_minimal()+
      theme(axis.text.x = element_blank(), axis.text.y = element_blank())
    
    
    
    Sud <- ggplot() + geom_sf(data=shapefile, color = "black") +
      geom_sf(data= shapefile[19,], color = "black", fill="royalblue")+
      geom_sf(data= shapefile[15,],  color = "black", fill="royalblue")+
      geom_sf(data= shapefile[22,],  color = "black", fill="royalblue")+
      geom_sf(data= shapefile[16,],  color = "black", fill="royalblue")+
      geom_sf(data= shapefile[13,],  color = "black", fill="royalblue")+
      geom_sf(data= shapefile[24,],  color = "black", fill="royalblue")+
      geom_sf(data= shapefile[23,],  color = "black", fill="royalblue")+
      geom_sf(data= shapefile[14,],  color = "black", fill="royalblue")+
      geom_sf(data= shapefile[12,],  color = "black", fill="royalblue")+
      geom_sf(data= shapefile[21,],  color = "black", fill="royalblue")+
      theme_minimal()+
     theme(axis.text.x = element_blank(), axis.text.y = element_blank())
    
    Ouest <- ggplot() + geom_sf(data=shapefile, color = "black") +
      geom_sf(data= shapefile[10,], color = "black", fill="royalblue")+
      geom_sf(data= shapefile[11,],  color = "black", fill="royalblue")+
      geom_sf(data= shapefile[17,],  color = "black", fill="royalblue")+
      geom_sf(data= shapefile[18,],  color = "black", fill="royalblue")+
      geom_sf(data= shapefile[20,],  color = "black", fill="royalblue")+
      theme_minimal()+
      theme(axis.text.x = element_blank(), axis.text.y = element_blank())
    
    
multi <-  ggplot() + geom_sf(data=shapefile, color = "black", fill="royalblue") +
      geom_sf(data= shapefile[5,], color = "black", fill="royalblue")+
      geom_sf(data= shapefile[2,], color = "black", fill="royalblue")+
      geom_sf(data= shapefile[1,], color = "black", fill="royalblue")+
      geom_sf(data= shapefile[3,], color = "black", fill="royalblue")+
      geom_sf(data= shapefile[4,],  color = "black", fill="royalblue")+
      geom_sf(data= shapefile[6,],  color = "black", fill="royalblue")+
      geom_sf(data= shapefile[7,],  color = "black", fill="royalblue")+
      geom_sf(data= shapefile[8,],  color = "black", fill="royalblue")+
      geom_sf(data= shapefile[9,],  color = "black", fill="royalblue")+
      geom_sf(data= shapefile[19,],color = "black",fill="royalblue")+
      geom_sf(data= shapefile[15,],  color = "black", fill="royalblue")+
      geom_sf(data= shapefile[22,],  color = "black", fill="royalblue")+
      geom_sf(data= shapefile[16,],  color = "black",fill="royalblue")+
      geom_sf(data= shapefile[13,],  color = "black",fill="royalblue")+
      geom_sf(data= shapefile[24,],  color = "black",fill="royalblue")+
      geom_sf(data= shapefile[23,],  color = "black",fill="royalblue")+
      geom_sf(data= shapefile[14,],  color = "black",fill="royalblue")+
      geom_sf(data= shapefile[12,],  color = "black",fill="royalblue")+
      geom_sf(data= shapefile[21,],  color = "black",fill="royalblue")+
      geom_sf(data= shapefile[10,], color = "black",fill="royalblue")+
      geom_sf(data= shapefile[11,],  color = "black",fill="royalblue")+
      geom_sf(data= shapefile[17,],  color = "black",fill="royalblue")+
      geom_sf(data= shapefile[18,],  color = "black",fill="royalblue")+
      geom_sf(data= shapefile[20,],  color = "black",fill="royalblue")+
      theme_minimal()+
      theme(axis.text.x = element_blank(), axis.text.y = element_blank())
    
    
    switch(input$zone,
           "Vue d'ensemble" = r,
           "Nord" = Nord,
           "Sud" = Sud,
           "Ouest" = Ouest,
           "Est" = Est,
           "2 à 4 zones" = multi
    )
    
  }) 
  
# stat général
 
output$outils <- renderPlot( 
  { 
    ggplot() + geom_line()
  }) 

#marchés réservés

output$siae <- renderPlot( 
  { 
    ggplot() + geom_line() +ggtitle("TYPES DE STRUCTURES SIAE")
  }) 




output$stpa <- renderPlot( 
  { 
    ggplot() + geom_line() +ggtitle("TYPES DE STRUCTURES STPA")
  }) 


output$hstpa <- renderPlot( 
  { 
    ggplot() + geom_line() +ggtitle("Heures d'insertions STPA valorisés")
  }) 

  
}



# Run the app ----
shinyApp(ui = ui, server = server)



