window.exercise_draw_graph = -> 
	ctx = document.getElementById("exercise_myChart").getContext('2d')
	myChart = new Chart(ctx, {
		type: 'bar',
		data: {
			labels: gon.month_start_times,
			datasets: [{
				label: '消費カロリー',
				data: gon.month_calorie,
				backgroundColor: 'rgba(0, 0, 255, 0.3)',
				borderColor: '#0000FF',
				borderWidth: 1,
				pointRadius: 1,
				hoverBackgroundColor: undefined,
				spanGaps: false,
			}]
		}
	})
