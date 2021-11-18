window.exercise_draw_graph = -> 
    ctx = document.getElementById("exercise_myChart").getContext('2d')
    myChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: [],
            datasets: []
        },
        options: {

        }
    })