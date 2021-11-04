

window.myfood_graph = ->
    ctx = document.getElementById('myRadarChart')
    myRadarChart = new Chart(ctx,
      type: 'radar'
      data:
        labels: gon.food_name,
        datasets: [
          {
            label: "栄養素チャート"
            backgroundColor: "rgba(200,112,126,0.5)"
            borderColor: "rgba(200,112,126,1)"
            pointBackgroundColor: "rgba(200,112,126,1)"
            pointBorderColor: "#fff"
            pointHoverBackgroundColor: "#fff"
            pointHoverBorderColor: "rgba(200,112,126,1)"
            hitRadius: 5
            data: gon.myfoods
          },
          {
            label: "目標栄養素"
            backgroundColor: "rgba(200,112,200,0.5)"
            borderColor: "rgba(200,112,200,1)"
            pointBackgroundColor: "rgba(200,112,200,1)"
            pointBorderColor: "#fff"
            pointHoverBackgroundColor: "#fff"
            pointHoverBorderColor: "rgba(200,112,200,1)"
            hitRadius: 5
            data: gon.myfoods
          }
        ]
      options:
        display: true
        responsive: true
        title:
          display: true,
          fontSize: 20,
          text: "総カロリー#{gon.total_calorie}kcal中"
          position: 'bottom'
        legend:
          display: false
        scale:
          pointLabels:
            fontSize: 16
            fontColor: "green"
          ticks:
            min: 0
            max: 100
            stepSize: 20
            fontSize: 12
            fontColor: "purple"
          angleLines:
            display: true,
            color: "purple"
          gridLines:
            display: true,
            color: "lime"
    )
        
        