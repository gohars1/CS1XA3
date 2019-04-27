$(document).ready(function () {

    $('#submit-form').click(function (e) { 
	let queryJson = {
            // 'keyword':$('#keyword').val(),
            // 'datetime':$('#date-time').val(),
            'country':$('#sch-country').val()
        };
        searchTwitter(queryJson);
	    
    });
    
    $('#signin-form').click(function (e) { 
        // let usercode = {'user':$('#usefrm').val()}
        // let passcode = {'pass':$('#passfrm').val()}
         let jsonsign = {
             "username": $('#usefrm').val(),
             "password": $('#passfrm').val(),
 
         };
 
         adduser(jsonsign);
         
     });

     $('#login-form').click(function (e) { 
        // let usercode = {'user':$('#usefrm').val()}
        // let passcode = {'pass':$('#passfrm').val()}
         let jsonlog = {
             "username": $('#usefrm').val(),
             "password": $('#passfrm').val(),
 
         };
 
         loginuser(jsonlog);
         
     });

     $('#save-tweets').click(function (e) { 
        // let usercode = {'user':$('#usefrm').val()}
        // let passcode = {'pass':$('#passfrm').val()}
         let jsontweep = {
             "tweet" : $('#tweets').val(),
             
 
         };
 
         savetweets(jsontweep);
         
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
        url: '/userAuthapp/login_user/',
        dataType: 'json', //'json'
        data: query,
        success: function(data) {
            //console.log(JSON.stringify(data));
            console.log(data);
            if (data['status'] == "LoggedIn"){

                $('#response').html("<p>Success</p>");
            }
            else{
                $('#response').html("<p>Failure</p>");
            }
        },
        fail: function(error) {
            console.log(error);
        }
    });

} 

function userinfo(query) {

    $.ajax({
        type: 'GET',
        url: '/userAuthapp/user_info/',
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

function adduser(query) {

    $.ajax({
        type: 'GET',
        url: '/userAuthapp/add_user/',
        dataType: 'json',
        data: query,
        success: function(data) {
            console.log(data);
            if (data['status'] == "LoggedIn"){

                $('#response').html("<p>Success</p>");
            }
            else{
                $('#response').html("<p>Failure</p>");
            }
             
        },
        fail: function(error) {
            console.log(error);
        }
    });

}

function savetweets(query) {

    $.ajax({
        type: 'GET',
        url: '/userAuthapp/save_tweets/',
        dataType: 'json',
        data: query,
        success: function(data) {
            console.log(data);
            
             
        },
        fail: function(error) {
            console.log(error);
        }
    });
} 


