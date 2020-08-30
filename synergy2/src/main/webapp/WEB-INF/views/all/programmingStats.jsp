<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
<!-- default header name is X-CSRF-TOKEN -->
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/>
<title>adminBoard</title>
<link rel="stylesheet" href="../resources/css/programmingStats.css">
</head>
<body>
<div id="wrap">
    
    <!-- 가운데 main 내용 -->
        <aside class="aside">
            <div class="aside_menu">
                <ul class="aside_menu_list">
                	<li class="aside_menu_top">Admin Menu</li>
                    <li class="aside_menu_list_1">
                    	<img src="../resources/image/chartIcon2.png" style="width: 13px; height: 13px; margin-right: 10px;"/>Statistics
                    	<img src="../resources/image/right2.png" style="width: 13px; height: 13px; margin-right: 10px; padding-left: 80px;"/>
                    </li>
                    <li class="aside_menu_list_2">
                     	<img src="../resources/image/task.png" style="width: 13px; height: 13px; margin-right: 10px;"/>Management
                     	<img src="../resources/image/right2.png" style="width: 13px; height: 13px; margin-right: 10px; padding-left: 52px;"/>
                     </li>
                </ul>
            </div>
        </aside>
        <header class="header">
            <div class="header_title">Admin Board</div>
        </header>
        <section class="section">
            <div class="section_chart">
                <canvas id="myChart"></canvas>
            </div>
        </section>
        <footer class="footer"></footer>
       
</div>    
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"></script>    
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>    
<script type="text/javascript">
$(document).ready(function(){
	//alert("111");
	
	var csrfHeaderName = document.getElementById('_csrf_header').content;
	var csrfTokenValue = document.getElementById('_csrf').content;
	
	console.log(csrfHeaderName);
	console.log(csrfTokenValue);
	
	let a = new Array();
			
	let b = new Array();
	
	$.ajax({
		type: 'post',
		url: '/synergy2/all/getProgrammingStats',
		dataType: 'json',
		beforeSend:function(xhr){
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		},
		success: function(data){
			
			//alert(JSON.stringify(data));
			
			
			$.each(data, function(index, items){
				
				console.log(index + " : " +items.topicTotal);
				
				a[index] = items.topicTotal
				b[index] = items.topic;
			});
			
			
			var ctx = document.getElementById('myChart').getContext('2d');
			var myChart = new Chart(ctx, {
			    type: 'doughnut',
			    data: {
			        labels: b,
			        datasets: [{
			            label: '회원 가입자수',
			            data: a,
			            backgroundColor: [
			                'rgba(255, 99, 132, 0.2)',
			                'rgba(54, 162, 235, 0.2)',
			                'rgba(255, 206, 86, 0.2)',
			                'rgba(75, 192, 192, 0.2)',
			                'rgba(153, 102, 255, 0.2)',
			            ],
			            borderColor: [
			                'rgba(255, 99, 132, 1)',
			                'rgba(54, 162, 235, 1)',
			                'rgba(255, 206, 86, 1)',
			                'rgba(75, 192, 192, 1)',
			                'rgba(153, 102, 255, 1)',
			            ],
			            borderWidth: 1
			        }]
			    },
			    options: {
			        scales: {
			            yAxes: [{
			                ticks: {
			                    beginAtZero: true
			                }
			            }]
			        }
			    }
			});
			
			
				console.log(a);
				
			
		},
		error: function(err){
			console.log(err);
		}
		
		
	});
	
	
	
});



</script>
</body>
</html>