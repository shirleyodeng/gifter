// // progressbar.js@1.0.0 version is used
// // Docs: http://progressbarjs.readthedocs.org/en/1.0.0/
import ProgressBar from 'progressbar.js'

<<<<<<< HEAD
var progressElements = document.querySelectorAll('.progress')

progressElements.forEach((progress) => {

  var bar = new ProgressBar.Circle(progress, {
    color: '#EB5757',
    // This has to be the same size as the maximum width to
    // prevent clipping
    strokeWidth: 10,
    trailWidth: 1,
    easing: 'easeInOut',
    duration: 2400,
    text: {
      autoStyleContainer: false
    },
    from: { color: '#EB5757', width: 3 },
    to: { color: '#EB5757', width: 10 },
    // Set default step function for all animate calls
    step: function(state, circle) {
      circle.path.setAttribute('stroke', state.color);
      circle.path.setAttribute('stroke-width', state.width);

      var value = Math.round(circle.value() * 100);
      if (value === 0) {
        circle.setText('0%');
      } else {
        circle.setText(`${value}%`);
      }
=======
var bar = new ProgressBar.Circle(progress, {
  color: '#EB5757',
  // This has to be the same size as the maximum width to
  // prevent clipping
  strokeWidth: 10,
  trailWidth: 1,
  easing: 'easeInOut',
  duration: 2400,
  text: {
    autoStyleContainer: false
  },
  from: { color: '#EB5757', width: 3 },
  to: { color: '#EB5757', width: 10 },
  // Set default step function for all animate calls
  step: function(state, circle) {
    circle.path.setAttribute('stroke', state.color);
    circle.path.setAttribute('stroke-width', state.width);

    var value = Math.round(circle.value() * 100);
    if (value === 0) {
      circle.setText('');
      circle.setText('0%');
    } else {
      circle.setText(`${value}%`);
    }
    }
  });
  bar.text.style.fontFamily = '"Quicksand", sans-serif';
  bar.text.style.fontSize = '2rem';

<<<<<<< HEAD
  var amountRaised = progress.getAttribute('data-integer')

  setTimeout(function() {
    bar.animate(amountRaised);  // Number from 0.0 to 1.0
  })
=======
document.querySelectorAll("#amount-raised").forEach
console.log(amountRaised);
>>>>>>> f40b037c2f77a3b714e0dc1db89a56a05301b538

})






