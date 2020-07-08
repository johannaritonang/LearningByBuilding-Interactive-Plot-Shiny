header <- dashboardHeader(
    title = "Worker's Gender"
)

sidebar <- dashboardSidebar(
    sidebarMenu(
        menuItem(
            text = "Year",
            tabName = "year"
        ),
        menuItem(
            text = "Category",
            tabName = "category"
        ),
        menuItem(
            text = "Source Data",
            tabName = "data"
        )
    )
)


body <- dashboardBody(
    tabItems(
        tabItem(
            tabName = "year",
            fluidRow(
                width = 1,
                selectInput(
                    inputId = "selectYear",
                    label = "Select Year:",
                    choices = c(2013, 2014, 2015, 2016)
                )
            ),
            fluidRow(
                column(
                    width = 2
                ),
                column(
                    width = 8,
                    plotlyOutput("employPlot")
                ),
                column(
                    width = 2
                )
            ),
            br(),
            br(),
            fluidRow(
                column(
                    width = 6,
                    plotlyOutput("femaleWage")
                ),
                column(
                    width = 6,
                    plotlyOutput("maleWage")
                )
            )
        ),
        tabItem(
            tabName = "category",
            h2("Major Category"),
            fluidRow(
                width = 5,
                selectInput(
                    inputId = "selectMajorCat",
                    label = "Select Category:",
                    choices = unique(workers$major_category)
                )
            ),
            fluidRow(
                column(
                    width = 6,
                    plotlyOutput("genderMajPlot")
                ),
                column(
                    width = 6,
                    plotlyOutput("wageMajPlot")
                )
            ),
            br(),
            h2("Minor Category"),
            fluidRow(
                width = 5,
                selectInput(
                    inputId = "selectMinorCat",
                    label = "Select Category:",
                    choices = unique(workers$minor_category)
                )
            ),
            fluidRow(
                column(
                    width = 6,
                    plotlyOutput("genderMinPlot")
                ),
                column(
                    width = 6,
                    plotlyOutput("wageMinPlot")
                )
            )
        ),
        tabItem(
            tabName = "data",
            fluidPage(
                tabsetPanel(
                    tabPanel("Raw Data", DTOutput("workersDT")),
                    tabPanel("Year",
                             fluidRow(
                                 width = 1,
                                 selectInput(
                                     inputId = "selectYearDT",
                                     label = "Select Year:",
                                     choices = c(2013, 2014, 2015, 2016)
                                 ),
                             ),
                             fluidRow(
                                 DTOutput("workersgapDT")
                             )
                             
                    ),
                    tabPanel("Category",
                             h2("Major Category"),
                             fluidRow(
                                 width = 8,
                                 selectInput(
                                     inputId = "selectMajorCatDT",
                                     label = "Select Category:",
                                     choices = unique(workers$major_category)
                                 )
                             ),
                             fluidRow(
                                 column(
                                     width = 6,
                                     DTOutput("genderMajorDT")
                                 ),
                                 column(
                                     width = 6,
                                     DTOutput("wageMajorDT")
                                 )
                             ),
                             h2("Major Category"),
                             fluidRow(
                                 width = 8,
                                 selectInput(
                                     inputId = "selectMinorCatDT",
                                     label = "Select Category:",
                                     choices = unique(workers$minor_category)
                                 )
                             ),
                             fluidRow(
                                 column(
                                     width = 6,
                                     DTOutput("genderMinorDT")
                                 ),
                                 column(
                                     width = 6,
                                     DTOutput("wageMinorDT")
                                 )
                             )
                    )
                )
            )
        )
    )
)


dashboardPage(
    header = header,
    sidebar = sidebar,
    body = body,
    skin = "red"
)