// // progressbar.js@1.0.0 version is used
// // Docs: http://progressbarjs.readthedocs.org/en/1.0.0/

import ProgressBar from 'progressbar.js'

var bar = new ProgressBar.Circle(progress, {
  color: '#EB5757',
  // This has to be the same size as the maximum width to
  // prevent clipping
  strokeWidth: 20,
  trailWidth: 5,
  easing: 'easeInOut',
  duration: 2800,
  text: {
    autoStyleContainer: false
  },
  from: { color: '#EB5757', width: 5 },
  to: { color: '#EB5757', width: 20 },
  // Set default step function for all animate calls
  step: function(state, circle) {
    circle.path.setAttribute('stroke', state.color);
    circle.path.setAttribute('stroke-width', state.width);

    var value = Math.round(circle.value() * 100);
    if (value === 0) {
      circle.setText('');
    } else {
      circle.setText(`${value}%`);
    }

  }
});
bar.text.style.fontFamily = 'Quicksand", sans-serif';
bar.text.style.fontSize = '2rem';


const amountRaised = document.getElementById("amount-raised").dataset.date;
console.log(amountRaised);

setTimeout(function() {
  bar.animate(amountRaised / 100);  // Number from 0.0 to 1.0
})

