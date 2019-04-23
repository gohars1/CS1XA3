$(document).ready(function () {

    $('#submit-form').click(function (e) { 
        let querapp = {
	    "username": "rizq",
	    "password": "rubeet"

	};

	let queryJson = {
            // 'keyword':$('#keyword').val(),
            // 'datetime':$('#date-time').val(),
            'country':$('#sch-country').val()
        };
        searchTwitter(queryJson);
	    loginuser(querapp);
    });    

});

function searchTwitter(query) {
    $.ajax({
        type: 'GET',
        url: '/twittersearch/twitresults/',
        dataType: 'json',
        data: query,
        success: function(data) {
            $('#tweets').empty();
            for(var i = 0; i < data["results"].length; i++){
                $('#tweets').prepend(createTweet(data["results"][i]));
            }
            $('#tweets').append('<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>');
            
            
            console.log(data);
        },
        fail: function(error) {
            console.log(error);
        }
    });
}

function createTweet(jsonTweet){

    let tweetHtml = 
        '<blockquote class="twitter-tweet" data-lang="en">' +
            '<p lang="en" dir="ltr">' + jsonTweet["text"] +
                '<a href="">' + '</a>' +
            '</p>&mdash; ' + jsonTweet["user"]["name"] + jsonTweet["user"]["screen_name"] +   
            '<a href=""></a>' + 
        '</blockquote>';

    return tweetHtml;

}
function loginuser(query) {

    $.ajax({
        type: 'GET',
        url: '/userAuthapp/add_user/',
        dataType: 'json',
        data: query,
        success: function(data) {
            console.log(JSON.stringify(data));
        },
        fail: function(error) {
            console.log(error);
        }
    });

} 
