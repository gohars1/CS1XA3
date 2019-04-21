$(document).ready(function () {

    $('#submit-form').click(function (e) { 
        searchTwitter('help');
    });    

});

function searchTwitter(query) {
    $.ajax({
        type: 'GET',
        url: 'twitresults/',
        dataType: 'json',
        data: {
            "query":$("exampleFormControlInput1").Val()
        },
        success: function(data) {
            console.log(data);
        },
        fail: function(error) {
            console.log(error);
        }
    });
}
