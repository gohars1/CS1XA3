
let loginValidate = {
    "username":"empty",
    "login-status":false
};
let tweets = [];

$(document).ready(function () {

    $('#submit-form').click(function (e) { 
	    let queryJson = {
            'country':$('#sch-country').val()
        };
        searchTwitter(queryJson);
    });    

    $('#login-form').click(function(e){
        let credentials = {
            "username":$('#usefrm').val(),
            "password":$('#passfrm').val()
        };
        loginuser(credentials);
        // userinfo(credentials)
    });

    $('#add-user-form').click(function(e){
        let credentials = {
            "username":$('#usefrm').val(),
            "password":$('#passfrm').val()
        };
        adduser(credentials);
    });

});

function searchTwitter(query) {
    $.ajax({
        type: 'GET',
        url: '/e/gohars1/twittersearch/twitresults/',
        dataType: 'json',
        data: query,
        success: function(data) {
            $('#tweet-table tbody').empty();
            $('#button-box').empty();

            for(var i = 0; i < data["results"].length; i++) {
                let tweetString = '<tr>'+
                                    '<th scope=row>'+ i +'</th>' +
                                    '<td id="tweet'+i+'">' + createTweet(data["results"][i]) + '</td>' +
                                    '<td><input class="form-check-input" type="checkbox" value="" id="savetweet' + i + '"></input> </td>' +
                                  '</tr>';
                $('#tweet-table tbody').append(tweetString);
            }
            
            if(data['results'].length > 0){
                $('#button-box').html('<button align="right" type="button" class="btn btn-outline-success" id="save-selection">Save Selections</button>');
                $('#save-selection').click(selectionBtnListener);
            }

            $('#tweets').append('<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>');
            
            console.log(data);
            tweets = data['results'];
            console.log(tweets);
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

function selectionBtnListener(event) {
    if(loginValidate['login-status'] === true){
        for(let i = 0; i < 3; i++){
            // console.log($('#savetweet' + i).is(':checked'));
            if($('#savetweet' + i).is(':checked')){
                // console.log($('#tweet'+i).html());
                let tweetInfoDB = {
                    "tweetJSON":JSON.stringify(tweets[i]),
                    "tweetHTML":$('#tweet'+i).html(),
                    "username": loginValidate['username']
                }
                
                savetweet(tweetInfoDB);

            }
        }
    }
    else{
        alert('You must Log in!')
    }
}

/*********************** AJAX calls below **********************/


function loginuser(query) {
    $.ajax({
        type: 'GET',
        url: '/e/gohars1/userAuthapp/login_user/',
        dataType: 'json', //'json'
        data: query,
        success: function(data) {
            console.log(data);
            if(data['status'] === 'OK') {
                $('#user-tweets-section').html('<button style="margin-top: 5px;" type="button" class="btn btn-outline-success" id ="get-tweets-button">Show Saved Tweets</button>');
                loginValidate['login-status'] = true;
                loginValidate['username'] = query['username'];
                $("#creds :input").prop("disabled", true);
                $('#get-tweets-button').click( function(e){
                    let credentials = {
                        "username":$('#usefrm').val(),
                        "password":$('#passfrm').val()
                    };
                    userinfo(credentials);
                });
            }
            else {
                // $('#user-tweets-section').html('<h1 align"center">Please Login</h1>')
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
        url: '/e/gohars1/userAuthapp/user_info/',
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
        url: '/e/gohars1/userAuthapp/add_user/',
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

function savetweet(dataToSend){
    $.ajax({
        type: 'GET',
        url: '/e/gohars1/userAuthapp/save_tweet/',
        data: dataToSend,
        dataType: 'json',
        success: function (data) {
            console.log(data)
        },
        fail: function(error) {
            console.log(data)
        }
    })
}

function userinfo(query) {
    $.ajax({
        type: 'GET',
        url: '/e/gohars1/userAuthapp/user_info/',
        dataType: 'json',
        data: query,
        success: function(data) {
            console.log(data);
            
            if(data['status'] == 'OK'){
                $('#user-tweets-table').empty();
                for(let i = 0; i < data['tweetdata'].length; i++){
                    let trow = '<tr><th class="row">'+ data['tweetdata'][i] +'</th></tr>';
                    console.log(trow);
                    $('#user-tweets-table').append(trow);
                    $('#exampleModal').modal('show');
                }
            }
            else {
                alert("Error Please Try Again!");
            }

        },
        fail: function(error) {
            console.log(error);
        }
    });
} 



