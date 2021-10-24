
window.myfood_graph = -> 
    document.addEventListener 'turbolinks:load', ->
    ctx = document.getElementById("myfood").getContext('2d')
    myfood = new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: ['たんぱく質', '脂質', '炭水化物', '糖質', '食物繊維'],
            datasets: [{
                data: gon.nutrition,
                backgroundColor: ['#274277', '#8fa8da', '#274277', '#8fa8da', '#274277'],
                borderColor: ['#274277', '#8fa8da', '#274277', '#8fa8da', '#274277'],
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
    