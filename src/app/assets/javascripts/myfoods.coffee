

window.myfood_graph = ->
    ctx = document.getElementById('myRadarChart')
    myRadarChart = new Chart(ctx,
      type: 'radar'
      data:
        labels: gon.food_name,
        datasets: [ {
          label: "栄養素チャート"
          backgroundColor: "rgba(200,112,126,0.5)"
          borderColor: "rgba(200,112,126,1)"
          pointBackgroundColor: "rgba(200,112,126,1)"
          pointBorderColor: "#fff"
          pointHoverBackgroundColor: "#fff"
          pointHoverBorderColor: "rgba(200,112,126,1)"
          hitRadius: 5
          data: gon.myfoods
        } ]
      options:
        display: true
        responsive: true
    )
        
        