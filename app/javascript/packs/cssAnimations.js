$(document).ready(function() {
  const boy = document.querySelector('.boy')
  boy.classList.add('boy-animation')
  setTimeout(function() {
    boy.classList.remove('boy-animation')
  }, 1000)
})
