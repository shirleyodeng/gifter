/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

console.log('Hello World from Webpacker')
import 'bootstrap'

$(document).ready(function() {
    $('.js-popup').click(function() {
        centerPopup($(this).attr('href'), $(this).attr('data-width'), $(this).attr('data-height'));
        return false;
    });
});

function centerPopup(linkUrl, width, height) {
    var sep = (linkUrl.indexOf('?') !== -1) ? '&' : '?',
        url = linkUrl + sep + 'popup=true',
        left = (screen.width - width) / 2 - 16,
        top = (screen.height - height) / 2 - 50,
        windowFeatures = 'menubar=no,toolbar=no,status=no,width=' + width +
            ',height=' + height + ',left=' + left + ',top=' + top;
    return window.open(url, 'authPopup', windowFeatures);
}

const stripe = document.getElementById("stuff").value
console.log(stripe)

// const stripe_btn = document.querySelector(".gift-form-actions")
// console.log(stripe_btn)

// const stripemessage = (element) => {
//   element.addEventListener("click", (event) => {
//     if (!confirm("Are you sure you want to delete?")) {
//       event.preventDefault();
//     }
//   });
// };

// stripe_btn.bindConfirm();

// <input type="button" value="Click Me!" onclick="submitForms()" />
// submitForms = function(){
//     document.getElementById("message_form").submit();
//     document.getElementById("form2").submit();
// }
