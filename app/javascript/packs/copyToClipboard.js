document.querySelector("#visible-button").onclick = function() {
  document.querySelector("#visible-input").select();
  document.execCommand('copy');
};
