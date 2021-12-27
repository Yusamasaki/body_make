

# 体重グラフ用
window.bodyfat_draw_graph = -> 
    ctx = document.getElementById("bodyfat-myChart").getContext('2d')
    myChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: gon.start_times,
            datasets: [{
                label: '体重',
                data: gon.bodyfat_percentages,
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
                        min: gon.newwest_bodyfat_percentage_low_with,
                        max: gon.newwest_bodyfat_percentage_high_with,
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
                    value: gon.goal_bodyfat_percentage,
                    endValue: gon.goal_bodyfat_percentage,
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
                        content: '目標体脂肪率'
                    }
                }]
            }
        }
    })
    
   
    
window.bodyfat_doughnut_graph = -> 
    ctx = document.getElementById("bodyfat-chart-area").getContext('2d')
    myChart = new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: ['増減体脂肪率', '残り体脂肪率'],
            datasets: [{
                data: gon.bodyfat_percentage_area,
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