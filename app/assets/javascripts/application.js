// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree
//= require bootstrap.min.js
//= require jquery.metisMenu.js
//= require morris/raphael-2.1.0.min.js
//= require morris/morris.js
//= require custom.js

// objTextBox = getElementById("valorField");
  // alert( "thiago ." );
// $( "#valorField" ).blur(function() {
//   alert( "Handler for .blur() called." );
// });
// $('#valorField').on('blur', function() {
//     alert("teste");
// //../../../vendor/assets/javascripts
// });
//
// objTextBox = $( "#valorField" ).val();
// function MascaraMoeda(objTextBox, SeparadorMilesimo, SeparadorDecimal, e){
//     var sep = 0;
//     var key = '';
//     var i = j = 0;
//     var len = len2 = 0;
//     var strCheck = '0123456789';
//     var aux = aux2 = '';
//     var whichCode = (window.Event) ? e.which : e.keyCode;
//     if ((whichCode == 13) || (whichCode == 0) || (whichCode == 8)) return true;
//     key = String.fromCharCode(whichCode); // Valor para o código da Chave
//     if (strCheck.indexOf(key) == -1) return false; // Chave inválida
//     len = objTextBox.value.length;
//     for(i = 0; i < len; i++)
//         if ((objTextBox.value.charAt(i) != '0') &#038;& (objTextBox.value.charAt(i) != SeparadorDecimal)) break;
//     aux = '';
//     for(; i < len; i++)
//         if (strCheck.indexOf(objTextBox.value.charAt(i))!=-1) aux += objTextBox.value.charAt(i);
//     aux += key;
//     len = aux.length;
//     if (len == 0) objTextBox.value = '';
//     if (len == 1) objTextBox.value = '0'+ SeparadorDecimal + '0' + aux;
//     if (len == 2) objTextBox.value = '0'+ SeparadorDecimal + aux;
//     if (len > 2) {
//         aux2 = '';
//         for (j = 0, i = len - 3; i >= 0; i--) {
//             if (j == 3) {
//                 aux2 += SeparadorMilesimo;
//                 j = 0;
//             }
//             aux2 += aux.charAt(i);
//             j++;
//         }
//         objTextBox.value = '';
//         len2 = aux2.length;
//         for (i = len2 - 1; i >= 0; i--)
//         objTextBox.value += aux2.charAt(i);
//         objTextBox.value += SeparadorDecimal + aux.substr(len - 2, len);
//     }
//     return false;
// }
