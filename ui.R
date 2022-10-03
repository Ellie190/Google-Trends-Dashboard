library(shiny)
library(bs4Dash)
library(gtrendsR)
library(lubridate)
library(tidyverse)
library(tidyquant)
library(tidygeocoder)
library(fs)
library(plotly)
library(shinycssloaders)
library(DT)
library(waiter)
library(rmarkdown)
library(callr)

dashboardPage(
  preloader = list(html = tagList(spin_1(), "Loading ..."), color = "#18191A"),
  fullscreen = TRUE,
  dashboardHeader(title = dashboardBrand(
    title = "University and Online Learning Technology Search Interests: Google Trends Analytics",
    color = "danger",
    image = "logo.png"
  ),
  titleWidth = 500), # end of header
  dashboardSidebar(disable = TRUE), # end of Sidebar
  dashboardBody(
    fluidPage(
      tags$head(
        tags$style(".butt{background:#dc3545;} .butt{color: white;}"),
        tags$style(
          HTML(".shiny-notification {
             position:fixed;
             top: calc(50%);
             left: calc(50%);
             }
             "
          )
        )
      ),
      fluidRow(
        column(4,
               box(title = "Query Box", status = "white",
                   height = 342,
                   width = 12, icon = icon("filter"), solidHeader = TRUE,
               uiOutput("search_term_op"),
               uiOutput("time_period_op"),
               actionButton(inputId = "submit", "Submit Query", status = "danger"),
               downloadButton("report", "Download Report", class = "butt"),
               p(strong("HELP:"), "Click submit query after selecting a
                 search term(s) and search period to generate results and
                 wait a few seconds. The analysis are
                 based on google searches."))),
        column(8,
               box(title = "Search Term Trend Over Time", status = "white",
                   height = 342, 
                   width = 12, icon = icon("chart-line"), solidHeader = TRUE,
                   withSpinner(plotlyOutput("fig1_line_plot", width = "auto", height = 300))))
      ),
      fluidRow(
        column(5,
               box(title = "Trend By Geography", status = "white", height = 342,
                   width = 12, icon = icon("table"), solidHeader = TRUE,
                   maximizable = FALSE,
                   withSpinner(dataTableOutput("geo_tbl1", height = 200)))),
        column(7,
               box(title = "Top Related Searches", status = "white", height = 342, 
                   width = 12, icon = icon("chart-bar"), solidHeader = TRUE,
                   maximizable = FALSE,
                   withSpinner(plotlyOutput("fig3_bar_plot", width = "auto", height = 300))))
      )
      
    ) # end of page
  ) # end of body
) # end of dashboard page