# 今月分の運動グラフ
window.month_exercise_draw_graph = -> 
	ctx = document.getElementById("month_exercise_chart").getContext('2d')
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

# 今週分の運動グラフ
window.week_exercise_draw_graph = -> 
	ctx = document.getElementById("week_exercise_chart").getContext('2d')
	myChart = new Chart(ctx, {
		type: 'bar',
		data: {
			labels: gon.week_start_times,
			datasets: [{
				label: '消費カロリー',
				data: gon.week_calorie,
				backgroundColor: 'rgba(0, 0, 255, 0.3)',
				borderColor: '#0000FF',
				borderWidth: 1,
				pointRadius: 1,
				hoverBackgroundColor: undefined,
				spanGaps: false,
			}]
		}
	})
