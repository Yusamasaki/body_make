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
                x: [{
                    title:{
                        display: false
                    }
                }],
                y: [{
                }]
            },
            plugins: {
                annotation: {
                    annotations: [{
                        type: 'line',
                        drawTime: 'afterDatasetsDraw',
                        id: 'a-line-1',
                        mode: 'horizontal', 
                        scaleID: 'y', 
                        ymin: 70,
                        ymax: 70,
                        borderColor: 'red',
                        borderWidth: 3, 
                        borderDash: [2, 2],
                        borderDashOffset: 1,
                            
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