# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.today_traning_graph = -> 
    ctx = document.getElementById("myChart").getContext('2d')
    myChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: gon.today_traning_starttimes,
            datasets: [{
                label: '体重',
                data: gon.today_traning_total_loads,
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
                        
                    }
                }]
            }
            #   annotation: {
            #     annotations: [{
            #         type: 'line',
            #         drawTime: 'afterDatasetsDraw',
            #         id: 'a-line-1',
            #         mode: 'horizontal',
            #         scaleID: 'y左軸',
            #         value: gon.goal_body_weight,
            #         endValue: gon.goal_body_weight,
            #         borderColor: '#274277',
            #         borderWidth: 3,
            #         borderDash: [2, 2],
            #         borderDashOffset: 1,
            #         label: {
            #             backgroundColor: 'rgba(255,255,255,0.8)',
            #             bordercolor: 'rgba(0,0,60,0.8)',
            #             borderwidth: 2,
            #             fontSize: 10,
            #             fontStyle: 'bold',
            #             fontColor: 'rgba(10,60,255,0.8)',
            #             xPadding: 10,
            #             yPadding: 10,
            #             cornerRadius: 3,
            #             position: 'left',
            #             xAdjust: 0,
            #             yAdjust: 0,
            #             enabled: true,
            #             content: '目標体重'
            #         }
            #     }]
            # }
        }
    })