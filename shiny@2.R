#import libraries

# library(shiny)
# library(tidyverse)
library(pacman)
p_load(
  shiny, tidyverse, rsconnect
  )
#####Import Data
# dat<-read_csv(url("https://www.dropbox.com/s/uhfstf6g36ghxwp/cces_sample_coursera.csv?raw=1"))
dat <- read_csv("cces_sample_coursera.csv")
dat<- dat %>% select(c("pid7","ideo5", 'region'))
dat<-drop_na(dat)

ui<- fluidPage(
  
  titlePanel("Party ID by Ideology"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("my_ideology",
                  "Ideology (1=liberal, 5=conservative):",
                  min=1,
                  max=10,
                  value=2)
    ),
    
    mainPanel(plotOutput("ideology_barplot")
    )
  )
)


server<-function(input,output){
  
  output$ideology_barplot <- renderPlot({
    
    ggplot(
      filter(dat,ideo5==input$my_ideology),
      aes(x=pid7))+geom_bar(col='blue', fill='gold')+xlab("7 Point Party ID (1=Democrat Member, 7=Republican Member)")+
      ylab("Count")+ theme_classic() + facet_wrap(~region) +
     # coord_flip() +
      scale_x_continuous(breaks = seq(1, 10, 2))
    
  })
  
}

shinyApp(ui,server)
# Run the application 
shinyApp(ui = ui, server = server)
