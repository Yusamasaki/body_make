

window.myfood_graph = -> 
    Chart.register(ChartDataLabels);
    ctx = document.getElementById('myPieChart')
    myPieChart = new Chart(ctx,
      type: 'pie'
      data:
        labels: gon.food_name,
        datasets: [ {
          backgroundColor: [
            '#BB5179'
            '#FAFF67'
            '#58A27C'
            '#3C00FF'
            '#58A27C'
            '#3C00FF'
            '#58A27C'
          ]
          data: gon.myfoods
        } ]
      options:
        display: true
        plugins: {
          datalabels: {
            align: "end",
            anchor: "end",
            offset: -100,
            color: "#000",
            font: {
                weight: "bold",
                size: 20,
            }
          }
        }
    )
        
        