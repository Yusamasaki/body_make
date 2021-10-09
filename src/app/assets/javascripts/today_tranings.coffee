
# ------総負荷グラフ------

window.total_load_graph = ->
    document.addEventListener 'turbolinks:load', ->
    ctx = document.getElementById("total_load").getContext('2d')
    total_load = new Chart(ctx, {
        type: 'line',
        data: {
            labels: gon.analysis_day,
            datasets: [{
                label: [],
                data: gon.analysis_total_load,
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
    document.addEventListener 'turbolinks:load',
    ctx = document.getElementById("max_load").getContext('2d')
    max_load = new Chart(ctx, {
        type: 'line',
        data: {
            labels: gon.analysis_day,
            datasets: [{
                label: '体重',
                data: gon.analysis_max_load,
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

