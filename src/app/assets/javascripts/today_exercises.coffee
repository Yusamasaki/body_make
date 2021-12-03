window.exercise_draw_graph = -> 
	ctx = document.getElementById("exercise_myChart").getContext('2d')
	myChart = new Chart(ctx, {
		type: 'line',
		data: {
			labels: gon.start_times,
			datasets: [{
				label: '消費カロリー',
				data: gon.calorie,
				backgroundColor: 'rgba(0, 0, 0, 0)',
				borderColor: '#0000FF',
				borderWidth: 1,
				backgroundColor: '#bddbf0',
				pointBackgroundColor: '#0000FF',
				pointRadius: 1,
				hoverBackgroundColor: undefined,
				spanGaps: false,
				# lineTension: 0
			}],
		},
		options: {
		#   responsive: true,
		#   maintainAspectRatio: false
		}
	})