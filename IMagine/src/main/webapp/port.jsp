<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>simpleMap</title>
<script
	src="https://apis.openapi.sk.com/tmap/jsv2?version=1&appKey=l7xx5984ad8526554fe4a7e46987ba0c0d97"></script>
<script type="text/javascript">
	var map;
	var marker;
	// 페이지가 로딩이 된 후 호출하는 함수입니다.
	function initTmap(){
		// map 생성
		// Tmapv2.Map을 이용하여, 지도가 들어갈 div, 넓이, 높이를 설정합니다.
		let judgment = false;

		map = new Tmapv2.Map("map_div", {
			center: new Tmapv2.LatLng(37.571518, 126.983677),
			width: "100%",
			height: "400px"
		});
		//마커생성
		    marker = new Tmapv2.Marker({
			position: new Tmapv2.LatLng(37.571518, 126.983677), //Marker의 중심좌표 설정.
			draggable : false,
			
			map: map //Marker가 표시될 Map 설정.
		});
		
		var content = "<div style='position: static; display: flex; font-size: 14px; box-shadow: 5px 5px 5px #00000040; border-radius: 10px; flex-direction: column; top: 180px; left : 800px; width : 300px; background-color: #FFFFFF; padding: 5px;'>"+
					   "<div class='img-box' style=' position: relative; width: 100%; height: 90px; border-radius: 10px; background: #f5f5f5 url(resources/images/sample/p-sk-logo.png) no-repeat center;'>"+
					   "<a href='javascript:void(0)' onclick='onClose()' class='btn-close' style='position: absolute; top: 10px; right: 10px; display: block; width: 15px; height: 15px; background: url(resources/images/sample/btn-close-b.svg) no-repeat center;'></a>"+
					   "</div>"+
					   "<div class='info-box' style='padding: 10px;'>"+
					   "<p style='margin-bottom: 7px; overflow: hidden;'>"+
					   "<span class='tit' style=' font-size: 16px; font-weight: bold;'>티맵 모빌리티</span>"+
					   "<a href='http://tmapapi.sktelecom.com/' target='_blank' class='link' style='color: #3D6DCC; font-size: 13px; float: right;'>홈페이지</a>"+
					   "</p>"+
					   "<p>"+
					   "<span class='new-addr'>서울특별시 종로구 우정국로 26</span>"+
					   "</p>"+
					   "<p>"+
					   "<span class='old-addr' style='color: #707070;'>B동 24, 25,26층(공평동, 센트로폴리스빌딩)</span>"+
					   "</p>"+
					   "</div>"+
					   "</div>";                     

		//Marker에 클릭이벤트 등록.
		marker.addListener("click", function(evt) {
			//document.getElementById("result").innerHTML = 'Mouse Click!';
			//Popup 객체 생성.
			if (judgment === false) {
				judgment = true;

				infoWindow = new Tmapv2.InfoWindow({
					position: new Tmapv2.LatLng(37.571518, 126.983677), //Popup 이 표출될 맵 좌표
					content: content, //Popup 표시될 text
					type: 2, //Popup의 type 설정.
					//map: map //Popup이 표시될 맵 객체
				});
				infoWindow.setMap(map);
			}
			else {
				judgment = false;
				infoWindow.setMap(null);

			}
		});
		//Marker에 우클릭이벤트 등록
		marker.addListener("contextmenu", function(evt) {
			//document.getElementById("result").innerHTML = 'Mouse contextmenu!';						                                   
			  if (judgment === false) {
					judgment = true;

					infoWindow = new Tmapv2.InfoWindow({
						position: new Tmapv2.LatLng(37.571518, 126.983677), //Popup 이 표출될 맵 좌표
						content: "<input type='button' value='활 성 화' onclick='icon_blue()'/>"+
	                             "<input type='button' value='비활성화' onclick='icon_red()'/>", //버튼 생성
						type: 2, //Popup의 type 설정.
						//map: map //Popup이 표시될 맵 객체
					});
					infoWindow.setMap(map);
					
				}
				else {
					judgment = false;
					infoWindow.setMap(null);

				}
            
		});
		//Marker에 마우스가 마커 영역에 들어왔을때 이벤트 등록.
		marker.addListener("mouseenter", function(evt) {
			//document.getElementById("result").innerHTML = 'Mouse Enter!';
		});
		//Marker에 마우스가 마커를 벗어났을때 이벤트 등록.
		marker.addListener("mouseleave", function(evt) {
			//document.getElementById("result").innerHTML = 'Mouse Leave!';
		});

		//Marker draggable: true일때, 마커가 움직일때 이벤트 등록
		marker.addListener("drag", function (evt) {
			console.log("drag="+evt.latLng);
		});
		//Marker draggable: true일때, 마커의 움직임이 끝날때 이벤트 등록
		marker.addListener("dragend", function (evt) {
			console.log("dragend="+evt.latLng);
		});

		//모바일상에서 Marker draggable: true일때, 마커 터치를 시작할때 이벤트 등록
		marker.addListener("touchstart", function (evt) {
			console.log("touchstart="+evt.latLng);
		});
		//모바일상에서 Marker draggable: true일때, 마커 터치가 끝날때 이벤트 등록
		marker.addListener("touchend", function (evt) {
			console.log("touchend="+evt.latLng);
		});
		//모바일상에서 Marker draggable: true일때, 마커 터치 후 움직일때 이벤트 등록
		marker.addListener("touchmove", function (evt) {
			console.log("touchmove="+evt.latLng);
			});

	}

	//닫기 아이콘 클릭시 호출되는 함수.
	function onClose(popup){
		infoWindow.setVisible(false);
	}
	
    function icon_red(){
         marker.setIcon("http://tmapapi.sktelecom.com/upload/tmap/marker/pin_r_m_x.png");
		}
    function icon_blue(){
    	marker.setIcon("http://tmapapi.sktelecom.com/upload/tmap/marker/pin_b_m_a.png");
}
		
</script>
</head>
<body onload="initTmap()"><!-- 맵 생성 실행 -->
	<hi>GCS DISPLAY</hi>
	<div id="map_div"></div>
	<p id="result"/>
</body>
</html>