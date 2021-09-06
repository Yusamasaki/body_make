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
            labels: '',
            datasets: [{
                label: '',
                data: '',
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