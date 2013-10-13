//
// Global state
//
// map     - the map object
// usermark- marks the user's position on the map
// markers - list of markers on the current map (not including the user position)
// 
//

//
// First time run: request current location, with callback to Start
//
if (navigator.geolocation)  {
    navigator.geolocation.getCurrentPosition(Start);
}


function UpdateMapById(id, tag) {

    var target = document.getElementById(id);
    if (target) {
		var data = target.innerHTML;

		var rows  = data.split("\n");
	   
		for (i in rows) {
		var cols = rows[i].split("\t");
		var lat = cols[0];
		var long = cols[1];

		markers.push(new google.maps.Marker({ map:map,
								position: new google.maps.LatLng(lat,long),
								title: tag+"\n"+cols.join("\n")}));
		
		}
	}
}

function ClearMarkers()
{
    // clear the markers
    while (markers.length>0) { 
	markers.pop().setMap(null);
    }
}


function UpdateMap()
{
    var color = document.getElementById("color");
    
    color.innerHTML="<b><blink>Updating Display...</blink></b>";
    color.style.backgroundColor='white';

    ClearMarkers();

    UpdateMapById("committee_data","COMMITTEE");
    UpdateMapById("candidate_data","CANDIDATE");
    UpdateMapById("individual_data", "INDIVIDUAL");
    //UpdateMapById("opinion_data","OPINION");


    color.innerHTML="Ready";
    
    if (Math.random()>0.5) { 
	color.style.backgroundColor='blue';
    } else {
	color.style.backgroundColor='red';
    }

}

function NewData(data)
{
  var target = document.getElementById("data");
  
  target.innerHTML = data;

  UpdateMap();

}

function ViewShift()
{
    var bounds = map.getBounds();

    var ne = bounds.getNorthEast();
    var sw = bounds.getSouthWest();

    var color = document.getElementById("color");

    color.innerHTML="<b><blink>Querying...("+ne.lat()+","+ne.lng()+") to ("+sw.lat()+","+sw.lng()+")</blink></b>";
    color.style.backgroundColor='white';
	// get the committee/candidate/individual checkbox values and construct the correct query parameters
    var type_filters = [$("#committee_filter"),$("#candidate_filter"),$("#individual_filter")];
    var whatStr = "";
    for (i in type_filters) {
			type = type_filters[i];
			if (type.is(":checked")) {
					whatStr += type.attr("name") + ",";
			}
	}
	if (whatStr != "") {
			whatStr = whatStr.substring(0,whatStr.length - 1);
	} else { //if nothing is selected, default to committees
		whatStr = "committees";
	}
	// get the cycle range from the select boxes and construct the appropriate query parameters
	var cyclefrom = formatCycle($("#select-cycleFrom option:selected").text());
	var cycleto = formatCycle($("#select-cycleTo option:selected").text());
	
	console.log("from = " + cyclefrom + ", to = " + cycleto);
	
	console.log("whatStr = " + whatStr);
	// debug status flows through by cookie
    $.get("rwb.pl?act=near&latne="+ne.lat()+"&longne="+ne.lng()+"&latsw="+sw.lat()+"&longsw="+sw.lng()+"&format=raw&cyclefrom=" + cyclefrom + "&cycleto=" + cycleto + "&what="+whatStr, NewData);
}


function Reposition(pos)
{
    var lat=pos.coords.latitude;
    var long=pos.coords.longitude;

    map.setCenter(new google.maps.LatLng(lat,long));
    usermark.setPosition(new google.maps.LatLng(lat,long));
}


function Start(location) 
{
  var lat = location.coords.latitude;
  var long = location.coords.longitude;
  var acc = location.coords.accuracy;
  
  var mapc = $( "#map");

  map = new google.maps.Map(mapc[0], 
			    { zoom:16, 
				center:new google.maps.LatLng(lat,long),
				mapTypeId: google.maps.MapTypeId.HYBRID
				} );

  usermark = new google.maps.Marker({ map:map,
					    position: new google.maps.LatLng(lat,long),
					    title: "You are here"});

  markers = new Array;

  var color = document.getElementById("color");
  color.style.backgroundColor='white';
  color.innerHTML="<b><blink>Waiting for first position</blink></b>";

  google.maps.event.addListener(map,"bounds_changed",ViewShift);
  google.maps.event.addListener(map,"center_changed",ViewShift);
  google.maps.event.addListener(map,"zoom_changed",ViewShift);

  navigator.geolocation.watchPosition(Reposition);

}

function formatCycle(raw) {
	// raw format is "'## - '##" 
	yr_a = raw.substring(1,3);
	yr_b = raw.substring(7,9);
	
	if (yr_a == "00") {
		yr_a = "";
		if (yr_b[0] == "0") {
			yr_b = yr_b[1];
		}
	} else if (yr_a[0] == "0") {
		yr_a = yr_a[1];
	}
	return yr_a + yr_b;
}

