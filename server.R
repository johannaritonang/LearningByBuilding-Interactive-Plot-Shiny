function(input, output){
    output$employPlot <- renderPlotly({
        # data transformation
        workers_gap <- workers %>% 
            filter(year == input$selectYear) %>% 
            group_by(minor_category) %>% 
            summarise(
                Male = mean(percent_male),
                Female = mean(percent_female)
            ) %>% 
            ungroup() %>% 
            mutate(minor_category = reorder(minor_category, Male - Female)) %>% 
            pivot_longer(cols = -minor_category) %>% 
            mutate(text = paste(name,":", round(value,2) ,"%")) %>% 
            
            # visualization
            ggplot(workers_gap, mapping = aes(value, minor_category, text = text)) + 
            geom_col(aes(fill = name), position = "dodge") +
            geom_vline(xintercept = 50, linetype = "dotted") +
            labs(x = NULL, y= NULL, title = "US Labor Average in Industry") +
            theme(legend.position = "none") +
            scale_x_continuous(labels = scales::unit_format(unit = "%"),expand = c(0,0)) +
            scale_y_discrete(expand = c(0,0)) +
            theme(plot.title = element_text(hjust = 0.5)) +
            yellow_theme
        
        # interactive plot
        ggplotly(workers_gap, tooltip = "text") %>%
            config(displayModeBar = F)
    })
    output$femaleWage <- renderPlotly({
        # data transformation
        wagefemale <- workers %>%
            filter(year == input$selectYear) %>% 
            
            # visualization
            ggplot(aes(as.factor(year), total_earnings_female, text = occupation)) + 
            geom_jitter(aes(color = minor_category), alpha = 0.4) +
            labs(x = NULL, y = NULL, title = "Yearly Female Earnings Average per Occupation") +
            theme(legend.position = "none", plot.title = element_text(hjust = 0.5)) +
            yellow_theme
        
        # interactive plotting
        ggplotly(wagefemale, tooltip = "text") %>%
            config(displayModeBar = F)
    })
    output$maleWage <- renderPlotly({
        
        # data transformation
        wagemale <- workers %>%
            filter(year == input$selectYear) %>% 
            
            # visualization
            ggplot(aes(as.factor(year), total_earnings_male, text = occupation)) + 
            geom_jitter(aes(color = minor_category), alpha = 0.4) +
            labs(x = NULL, y = NULL, title = "Yearly Male Earnings Average per Occupation") +
            theme(legend.position = "none", plot.title = element_text(hjust = 0.5)) +
            yellow_theme
        
        # interactive plotting
        ggplotly(wagemale, tooltip = "text") %>%
            config(displayModeBar = F)
    })
    output$genderMajPlot <- renderPlotly({
        # data transformation
        plot_majorgender <-  workers %>% 
            group_by(year) %>%
            filter(major_category == input$selectMajorCat) %>%
            summarise(
                Male = mean(percent_male),
                Female = mean(percent_female)
            ) %>% 
            ungroup() %>% 
            pivot_longer(-year) %>% 
            mutate(text = paste(name,":",round(value,2),"%")) %>% 
            
            # visualization
            ggplot(aes(year, value,group=name, text = text)) +
            geom_point(aes(color = name)) +
            geom_line(aes(color = name)) +
            facet_wrap(~name, ncol=2, scales="free") +
            labs(x = NULL, y = NULL, title = "Annual Average Employment Growth") +
            theme(legend.position = "none") +
            scale_y_continuous(labels = unit_format(unit="%")) +
            theme(plot.title = element_text(hjust = 0.5)) +
            yellow_theme
        
        # interactive plotting
        ggplotly(plot_majorgender, tooltip = "text") %>% 
            config(displayModeBar = F)
    })
    output$wageMajPlot <- renderPlotly({
        # data transformation
        wageMajorgap <- workers %>% 
            group_by(year) %>%
            filter(major_category == input$selectMajorCat) %>%
            summarise(Male = mean(total_earnings_male),
                      Female = mean(total_earnings_female)) %>% 
            ungroup() %>% 
            mutate(year = reorder(year, Male - Female)) %>% 
            pivot_longer(cols = -year) %>% 
            mutate(text = paste(name,":","$",round(value,2))) %>%
            
            # visualization
            ggplot(major_category, mapping = aes(x = year, y = value, fill = name, text = text)) + geom_col(position = "dodge") +
            geom_vline(xintercept = 50, linetype = "dotted") +
            labs(x = NULL, y = NULL, title = "US Labor Earnings Average") +
            theme(legend.position = "none", plot.title = element_text(hjust = 0.5)) + 
            yellow_theme
        
        # interactive plotting
        ggplotly(wageMajorgap, tooltip = "text")%>% 
            config(displayModeBar = F)
    })
    output$genderMinPlot <- renderPlotly({
        # data transformation
        plot_gender <-  workers %>% 
            group_by(year) %>%
            filter(minor_category == input$selectMinorCat) %>%
            summarise(
                Male = mean(percent_male),
                Female = mean(percent_female)
            ) %>% 
            ungroup() %>% 
            pivot_longer(-year) %>% 
            mutate(text = paste(name,":",round(value,2),"%")) %>% 
            
            # visualization
            ggplot(aes(year, value,group=name, text = text)) +
            geom_point(aes(color = name)) +
            geom_line(aes(color = name)) +
            facet_wrap(~name, ncol=2, scales="free") +
            labs(x = NULL, y = NULL, title = "Annual Average Employment Growth") +
            theme(legend.position = "none") +
            scale_y_continuous(labels = unit_format(unit="%")) +
            theme(plot.title = element_text(hjust = 0.5)) +
            yellow_theme
        
        # interactive plotting
        ggplotly(plot_gender, tooltip = "text") %>% 
            config(displayModeBar = F)
    })
    output$wageMinPlot <- renderPlotly({
        # data transformation
        wageMinorgap <- workers %>% 
            group_by(year) %>%
            filter(minor_category == input$selectMinorCat) %>%
            summarise(Male = mean(total_earnings_male),
                      Female = mean(total_earnings_female)) %>% 
            ungroup() %>% 
            mutate(year = reorder(year, Male - Female)) %>% 
            pivot_longer(cols = -year) %>% 
            mutate(text = paste(name,":","$",round(value,2))) %>%
            
            # visualization
            ggplot(minor_category, mapping = aes(x = year, y = value, fill = name, text = text)) + geom_col(position = "dodge") +
            geom_vline(xintercept = 50, linetype = "dotted") +
            labs(x = NULL, y = NULL, title = "US Labor Earnings Average") +
            theme(legend.position = "none", plot.title = element_text(hjust = 0.5)) +
            yellow_theme
        
        # interactive plotting
        ggplotly(wageMinorgap, tooltip = "text")%>% 
            config(displayModeBar = F)
    }) 
    output$workersDT <- renderDT({
        workers
    })
    output$workersgapDT <- renderDT({
        workersgap <- workers %>% 
            filter(year == input$selectYearDT) %>% 
            group_by(minor_category) %>% 
            summarise(
                Male = round(mean(percent_male),2),
                Female = round(mean(percent_female),2)
            ) %>% 
            ungroup() %>% 
            mutate(minor_category = reorder(minor_category, Male - Female)) %>% 
            pivot_longer(cols = -minor_category)
    })
    output$genderMajorDT <- renderDT({
        majorgenderDT <-  workers %>% 
            filter(major_category == input$selectMajorCatDT) %>%
            group_by(year) %>%
            summarise(
                Male = round(mean(percent_male),2),
                Female = round(mean(percent_female),2)
            ) %>% 
            ungroup() %>% 
            pivot_longer(-year)
    })
    output$wageMajorDT <- renderDT({
        wageMajorDT <- workers %>% 
            group_by(year) %>%
            filter(major_category == input$selectMajorCatDT) %>%
            summarise(Male = round(mean(total_earnings_male),2),
                      Female = round(mean(total_earnings_female),2)
            ) %>% 
            ungroup() %>% 
            mutate(year = reorder(year, Male - Female)) %>% 
            pivot_longer(cols = -year)
    })
    output$genderMinorDT <- renderDT({
        mminorgenderDT <-  workers %>% 
            filter(minor_category == input$selectMinorCatDT) %>%
            group_by(year) %>%
            summarise(
                Male = round(mean(percent_male),2),
                Female = round(mean(percent_female),2)
            ) %>% 
            ungroup() %>% 
            pivot_longer(-year)
    })
    output$wageMinorDT <- renderDT({
        wageMajorDT <- workers %>% 
            group_by(year) %>%
            filter(minor_category == input$selectMinorCatDT) %>%
            summarise(Male = round(mean(total_earnings_male),2),
                      Female = round(mean(total_earnings_female),2)
            ) %>% 
            ungroup() %>% 
            mutate(year = reorder(year, Male - Female)) %>% 
            pivot_longer(cols = -year)
    })
}