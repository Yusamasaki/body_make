# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# 体重グラフ用
window.draw_graph = -> 
    ctx = document.getElementById("myChart").getContext('2d')
    myChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: gon.start_times,
            datasets: [{
                label: '体重',
                data: gon.body_weights,
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
                        max: gon.newwest_bodyweight_high_with,
                        stepSize: 20
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
                    value: 80,
                    endValue: 80,
                    borderColor: 'red',
                    borderWidth: 3,
                    borderDash: [2, 2],
                    borderDashOffset: 1
                }]
            }
        }
    })
    
   
    
window.doughnut_graph = -> 
    ctx = document.getElementById("chart-area").getContext('2d')
    myChart = new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: ['増減体重', '残り体重'],
            datasets: [{
                data: gon.body_weight_area,
                backgroundColor: ['#274277', '#8fa8da'],
                borderColor: ['#274277', '#8fa8da'],
                borderWidth: 1
            }]
        },
        options: {
            cutoutPercentage: 80, 
            legend: {                
                position: 'top'
            }
            scales: {
                xAxes: [{
                    display: false,
                }],
                yAxes: [{
                    display: false
                }]
            }
        }
    })