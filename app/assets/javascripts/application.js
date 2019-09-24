// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery3
//= require popper
//= require activestorage
//= require turbolinks
//= require_tree .
//= require bootstrap-sprockets
//= require bootstrap-datepicker


$(function () {
    setTimeout(function () {
        $(".alert").fadeOut(1000, function () {
            $(".remove_alert").remove();
        })
    }, 3000);


    jQuery.each( [ "put", "delete" ], function( i, method ) {
        jQuery[ method ] = function( url, data, callback, type ) {
            if ( jQuery.isFunction( data ) ) {
                type = type || callback;
                callback = data;
                data = undefined;
            }

            return jQuery.ajax({
                url: url,
                type: method,
                dataType: type,
                data: data,
                success: callback
            });
        };
    });

    function titleize(sentence) {
        if(!sentence.split) return sentence;
        var _titleizeWord = function(string) {
                return string.charAt(0).toUpperCase() + string.slice(1).toLowerCase();
            },
            result = [];
        sentence.split(" ").forEach(function(w) {
            result.push(_titleizeWord(w));
        });
        return result.join(" ");
    }
});