window.meals_graph = -> 
    document.addEventListener 'turbolinks:load', ->
    ctx = document.getElementById("myMealChart").getContext('2d')
    myMealChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: gon.start_times,
            datasets: [{
                label: '摂取カロリー',
                data: gon.calories,
                fill: false,
                backgroundColor: 'rgba(0, 0, 255, 0.3)',
                borderColor: '#0000FF',
                borderWidth: 1,
                hoverBackgroundColor: undefined,
                spanGaps: true
            }]
        },
        options: {
            scales: {
                xAxes: [{
                    id: 'X軸',
                    ticks: {
                    
                    }
                }],
                yAxes: [{
                    id: 'y左軸',
                    ticks: {
                        min: gon.newwest_bodyweight_low_with,
                        max: gon.newwest_bodyweight_high_with
                    }
                }]
            },
            annotation: {
                annotations: [{
                    type: 'line',
                    drawTime: 'afterDatasetsDraw',
                    id: 'a-line-1',
                    mode: 'horizontal',
                    scaleID: 'y左軸',
                    value: gon.day_target_calorie,
                    endValue: gon.day_target_calorie,
                    borderColor: '#274277',
                    borderWidth: 3,
                    borderDash: [2, 2],
                    borderDashOffset: 1,
                    label: {
                        backgroundColor: 'rgba(255,255,255,0.8)',
                        bordercolor: 'rgba(0,0,60,0.8)',
                        borderwidth: 2,
                        fontSize: 10,
                        fontStyle: 'bold',
                        fontColor: 'rgba(10,60,255,0.8)',
                        xPadding: 10,
                        yPadding: 10,
                        cornerRadius: 3,
                        position: 'left',
                        xAdjust: 0,
                        yAdjust: 0,
                        enabled: true,
                        content: '目標摂取カロリー'
                    }
                }]
            }
        }
    })