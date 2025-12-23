library(shiny)
library(DT)

ui <- fluidPage(
  titlePanel("Numerical Fragility Scenario Explorer"),

  sidebarLayout(
    sidebarPanel(
      h4("Baseline Parameters"),
      numericInput("assets", "Assets", 100),
      numericInput("liabilities", "Reported Liabilities", 60),
      numericInput("cashflow", "Monthly Cash Flow", 5),
      numericInput("debt", "Monthly Debt Service", 3),

      hr(),

      h4("Stress Scenarios"),
      sliderInput("liab_mult", "Liability Multiplier",
                  min = 1, max = 5, value = 1.5, step = 0.1),
      sliderInput("debt_mult", "Debt Service Multiplier",
                  min = 1, max = 3, value = 1.2, step = 0.1),
      sliderInput("cash_drop", "Cash Flow Reduction (%)",
                  min = 0, max = 80, value = 20)
    ),

    mainPanel(
      h4("Scenario Results"),
      tableOutput("results"),
      hr(),
      h4("Interpretation"),
      verbatimTextOutput("flags")
    )
  )
)

server <- function(input, output) {

  stressed <- reactive({
    L <- input$liabilities * input$liab_mult
    D <- input$debt * input$debt_mult
    C <- input$cashflow * (1 - input$cash_drop / 100)

    list(
      assets = input$assets,
      liabilities = L,
      net_assets = input$assets - L,
      net_cash = C - D
    )
  })

  output$results <- renderTable({
    s <- stressed()
    data.frame(
      Metric = names(s),
      Value = unlist(s)
    )
  })

  output$flags <- renderText({
    s <- stressed()
    msgs <- c()

    if (s$net_assets < 0)
      msgs <- c(msgs, "⚠ Insolvency under this scenario")

    if (s$net_cash < 0)
      msgs <- c(msgs, "⚠ Negative cash flow under this scenario")

    if (length(msgs) == 0)
      msgs <- "✓ No hard constraints violated"

    paste(msgs, collapse = "\n")
  })
}

shinyApp(ui, server)
