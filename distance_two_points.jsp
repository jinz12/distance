<%-- 
    Document   : calculate_distance
    Created on : Sep 15, 2017, 9:57:01 AM
    Author     : Jacks
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href='css/bootstrap.css' type="text/css" rel="stylesheet">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Distance Matrix</title>
        <script type="text/javascript" src="http://code.jquery.com/jquery-1.9.1.min.js"></script>
   <script src='http://maps.googleapis.com/maps/api/js?v=3&sensor=false&amp;libraries=places&key=YOURKEY'></script>
    <script type="text/javascript" src="js/jquery.auto-complete.js"></script>
<script type="text/javascript">
    
var source, destination;
var directionsDisplay;
var directionsService = new google.maps.DirectionsService();
google.maps.event.addDomListener(window, 'load', function () {
    new google.maps.places.SearchBox(document.getElementById('txtSource'));
    new google.maps.places.SearchBox(document.getElementById('txtDestination'));
    directionsDisplay = new google.maps.DirectionsRenderer({ 'draggable': true });
});
 
function GetRoute() {
    var mumbai = new google.maps.LatLng(18.9750, 72.8258);
    var mapOptions = {
        zoom: 7,
        center: mumbai
    };
    map = new google.maps.Map(document.getElementById('dvMap'), mapOptions);
    directionsDisplay.setMap(map);
    directionsDisplay.setPanel(document.getElementById('dvPanel'));
 
    //*********DIRECTIONS AND ROUTE**********************//
    source = document.getElementById("txtSource").value;
    destination = document.getElementById("txtDestination").value;
 
    var request = {
        origin: source,
        destination: destination,
        travelMode: google.maps.TravelMode.DRIVING
    };
    directionsService.route(request, function (response, status) {
        if (status == google.maps.DirectionsStatus.OK) {
            directionsDisplay.setDirections(response);
        }
    });
 
    //*********DISTANCE AND DURATION**********************//
    var service = new google.maps.DistanceMatrixService();
    service.getDistanceMatrix({
        origins: [source],
        destinations: [destination],
        travelMode: google.maps.TravelMode.DRIVING,
        unitSystem: google.maps.UnitSystem.METRIC,
        avoidHighways: false,
        avoidTolls: false
    }, function (response, status) {
        if (status == google.maps.DistanceMatrixStatus.OK && response.rows[0].elements[0].status != "ZERO_RESULTS") {
            var distance = response.rows[0].elements[0].distance.text;
            var duration = response.rows[0].elements[0].duration.text;
            var dvDistance = document.getElementById("dvDistance");
           dvDistance.innerHTML = "";
            dvDistance.innerHTML += "Distance: " + distance + "<br />";
            dvDistance.innerHTML += "Duration:" + duration;
 
        } else {
            alert("Unable to find the distance via road.");
        }
    });
}
    
</script>
    </head>
    <body>
        <table border="0" cellpadding="0" cellspacing="3">
<tr>
    <td colspan="2">
        Source:
        <input type="text" id="txtSource" class="form-control" value="Bandra, Mumbai, India" style="width: 200px" />
        &nbsp; Destination:
        <input type="text" id="txtDestination" class="form-control" value="Andheri, Mumbai, India" style="width: 200px" />
        <br />
        <input type="submit" class="brn btn-sm btn-success" value="Get Route" onclick="GetRoute()" />
        <hr />
    </td>
</tr>
<tr>
    <td colspan="2">
        <div id="dvDistance">
        </div>
    </td>
</tr>
<tr>
    <td>
        <div id="dvMap"  style="width: 500px; height: 500px">
        </div>
    </td>
    
    <td>
        <div id="dvPanel" style="width: 500px; height: 500px">
        </div>
    </td>
</tr>
</table>
    </body>
</html>
