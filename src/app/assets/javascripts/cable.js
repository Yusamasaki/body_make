// Action Cable provides the framework to deal with WebSockets in Rails.
// You can generate new channels where WebSocket features live using the `rails generate channel` command.
//
//= require action_cable
//= require_self
//= require_tree ./channels

import {Chart} from 'chart.js';
import ChartDataLabels from 'chartjs-plugin-datalabels';

(function() {
  this.App || (this.App = {});

  App.cable = ActionCable.createConsumer();

}).call(this);


