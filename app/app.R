# Charger les packages ------------------------------------------

library(shiny)
library(bslib)
library(ggplot2)
library(sf)
library(tibble)
library(bsicons)
library(dplyr)
library(remotes)
library(htmlwidgets)
library(htmltools)
library(shinymanager)



# define some credentials

 credentials <- data.frame(
 user = c(""),
 password = c(""),
 stringsAsFactors = FALSE)


####################################### -> CHARGEMENT DES DONNÉES ####################

shapefile <- read_sf("communes/communesPolygon.shp", options = "ENCODING=LATIN1")

shapefile1 <- as.data.frame(shapefile)
shapefile1


data1 <- read.csv2("data_obs.csv")
data1 <- as.data.frame(data1)

age <- read.csv2("age1.csv")
age

diplome <- read.csv2("diplome.csv")
diplome

genre_est <- read.csv2("genre.csv")
genre_est

modalité_embauche <- read.csv2("modalité_embauche.csv")
modalité_embauche

outil <- read.csv2("outils.csv")
outil

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
  
  theme = bs_theme(version = 5, bootswatch = "sandstone"),
  sidebar =  sidebarPanel(
  width = 12,
    
# output sidebar

    imageOutput("image", height = 140), 
    
    # checkboxGroupInput(
    #  "checkGroup",
    # "Segment d'achat",
    #choices = list("Travaux" = 1, "Services" = 2, "Fournitures" = 3, "Prestations intellectuelles" = 4),
    #selected = 1),


     selectInput(
     "zone",
      "Zone d'activité",
      choices = c( "Vue d'ensemble","Nord", "Est", "Sud", "Ouest", "+ d'une zone")),

     plotOutput("map", width = 197, height = 197),

  ),
  
################################################################ Page1: STATISTIQUES GÉNÉRALES ######################################################################

  nav_panel("Statistiques générales", 
    p(layout_column_wrap(value_box(title = "NOMBRE DE STRUCTURES INTERROGÉES ET CONCERNÉES", value = uiOutput("structure"), height = 7, theme = "teal",showcase = bsicons::bs_icon('building-check')),
                        value_box(title =  "NOMBRE DE MARCHÉS ATTRIBUÉS EN 2025", value = uiOutput("attribués"), height = 7, theme = "blue"),
                        value_box(title = "NOMBRE DE MARCHÉS AVEC UNE CONSIDÉRATION SOCIALE ATTRIBUÉS EN 2025", value = uiOutput("considération"), height = 7, theme = "blue", showcase = bsicons::bs_icon('hand-thumbs-up'))
              
    ),
    
    layout_column_wrap(height = "10px",
      card(
        card_header("LES OUTILS ASR UTILISÉS"),
        plotOutput("outils", height = 100)
      ),
      
      card(
        card_header("Comment abordez-vous la loi climat et résilience (effective en août 2026)?"),
        plotOutput("nuage", height = 100)
      )
    ),
    
    )),

############################################################# Page 2 : CLAUSE SOCIALES D'INSERTION  #####################################################
  
  nav_panel("La clause sociale d'insertion", p(layout_column_wrap(
                       value_box(title = "NOMBRE DE MARCHÉS AVEC UNE CLAUSE SOCIALE D'INSERTION AYANT GÉNÉRÉS DES HEURES D'INSERTION EN 2025", value = uiOutput("nbre_csi"), height = 200, theme = "blue"),
                       value_box(title = "NOMBRE D'HEURES D'INSERTION RÉALISÉES EN 2025", value = uiOutput("heures_csi"), height = 200, theme = "teal",showcase = bsicons::bs_icon('clock-history')),
                       value_box(title = "NOMBRE DE BÉNÉFICIAIRES AYANT RÉALISÉ DES HEURES D'INSERTION EN 2025", value =uiOutput("bénéficiaires_csi") ,height = 200, theme = "teal",showcase = bsicons::bs_icon('person-check')),
                       value_box(title = "NOMBRE DE BÉNÉFICIAIRES ISSUES D'UN QPV", value =uiOutput("qpv") ,height = 200, theme = "teal",showcase = bsicons::bs_icon('buildings')),
    ),
    
    layout_column_wrap(
      
      card(
        card_header("Âge des bénéficiaires"),
        plotOutput("âge", height = 85)
      ),
    
      card(
        card_header("Hommes/Femmes"),
        plotOutput("sexe", height = 85)
      ),
      
    ),
    
    layout_column_wrap(
      
      card(
        card_header("Niveau de qualification des bénéficiaires"),
        plotOutput("qualification", height = 85)
      ),
      
      card(
        card_header("Les types de contrats"),
        plotOutput("contrats", height = 85)
        
      ),
     
    ),
    
    )),


############################################################### page3: LES MARCHÉS RÉSERVÉS ###############################################
  
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
            plotOutput("siae")
        ),
        
        card(
          card_header("STPA (SECTEUR DU TRAVAIL PROTÉGÉ ET ADAPTÉ)"),
          height = 90,
          plotOutput("stpa")
        ),
        
      ),
      
  )),
  
  
################################################################## Page 4 : LA CLAUSE DE STAGE ###################################################
  
  nav_panel("La clause de stage", p(
    
    layout_column_wrap(height = "200",
                       value_box(title = "NOMBRE DE MARCHÉS AYANT GÉNÉRÉ DES HEURES DE STAGE EN 2025", value = "0", height = 200, theme = "blue"),
                       value_box(title = "NOMBRE D'HEURES DE STAGE RÉALISÉES EN 2025", value = "0", height = 200, theme = "teal",showcase = bsicons::bs_icon('clock-history')),
                       value_box(title = "NOMBRE DE STAGIAIRES EN 2025", value = "0",height = 200, theme = "teal",showcase = bsicons::bs_icon('person-check')),
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
  
  ################################################################ page 5 : LES CRITÉRES D'ATTRIBUTION ###############################################
  
  nav_panel("Les critères d'attribution", p(
    
    layout_column_wrap(height = "1px",
                       value_box(title = "NOMBRE DE MARCHÉS AVEC UN CRITÈRE D'ATTRIBUTION SOCIAL ATTRIBUÉS EN 2025", value = "0", height = 200, theme = "blue"),
                       value_box(title = "NIVEAU MOYEN DE PONDÉRATION RELATIF AU CRITÈRE D'ATTRIBUTION SOCIAL (%)", value = "0", height = 200, theme = "teal"),
  
    ),  
    
  ))
  

  
##################################################################### FIN DE CORPS ##################################################################
  
)


#################################################################### WRAP  UI WITH SECURE APP ######################################

ui <- secure_app(ui, choose_language ="", language = "fr",
                 tags_top =
                 tags$div(
                     tags$h4("OBSERVATOIRE DE L'ACHAT SOCIALEMENT RESPONSABLE", style = "align:center"),
          
                   )
)  
                 

######################################################################### SERVEUR ###################################################################

server <- function(input, output) {

output$image <- renderImage( 
    { 
      list(src = "logo.png", height = "30%") 
    }, 
    deleteFile = FALSE 
  ) 
  
output$image2 <- renderImage( 
  { 
    list(src = "logo.png", height = "15%", margin(b=1, t=1)) 
  }, 
  deleteFile = FALSE 
) 

######################################################################## -> CARTE #########################################################
 
output$map <- renderPlot({ 
  
r <- ggplot() + geom_sf(data=shapefile, color = "black", fill="#25a36f") +
    geom_sf(data= shapefile[5,], color = "black", fill="#25a36f")+
    geom_sf(data= shapefile[2,], color = "black", fill="#25a36f")+
    geom_sf(data= shapefile[1,], color = "black", fill="#25a36f")+
    geom_sf(data= shapefile[3,], color = "black", fill="#25a36f")+
    geom_sf(data= shapefile[4,],  color = "black", fill="#25a36f")+
    geom_sf(data= shapefile[6,],  color = "black", fill="#25a36f")+
    geom_sf(data= shapefile[7,],  color = "black", fill="#25a36f")+
    geom_sf(data= shapefile[8,],  color = "black", fill="#25a36f")+
    geom_sf(data= shapefile[9,],  color = "black", fill="#25a36f")+
    geom_sf(data= shapefile[19,],color = "black",fill="#25a36f")+
    geom_sf(data= shapefile[15,],  color = "black", fill="#25a36f")+
    geom_sf(data= shapefile[22,],  color = "black", fill="#25a36f")+
    geom_sf(data= shapefile[16,],  color = "black",fill="#25a36f")+
    geom_sf(data= shapefile[13,],  color = "black",fill="#25a36f")+
    geom_sf(data= shapefile[24,],  color = "black",fill="#25a36f")+
    geom_sf(data= shapefile[23,],  color = "black",fill="#25a36f")+
    geom_sf(data= shapefile[14,],  color = "black",fill="#25a36f")+
    geom_sf(data= shapefile[12,],  color = "black",fill="#25a36f")+
    geom_sf(data= shapefile[21,],  color = "black",fill="#25a36f")+
    geom_sf(data= shapefile[10,], color = "black",fill="#25a36f")+
    geom_sf(data= shapefile[11,],  color = "black",fill="#25a36f")+
    geom_sf(data= shapefile[17,],  color = "black",fill="#25a36f")+
    geom_sf(data= shapefile[18,],  color = "black",fill="#25a36f")+
    geom_sf(data= shapefile[20,],  color = "black",fill="#25a36f")+
    theme_minimal()+
    theme(axis.text.x = element_blank(), axis.text.y = element_blank())
    
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
    
Sud <-   ggplot() + geom_sf(data=shapefile, color = "black") +
         geom_sf(data= shapefile[14,],  color = "black", fill="royalblue")+
         geom_sf(data= shapefile[15,],  color = "black", fill="royalblue")+
         geom_sf(data= shapefile[16,],  color = "black", fill="royalblue")+
         geom_sf(data= shapefile[21,],  color = "black", fill="royalblue")+
         geom_sf(data= shapefile[23,],  color = "black", fill="royalblue")+
         geom_sf(data= shapefile[13,],  color = "black", fill="royalblue")+
         theme_minimal()+
         theme(axis.text.x = element_blank(), axis.text.y = element_blank())

Sud_2 <- ggplot() + geom_sf(data=shapefile, color = "black") +  
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
    
multi <- ggplot() + geom_sf(data=shapefile, color = "black", fill="royalblue") +
         geom_sf(data= shapefile[5,], color = "black", fill="royalblue")+
         geom_sf(data= shapefile[2,], color = "black", fill="royalblue")+
         geom_sf(data= shapefile[1,], color = "black", fill="royalblue")+
         geom_sf(data= shapefile[3,], color = "black", fill="royalblue")+
         geom_sf(data= shapefile[4,], color = "black", fill="royalblue")+
         geom_sf(data= shapefile[6,], color = "black", fill="royalblue")+
         geom_sf(data= shapefile[7,], color = "black", fill="royalblue")+
         geom_sf(data= shapefile[8,], color = "black", fill="royalblue")+
         geom_sf(data= shapefile[9,], color = "black", fill="royalblue")+
         geom_sf(data= shapefile[19,],color = "black",fill="royalblue")+
         geom_sf(data= shapefile[15,],color = "black", fill="royalblue")+
         geom_sf(data= shapefile[22,],color = "black", fill="royalblue")+
         geom_sf(data= shapefile[16,],color = "black",fill="royalblue")+
         geom_sf(data= shapefile[13,],color = "black",fill="royalblue")+
         geom_sf(data= shapefile[24,],color = "black",fill="royalblue")+
         geom_sf(data= shapefile[23,],color = "black",fill="royalblue")+
         geom_sf(data= shapefile[14,],color = "black",fill="royalblue")+
         geom_sf(data= shapefile[12,],color = "black",fill="royalblue")+
         geom_sf(data= shapefile[21,],color = "black",fill="royalblue")+
         geom_sf(data= shapefile[10,],color = "black",fill="royalblue")+
         geom_sf(data= shapefile[11,],color = "black",fill="royalblue")+
         geom_sf(data= shapefile[17,],color = "black",fill="royalblue")+
         geom_sf(data= shapefile[18,],color = "black",fill="royalblue")+
         geom_sf(data= shapefile[20,],color = "black",fill="royalblue")+
         theme_minimal()+
         theme(axis.text.x = element_blank(), axis.text.y = element_blank())
    
    
    switch(input$zone,
           "Vue d'ensemble"   = r,
           "Nord"             = Nord,
           "Sud"              = Sud,
           "Sud_1"            = Sud_1,
           "Ouest"            = Ouest,
           "Est"              = Est,
           "+ d'une zone"     = multi
    )
    
  }) 
  
####################################################################### -> STAT GÉNÉRALES #####################################################################################

      data1
      dataEst   <- filter(data1,Zone.s..d.activité..selon.le.découpage.administratif.des.intercommunalités.=="Est")
      dataOuest <- filter(data1,Zone.s..d.activité..selon.le.découpage.administratif.des.intercommunalités.=="Ouest")
      dataNord  <- filter(data1,Zone.s..d.activité..selon.le.découpage.administratif.des.intercommunalités.=="Nord")
      dataSud   <- filter(data1,Zone.s..d.activité..selon.le.découpage.administratif.des.intercommunalités.=="Sud")
      dataMulti <- filter(data1,Zone.s..d.activité..selon.le.découpage.administratif.des.intercommunalités.=="+ de 2 zones")

output$structure <- renderText({
  
      i      <- nrow(data1)
      iest   <- nrow(dataEst)
      iouest <- nrow(dataOuest)
      inord  <- nrow(dataNord)
      isud   <- nrow(dataSud)
      imulti <- nrow(dataMulti)

switch(input$zone,
       "Vue d'ensemble" = i,
       "Nord"           = inord,
       "Sud"            = isud,
       "Ouest"          = iouest,
       "Est"            = iest,
       "+ de 2 zones"   = imulti
)
})

#################### Nombre de marchés attribués en 2025 #####
output$attribués <- renderText({
  
a      <- sum(data1$Nombre.de.marchés.attribués.en.2025..)
aest   <- sum(dataEst$Nombre.de.marchés.attribués.en.2025..)
aouest <- sum(dataOuest$Nombre.de.marchés.attribués.en.2025..)
anord  <- sum(dataNord$Nombre.de.marchés.attribués.en.2025..)
asud   <- sum(dataSud$Nombre.de.marchés.attribués.en.2025..)
amulti <- sum(dataMulti$Nombre.de.marchés.attribués.en.2025..)

  switch(input$zone,
         "Vue d'ensemble" = a,
         "Nord" = anord,
         "Sud" = asud,
         "Ouest" = aouest,
         "Est" = aest,
         "+ de 2 zones" = amulti
  )
})


############# Nombre de marchés avec une considération sociale attribués en 2025 ####
output$considération <- renderText({  

   c      <- sum(data1$Nombre.de.marchés.attribués.en.2025.avec.une.considération.sociale..)
   cest   <- sum(dataEst$Nombre.de.marchés.attribués.en.2025.avec.une.considération.sociale..)
   couest <- sum(dataOuest$Nombre.de.marchés.attribués.en.2025.avec.une.considération.sociale..)
   cnord  <- sum(dataNord$Nombre.de.marchés.attribués.en.2025.avec.une.considération.sociale..)
   csud   <- sum(dataSud$Nombre.de.marchés.attribués.en.2025.avec.une.considération.sociale..)
   cmulti <- sum(dataMulti$Nombre.de.marchés.attribués.en.2025.avec.une.considération.sociale..)


 switch(input$zone,
        "Vue d'ensemble" = c,
        "Nord"           = cnord,
        "Sud"            = csud,
        "Ouest"          = couest,
        "Est"            = cest,
        "+ de 2 zones"   = cmulti)
})
 
############### Les outils utilisés ####
output$outils <- renderPlot( 
  
  { 
    o   <-   ggplot(outil, aes(x=type, y= as.factor(pourcentage), fill=type)) + 
             geom_bar(aes(alpha = pourcentage != "0%"), start = 0, stat = "identity", show.legend = FALSE) + theme_minimal() +  
             geom_text(aes(label = pourcentage), hjust = 0.67, vjust = -0.1, color = "black", size = 6.2) +
             theme(axis.title = element_blank(), axis.text.y  = element_blank(), axis.text.x = element_text(size = 10, angle = 30, vjust = .9, hjust = 0.87)) +
             scale_fill_manual(values = c ("steelblue","steelblue","steelblue","steelblue", "steelblue")) +
             scale_alpha_manual(values = c("TRUE" = 1, "FALSE" = 0), guide = "none")
    
    oEst  <- ggplot(outil, aes(x=type, y= as.factor(nombre), fill=type)) + 
             geom_bar(aes(alpha = nombre != 0), start = 0, stat = "identity", show.legend = FALSE) + theme_minimal() +  
             geom_text(aes(label = pourcentage), hjust = 0.67, vjust = -0.1, color = "black", size = 6.2) +
             theme(axis.title = element_blank(), axis.text.y  = element_blank(), axis.text.x = element_text(size = 10, angle = 30, vjust = .9, hjust = 0.87)) +
             scale_fill_manual(values = c ("steelblue","steelblue","steelblue","steelblue", "steelblue")) +
             scale_alpha_manual(values = c("TRUE" = 1, "FALSE" = 0), guide = "none")
    
    switch(input$zone,
           "Vue d'ensemble" = o,
           "Est"            = oEst
           )
  })

########## Comment abordez-vous la loi climat et résilience (effective en août 2026)? ####
output$nuage <-  renderPlot( 
  { 
    ggplot() + geom_line()
  })


############################################################### -> CLAUSE SOCIALE INSERTION ############################################################################


############################# Nombre de marchés avec une clause sociale d'insertion ayant générés des heures d'insertion en 2025 ###

output$nbre_csi <- renderText({
  
  csi      <- sum(data1$Nombre.de.marchés.avec.une.clause.sociale.d.insertion.ayant.générés.des.heures.d.insertion.en.2025..)
  csiest   <- sum(dataEst$Nombre.de.marchés.avec.une.clause.sociale.d.insertion.ayant.générés.des.heures.d.insertion.en.2025..)
  csiouest <- sum(dataOuest$Nombre.de.marchés.avec.une.clause.sociale.d.insertion.ayant.générés.des.heures.d.insertion.en.2025..)
  csinord  <- sum(dataNord$Nombre.de.marchés.avec.une.clause.sociale.d.insertion.ayant.générés.des.heures.d.insertion.en.2025..)
  csisud   <- sum(dataSud$Nombre.de.marchés.avec.une.clause.sociale.d.insertion.ayant.générés.des.heures.d.insertion.en.2025..)
  csimulti <- sum(dataMulti$Nombre.de.marchés.avec.une.clause.sociale.d.insertion.ayant.générés.des.heures.d.insertion.en.2025..)
 
  switch(input$zone,
         "Vue d'ensemble" = csi,
         "Nord"           = csinord,
         "Sud"            = csisud,
         "Ouest"          = csiouest,
         "Est"            = csiest,
         "+ de 2 zones"   = csimulti)
})

#################################Nombre d'heures d'insertion réalisées en 2025 #####
output$heures_csi <- renderText({
  
  r         <- sum(data1$Nombre.d.heures.d.insertion.réalisées.dans.le.cadre.de.la.clause.sociale.d.insertion..)
  hcsinord  <- sum(dataNord$Nombre.d.heures.d.insertion.réalisées.dans.le.cadre.de.la.clause.sociale.d.insertion..)
  hcsisud   <- sum(dataSud$Nombre.d.heures.d.insertion.réalisées.dans.le.cadre.de.la.clause.sociale.d.insertion..)
  hcsiest   <- sum(dataEst$Nombre.d.heures.d.insertion.réalisées.dans.le.cadre.de.la.clause.sociale.d.insertion..)
  hcsiouest <- sum(dataOuest$Nombre.d.heures.d.insertion.réalisées.dans.le.cadre.de.la.clause.sociale.d.insertion..)
  hcsimulti <- sum(dataMulti$Nombre.d.heures.d.insertion.réalisées.dans.le.cadre.de.la.clause.sociale.d.insertion..)
  
  
  switch(input$zone,
         "Vue d'ensemble" = r,
         "Nord"           = hcsinord,
         "Sud"            = hcsisud,
         "Ouest"          = hcsiouest,
         "Est"            = hcsiest,
         "+ de 2 zones"   = hcsimulti)
  
})


############################### Nombre de bénéficiaires ayant réalisé des heures d'insertion en 2025 #####

output$bénéficiaires_csi <- renderText({
  
  bcsi      <- sum(data1$Nombre.de.bénéficiaires.ayant.réalisé.des.heures.d.insertion.en.2025..)
  bcsiest   <- sum(dataEst$Nombre.de.bénéficiaires.ayant.réalisé.des.heures.d.insertion.en.2025..)
  bcsiouest <- sum(dataOuest$Nombre.de.bénéficiaires.ayant.réalisé.des.heures.d.insertion.en.2025..)
  bcsinord  <- sum(dataNord$Nombre.de.bénéficiaires.ayant.réalisé.des.heures.d.insertion.en.2025..)
  bcsisud   <- sum(dataSud$Nombre.de.bénéficiaires.ayant.réalisé.des.heures.d.insertion.en.2025..)
  bcsimulti <- sum(dataMulti$Nombre.de.bénéficiaires.ayant.réalisé.des.heures.d.insertion.en.2025..)
 
  switch(input$zone,
         "Vue d'ensemble"  = bcsi,
         "Nord"            = bcsinord,
         "Sud"             = bcsiouest,
         "Ouest"           = bcsiouest,
         "Est"             = bcsiest,
         "+ de 2 zones"    = bcsimulti
         )
})


################################# Nombre de bénéficiaires issues d'un QPV #####
output$qpv <- renderText({
  
  qpv_total      <- sum(data1$Nombre.de.bénéficiaires.issus.des.QPV.)
  qpv_est        <- sum(dataEst$Nombre.de.bénéficiaires.issus.des.QPV.)
  qpv_ouest      <- sum(dataOuest$Nombre.de.bénéficiaires.issus.des.QPV.)
  qpv_nord       <- sum(dataNord$Nombre.de.bénéficiaires.issus.des.QPV.)
  qpv_sud        <- sum(dataSud$Nombre.de.bénéficiaires.issus.des.QPV.)
  qpv_multi      <- sum(dataMulti$Nombre.de.bénéficiaires.issus.des.QPV.)
  
  switch(input$zone,
         "Vue d'ensemble"  = qpv_total,
         "Nord"            = qpv_nord,
         "Sud"             = qpv_sud,
         "Ouest"           = qpv_ouest,
         "Est"             = qpv_est,
         "+ de 2 zones"    = qpv_multi
  )
  
})


################################ Âge des bénéficiaires ##########
output$âge <- renderPlot({
  
  
  Nordage  <- filter(age, zone=="Nord")
  Estage   <- filter(age,zone== 'Est')
  Ouestage <- filter(age, zone == "Ouest")
  Sudage   <- filter(age, zone == "Sud")
  Multiage <- filter(age, zone == "+ de zones")
  
  age$tranche = factor(age$tranche, levels = c("moins de 26 ans","26 à 40 ans","41 à 50 ans","51 ans et plus")) 
  ager    <-  ggplot(age, aes(x=reorder(tranche, tranche), y= as.factor(age), fill=tranche)) + 
              geom_bar(stat = "identity", show.legend = FALSE) + theme_minimal() + 
              geom_text(aes(label = pourcentage), hjust = 0.67, vjust = - 0.09, color = "black", size = 4.7) +
              theme(axis.title = element_blank(), axis.text.y  = element_blank(), axis.text.x = element_text(size = 12 )) +
              scale_fill_manual(values = c ("steelblue","steelblue","steelblue","steelblue"))
  
  Nordage$tranche = factor(Nordage$tranche, levels = c("moins de 26 ans","26 à 40 ans","41 à 50 ans","51 ans et plus"))   
  ageNord <- ggplot(Nordage, aes(x=tranche, y= as.factor(age), fill=tranche)) + 
             geom_bar(stat = "identity", show.legend = FALSE) + theme_minimal() + 
             geom_text(aes(label = pourcentage), hjust = 0.67, vjust = - 0.1, color = "black", size = 4.7) +
             theme(axis.title = element_blank(), axis.text.y  = element_blank(), axis.text.x = element_text(size = 12 )) +
             scale_fill_manual(values = c ("steelblue","steelblue","steelblue","steelblue"))
  
  
  Estage$tranche = factor(Estage$tranche, levels = c("moins de 26 ans","26 à 40 ans","41 à 50 ans","51 ans et plus"))   
  ageEst <- ggplot(Estage, aes(x=tranche, y= as.factor(age), fill=tranche)) + 
            geom_bar(stat = "identity", show.legend = FALSE) + theme_minimal() +  
    geom_text(aes(label = pourcentage), hjust = 0.67, vjust = - 0.09, color = "black", size = 4.7) +
            theme(axis.title = element_blank(), axis.text.y  = element_blank(), axis.text.x = element_text(size = 12 )) +
            scale_fill_manual(values = c ("steelblue","steelblue","steelblue","steelblue"))
  
  Ouestage$tranche = factor(Ouestage$tranche, levels = c("moins de 26 ans","26 à 40 ans","41 à 50 ans","51 ans et plus"))   
  ageOuest <- ggplot(Ouestage, aes(x=tranche, y= as.factor(age), fill=tranche)) + 
              geom_bar(stat = "identity", show.legend = FALSE) + theme_minimal() + 
    geom_text(aes(label = pourcentage), hjust = 0.67, vjust = - 0.1, color = "black", size = 4.7) +
              theme(axis.title = element_blank(), axis.text.y  = element_blank(), axis.text.x = element_text(size = 12 )) +
              scale_fill_manual(values = c ("steelblue","steelblue","steelblue","steelblue"))
  
  Sudage$tranche = factor(Sudage$tranche, levels = c("moins de 26 ans","26 à 40 ans","41 à 50 ans","51 ans et plus"))   
  ageSud <- ggplot(Sudage, aes(x=tranche, y= as.factor(age), fill=tranche)) + 
            geom_bar(stat = "identity", show.legend = FALSE) + theme_minimal() +
    geom_text(aes(label = pourcentage), hjust = 0.67, vjust = - 0.1, color = "black", size = 4.7) +
            theme(axis.title = element_blank(), axis.text.y  = element_blank(), axis.text.x = element_text(size = 12 )) +
            scale_fill_manual(values = c ("steelblue","steelblue","steelblue","steelblue"))
  
  Multiage$tranche = factor(Multiage$tranche, levels = c("moins de 26 ans","26 à 40 ans","41 à 50 ans","51 ans et plus"))   
  ageMulti <- ggplot(Multiage, aes(x=tranche, y= as.factor(age), fill=tranche)) + 
              geom_bar(stat = "identity", show.legend = FALSE) + theme_minimal() +
    geom_text(aes(label = pourcentage), hjust = 0.67, vjust = - 0.1 , color = "black", size = 4.7) +
              theme(axis.title = element_blank(), axis.text.y  = element_blank(), axis.text.x = element_text(size = 12 )) +
              scale_fill_manual(values = c ("steelblue","steelblue","steelblue","steelblue"))
  
  
  switch(input$zone,
         "Vue d'ensemble" = ager,
         "Nord"           = ageNord,
         "Sud"            = ageSud,
         "Ouest"          = ageOuest,
         "Est"            = ageEst,
         "+ de 2 zones"   = ageMulti
  )
})


############################## Hommes/Femmes #####
output$sexe <- renderPlot({
  
  rs <- ggplot(genre_est, aes(x="", y= nombre, fill= genre)) + geom_col(color="black") +
              coord_polar("y", start = 2.5) +
              theme_void() + 
              theme(legend.position = "right", legend.title = element_blank(), legend.text = element_text(size=17)) +
              geom_label(aes(label = pourcentage), position= position_stack(vjust = 0.7),size = 5.5, show.legend = FALSE) + 
              scale_fill_manual(values = c ("#25a36f","steelblue"))

  

  sest   <-  ggplot(genre_est, aes(x="", y= nombre, fill= genre)) + geom_col(color="black") +
             coord_polar("y", start = 2.5) +
             theme_void() + 
             theme(legend.position = "right", legend.title = element_blank(), legend.text = element_text(size=17)) + 
             geom_label(aes(label = pourcentage), position= position_stack(vjust = 0.7),size = 5.5, show.legend = FALSE) + 
             scale_fill_manual(values = c ("#25a36f","steelblue"))
  
  
  
  switch(input$zone,
         "Vue d'ensemble" = rs, 
         "Est"            = sest
        
  )
  
})


#################################### Niveau de qualification des bénéficiaires ####
output$qualification <- renderPlot({
  
  Norddip   <- filter(diplome, zone=="Nord")
  Estdip    <- filter(diplome,zone== 'Est')
  Ouestdip  <- filter(diplome, zone == "Ouest")
  Suddip    <- filter(diplome, zone == "Sud")
  multidip  <- filter(diplome, zone == "+ de 2 zones")
  
  diplome$diplôme = factor(diplome$diplôme, levels = c("Sans diplôme","CAP/BEP","Baccalauréat","Bac +")) 
  r <- ggplot(diplome, aes(x=diplôme, y = as.factor(Nombre), fill= diplôme, size = 100)) + 
       geom_bar(stat = "identity", show.legend = FALSE) + theme_minimal() +  
    geom_text(aes(label = pourcentage), hjust = 0.67, vjust = -0.065, color = "black", size = 4.7) +
       theme(axis.title = element_blank(), axis.text.y  = element_blank(), axis.text.x = element_text(size = 17 )) +
       scale_fill_manual(values = c ("steelblue","steelblue","steelblue","steelblue"))
  
 
  
  Estdip$diplôme = factor(Estdip$diplôme, levels = c("Sans diplôme","CAP/BEP","Baccalauréat","Bac +")) 
  Estdip <-     ggplot(Estdip, aes(x=diplôme, y = as.factor(Nombre), fill= diplôme, size = 100)) + 
                geom_bar(stat = "identity", show.legend = FALSE) + theme_minimal() + 
    geom_text(aes(label = pourcentage), hjust = 0.67, vjust = - 0.065, color = "black", size = 4.7) +
                theme(axis.title = element_blank(), axis.text.y  = element_blank(), axis.text.x = element_text(size = 17 )) +
                scale_fill_manual(values = c ("steelblue","steelblue","steelblue","steelblue"))
  
 

  
  
  switch(input$zone,
         "Vue d'ensemble" = r,
         "Nord"           = Norddip,
         "Sud"            = Suddip,
         "Ouest"          = Ouestdip,
         "Est"            = Estdip,
         "+ de 2 zones"   = multidip
  )
})

############################## Les types de contrats #######

output$contrats <- renderPlot({
  
  tcontrat <-  ggplot(modalité_embauche, aes(x=modalité, y = as.factor(Nombre), fill= modalité)) + 
               geom_bar(aes(alpha = Nombre != 0), stat = "identity", show.legend = FALSE) + theme_minimal() +  
    geom_text(aes(label = pourcentage), hjust = 0.67, vjust = 0, color = "black", size = 4.7) +           
        theme(axis.title = element_blank(), axis.text.y  = element_blank(), axis.text.x = element_text(size = 17 )) +
        scale_fill_manual(values = c ("steelblue","steelblue","steelblue")) +
        scale_alpha_manual(values = c("TRUE" = 1, "FALSE" = 0), guide = "none")
 
   cest <-  ggplot(modalité_embauche, aes(x=modalité, y = as.factor(Nombre), fill= modalité)) + 
            geom_bar(aes(alpha = Nombre != 0), stat = "identity", show.legend = FALSE) + theme_minimal() +  
     geom_text(aes(label = pourcentage), hjust = 0.67, vjust = 0, color = "black", size = 4.7) +
            theme(axis.title = element_blank(), axis.text.y  = element_blank(), axis.text.x = element_text(size = 17 )) +
            scale_fill_manual(values = c ("steelblue","steelblue","steelblue")) +
            scale_alpha_manual(values = c("TRUE" = 1, "FALSE" = 0), guide = "none")

 switch(input$zone,
        "Vue d'ensemble" = tcontrat,
        "Est"            = cest
 )
})


########################################################################### -> LES MARCHÉS RÉSERVÉS ####################################################################################

######################### Nombre de marchés réservés attribués en 2025 #####
output$siae <- renderPlot( 
  { 
    ggplot() + geom_line() +ggtitle("TYPES DE STRUCTURES SIAE")
  }) 

######################### Nombre de marchés réservés SIAE attribués en 2025 ####
output$stpa <- renderPlot( 
  { 
    ggplot() + geom_line() +ggtitle("TYPES DE STRUCTURES STPA")
  }) 

######################### Nombre de marchés réservés STPA attribués en 2025 ####
output$hstpa <- renderPlot( 
  { 
    ggplot() + geom_line() +ggtitle("Heures d'insertions STPA valorisés")
  }) 


# call the server part
# check_credentials returns a function to authenticate users
res_auth <- secure_server(
  check_credentials = check_credentials(credentials)
)

output$auth_output <- renderPrint({
  reactiveValuesToList(res_auth)
})


}



########################################################################### -> LA CLAUSE DE STAGE ####################################################################################

################################## Nombre de marchés ayant généré des heures de stage en 2025 ####

################################## Nombre d'heures de stage réalisées en 2025 ####

################################## Nombre de stagiares en 2025 #####

################################## Types de stagiaires ####

################################## Durée des stages ####



  ############################################################# -> LES CRITÉRES D'ATTRIBUTION #####################################################################

######################################Nombre de marchés avec un critère d'attribution social attribué en 2025 ####

################################### Nombre de moyen de pondération relatif au critère d'attribution social (%) ####



# > RUN THE APP ----
shinyApp(ui = ui, server = server)



