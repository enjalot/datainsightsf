

function loadData()
{
    console.log("log data");
}

function factual_query()
{
   //Not quite working... 
    //filter for the data
    var my_filters = {"$search":["Tallahassee"]};
    //var my_filters = {"zip_code":{"$blank":false},"healthy_options":{"$blank":false},"lat":{"$blank":false},"lon":{"$blank":false}};

    var options = {
        api_key: 'SUpqo83Vl2tXlQY6YJmiOk0C2QTStJsboqb0zZVzY3KLItz8Q7ewEz4pFqitrf1Z',
        //limit: place_limit,
        //jsoncallback: 'jQuery16109874412142671645_1308611293438',
        filters: my_filters
    };
    console.log(options);

    $.ajax({
        url: 'http://api.factual.com/v2/tables/s4OOB4/read',
        data: options,
        dataType: 'jsonp',
        success : function(data) {
            console.log(data);
        }
    });


    //$.get('http://api.factual.com/v2/tables/s4OOB4/read?APIKey=SUpqo83Vl2tXlQY6YJmiOk0C2QTStJsboqb0zZVzY3KLItz8Q7ewEz4pFqitrf1Z&filters={"latitude":{"$blank":false},"$search":["Tallahassee"]}&sort={"factual_id":1}', function(result){
        //console.log(result);
    //}
/*
    var fact = 'http://api.factual.com/v2/tables/s4OOB4/read?jsoncallback=jQuery16109874412142671645_1308611293438&APIKey=SUpqo83Vl2tXlQY6YJmiOk0C2QTStJsboqb0zZVzY3KLItz8Q7ewEz4pFqitrf1Z&filters={"latitude":{"$blank":false},"$search":["Tallahassee"]}&sort={"factual_id":1}';
    $.getJSON(fact, function(json) {
        console.log(json);    
    });
*/

}
