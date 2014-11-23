function test() {
    $.ajax({
        type: "GET",
        dataType: "jsonp",
        url: "http://localhost:50097/ProxyService.svc/lookup/LOCATION",
        success: function (data) {
            alert(data);
        }
    });

}