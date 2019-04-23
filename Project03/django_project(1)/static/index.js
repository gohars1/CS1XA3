$(document).ready(function () {

    $('#submit-form').click(function (e) { 
        let queryJson = {
            'keyword':$('#keyword').val(),
            'datetime':$('#date-time').val(),
            'country':$('#sch-country').val()
        };
        searchTwitter(queryJson);
    });    

});

function searchTwitter(query) {
    $.ajax({
        type: 'GET',
        url: '/twittersearch/twitresults/',
        dataType: 'json',
        data: query,
        success: function(data) {
            
            for(var i = 0; i < data["results"].length; i++){
                $('#tweets').append(createTweet(data["results"][i]));
            }
            
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
            '<p lang="en" dir="ltr">' + jsonTweet["text"]
                '<a href="' + jsonTweet["urls"][0]["url"] + '">' + jsonTweet["urls"][0]["url"] +
            '</p>&mdash; ' + jsonTweet["user"]["name"] + jsonTweet["user"]["screen_name"] +   
            '<a href="https://twitter.com/TwitterSupport/status/806207281410883584?ref_src=twsrc%5Etfw">December 6, 2016</a>' + 
        '</blockquote>';

    return tweetHtml;

}