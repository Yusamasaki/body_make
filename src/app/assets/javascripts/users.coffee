window.chest_recovery_graph = ->
    document.addEventListener 'turbolinks:load',
    ctx = document.getElementById("chest_recovery").getContext('2d')
    chest_recovery = new Chart(ctx, {
        type: 'horizontalBar',
        data: {
            datasets: [
                {
                    data: [3],
                    backgroundColor: '#274277'
                },
                {
                    data: [2],
                    backgroundColor: '#8fa8da'
                }
             ]
        },
        options: {
            legend: {
              display: false
            }
            title: {
                display: true,
                text: '胸',
                fontSize: 20,
                position: 'top',
                fontColor: '#274277'
            }
            scales: {
                yAxes: [
                    {   
                        stacked: true
                    }
                ], 
                xAxes: [
                    {
                        stacked: true,
                        ticks: {
                          stepSize: 1
                        }
                    }
                ]
            }
        }
    })