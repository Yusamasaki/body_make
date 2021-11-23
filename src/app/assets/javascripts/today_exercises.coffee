window.exercise_draw_graph = -> 
    ctx = document.getElementById("exercise_myChart").getContext('2d')
    myChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: gon.start_times,
            datasets: [{
              label: '消費カロリー',
              data: gon.test,
              backgroundColor: 'rgba(0, 0, 0, 0)',
              borderColor: '#0000FF',
              borderWidth: 1,
              hoverBackgroundColor: undefined,
              spanGaps: true
            }]
        },
        options: {
          # responsive: true,
          # maintainAspectRatio: false
        }
    })