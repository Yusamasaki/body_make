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
                backgroundColor: '#0000FF',
                borderColor: '#0000FF',
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                xAxes: [{
                    ticks: {
                    }
                }],
                yAxes: [{
                    ticks: {
                        min: 30,
                        max: 100
                    }
                }]
            },
            plugins: {
                autocolors: false,
                annotation: {
                    annotations: [{
                        line1: {
                        type: 'line',
                        yMin: 60,
                        yMax: 60,
                        borderColor: 'rgb(255, 99, 132)',
                        borderWidth: 2,
                        }
                    }]
                }
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