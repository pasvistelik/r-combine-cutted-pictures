shinyUI(bootstrapPage(

  plotOutput(outputId = "full_image", height = "500px"),
  sliderInput(inputId = "iterations_count",
              label = "Количество итераций:",
              min = 1, max = 10, value = 1, step = 1),
  actionButton(inputId = "my_button", label = "Click me"),
  
  
  selectInput(inputId = "n_breaks",
      label = "Number of bins in histogram (approximate):",
      choices = c(10, 20, 35, 50),
      selected = 20),

  checkboxInput(inputId = "individual_obs",
      label = strong("Show individual observations"),
      value = FALSE),

  checkboxInput(inputId = "density",
      label = strong("Show density estimate"),
      value = FALSE),

  plotOutput(outputId = "main_plot", height = "300px"),

  # Display this only if the density is shown
  conditionalPanel(condition = "input.density == true",
    sliderInput(inputId = "bw_adjust",
        label = "Bandwidth adjustment:",
        min = 0.2, max = 2, value = 1, step = 0.2)
  ),
  
  radioButtons("colorSelect", "Color:",
               c("Red" = "red",
                 "Green" = "green",
                 "Blue" = "blue")
               ),
  sliderInput(inputId = "mySliderInput",
              label = "Test:",
              min = 0.2, max = 2, value = 1, step = 0.2)
)

)