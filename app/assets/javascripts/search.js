// Hits the backend endpoints to search for tweets using the different filters
function searchTweets() {
    var url = "http://localhost:3000/search/twitter";
    var filter = document.getElementById('filter');
    var filterValue = filter.options[filter.selectedIndex].value;
    var searchBoxValue = document.getElementById('search-box').value;
    if (filterValue == 'connection') {
        url = url + '/user/';
        url = url + searchBoxValue;
    } else if (filterValue == 'hash_tag') {
        url = url + '/hashtag/';
        url = url + searchBoxValue;
    } else {
        url = url + '/date/';
        searchBoxValue = searchBoxValue.split(' ');
        keyword = searchBoxValue[0];
        date = searchBoxValue[1].split('since:')[1];
        url = url + keyword + '-' + date;
    }
    $.get(url, function(data) {
        displayTweets(data);
        console.log(data);
    })
}

// Displays the tweets as a list
function displayTweets(data) {
    var tweets = document.getElementById("tweets");
    while (tweets.hasChildNodes()) {
        tweets.removeChild(tweets.lastChild);
    }
    for (var i=0; i<data.length; i++) {
        console.log('here now!');
        console.log(data[i].user.screen_name);
        var item = document.createElement("li");
        item.innerText = data[i].user.name + "(@" + data[i].user.screen_name + "): " + data[i].text;
        item.style = 'list-style-type: none; padding-bottom: 25px;'
        tweets.appendChild(item);
    }
}
