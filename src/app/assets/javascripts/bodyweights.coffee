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
                yAxes: [{
                    scaleLabel: {
                        },
                    gridLines: {
                        },
                    ticks: {
                    }
                }]
            }
        }
    })
    
    #  options: {
    #     :
    #     scales: {         // 軸設定
    #         xAxes: [           // Ｘ軸設定
    #             {
    #                 scaleLabel: {   // 軸ラベル
    #                     :
    #                 },
    #                 gridLines: {    // 目盛線
    #                     :
    #                 },
    #                 ticks: {        // 目盛り
    #                     :
    #                 },
    #             }
    #         ],
    #         yAxes: [           // Ｙ軸設定
    #             :      xAxesと同様  
    #         ]
    #     }
    #     :
    
window.doughnut_graph = -> 
    ctx = document.getElementById("chart-area").getContext('2d')
    myChart = new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: ['減った体重', '残り体重'],
            datasets: [{
                data: gon.body_weight_area,
                backgroundColor: ['#274277', '#8fa8da'],
                borderColor: ['#274277', '#8fa8da'],
                borderWidth: 1
            }]
        },
        options: {
            cutoutPercentage: 70, 
            legend: {                
                position: 'left'
            }
            scales: {
                xAxes: [{
                    scaleLabel: {
                        display: false
                    }
                    display: true,
                    stacked: false,
                    gridLines: {
                        display: false
                        drawBorder: false
                    }   
                }],
                yAxes: [{
                    
                    display: true,
                    stacked: false,
                    gridLines: {
                        display: false
                        drawBorder: false
                    }
                    ticks: {
                        display: false
                    }  
                }]
            }
        }
    })