
# ------総負荷グラフ------

window.total_load_graph = ->
    
    ctx = document.getElementById("total_load").getContext('2d')
    total_load = new Chart(ctx, {
        type: 'line',
        data: {
            labels: day,
            datasets: [{
                label: [],
                data: total,
                backgroundColor: 'rgba(0, 0, 255, 0.3)',
                borderColor: '#0000FF',
                borderWidth: 1,
                hoverBackgroundColor: undefined,
                spanGaps: true
            }]
        },
        options: {
            title: {
                display: true,
                text: '総負荷',
                fontSize: 20,
                fontColor: '#274277'
            }
        }
    })

# ------MAX重量グラフ------
       
window.max_load_graph = ->
    ctx = document.getElementById("max_load").getContext('2d')
    max_load = new Chart(ctx, {
        type: 'line',
        data: {
            labels: day,
            datasets: [{
                label: [],
                data: max,
                backgroundColor: 'rgba(0, 0, 255, 0.3)',
                borderColor: '#0000FF',
                borderWidth: 1,
                hoverBackgroundColor: undefined,
                spanGaps: true
            }]
        },
        options: {
            title: {
                display: true,
                text: 'MAX重量',
                fontSize: 20,
                fontColor: '#274277'
            }
        }
    })
    
window.recovery_1_graph = ->
    document.addEventListener 'turbolinks:load',
    ctx = document.getElementById("recovery_1").getContext('2d')
    recovery_1 = new Chart(ctx, {
        type: 'horizontalBar',
        data: {
            datasets: [{ label: '残り回復',data: [gon.today_tranings_1_recovery], backgroundColor: '#274277'}, { label: '回復日',data: [gon.today_tranings_1_recovery_1], backgroundColor: '#8fa8da' }]
        },
        options: {
            legend: { display: false }
            title: { display: true, text: '胸', fontSize: 20, position: 'top', fontColor: '#274277' }
            scales: { yAxes: [{ stacked: true }], xAxes: [{ stacked: true, ticks: { stepSize: 1 }}]}
        }
    })

window.recovery_2_graph = ->
    document.addEventListener 'turbolinks:load',
    ctx = document.getElementById("recovery_2").getContext('2d')
    recovery_2 = new Chart(ctx, {
        type: 'horizontalBar',
        data: {
            datasets: [{ label: '残り回復',data: [gon.today_tranings_2_recovery], backgroundColor: '#274277'}, { label: '回復日',data: [gon.today_tranings_2_recovery_2], backgroundColor: '#8fa8da' }]
        },
        options: {
            legend: { display: false }
            title: { display: true, text: '背中', fontSize: 20, position: 'top', fontColor: '#274277' }
            scales: { yAxes: [{ stacked: true }], xAxes: [{ stacked: true, ticks: { stepSize: 1 }}]}
            
        }
    })
    
window.recovery_3_graph = ->
    document.addEventListener 'turbolinks:load',
    ctx = document.getElementById("recovery_3").getContext('2d')
    recovery_3 = new Chart(ctx, {
        type: 'horizontalBar',
        data: {
            datasets: [{ label: '残り回復',data: [gon.today_tranings_3_recovery], backgroundColor: '#274277'}, { label: '回復日',data: [gon.today_tranings_3_recovery_3], backgroundColor: '#8fa8da' }]
        },
        options: {
            legend: { display: false }
            title: { display: true, text: '脚', fontSize: 20, position: 'top', fontColor: '#274277' }
            scales: { yAxes: [{ stacked: true }], xAxes: [{ stacked: true, ticks: { stepSize: 1 }}]}
        }
    })
    
window.recovery_4_graph = ->
    document.addEventListener 'turbolinks:load',
    ctx = document.getElementById("recovery_4").getContext('2d')
    recovery_4 = new Chart(ctx, {
        type: 'horizontalBar',
        data: {
            datasets: [{ label: '残り回復',data: [gon.today_tranings_4_recovery], backgroundColor: '#274277'}, { label: '回復日',data: [gon.today_tranings_4_recovery_4], backgroundColor: '#8fa8da' }]
        },
        options: {
            legend: { display: false }
            title: { display: true, text: '肩', fontSize: 20, position: 'top', fontColor: '#274277' }
            scales: { yAxes: [{ stacked: true }], xAxes: [{ stacked: true, ticks: { stepSize: 1 }}]}
        }
    })
    
window.recovery_5_graph = ->
    document.addEventListener 'turbolinks:load',
    ctx = document.getElementById("recovery_5").getContext('2d')
    recovery_5 = new Chart(ctx, {
        type: 'horizontalBar',
        data: {
            datasets: [{ label: '残り回復',data: [gon.today_tranings_5_recovery], backgroundColor: '#274277'}, { label: '回復日',data: [gon.today_tranings_5_recovery_5], backgroundColor: '#8fa8da' }]
        },
        options: {
            legend: { display: false }
            title: { display: true, text: '腕', fontSize: 20, position: 'top', fontColor: '#274277' }
            scales: { yAxes: [{ stacked: true }], xAxes: [{ stacked: true, ticks: { stepSize: 1 }}]}
        }
    })
    
window.recovery_6_graph = ->
    document.addEventListener 'turbolinks:load',
    ctx = document.getElementById("recovery_6").getContext('2d')
    recovery_6 = new Chart(ctx, {
        type: 'horizontalBar',
        data: {
            datasets: [{ data: [gon.today_tranings_6_recovery], backgroundColor: '#274277'}, { label: '回復日',data: [gon.today_tranings_6_recovery_6], backgroundColor: '#8fa8da' }]
        },
        options: {
            legend: { display: false }
            title: { display: true, text: '腹筋', fontSize: 20, position: 'top', fontColor: '#274277' }
            scales: { yAxes: [{ stacked: true }], xAxes: [{ stacked: true, ticks: { stepSize: 1 }}]}
        }
    })

