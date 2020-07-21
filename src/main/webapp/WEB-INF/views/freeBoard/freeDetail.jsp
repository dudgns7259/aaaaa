<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>인덱스를 만들어 보자</title>

    <link href="${pageContext.request.contextPath }/resources/css/bootstrap.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <!--개인 디자인 추가-->
    <link href="${pageContext.request.contextPath }/resources/css/style.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath }/resources/js/bootstrap.js"></script>
	

</head>
<body>
	
	<%@ include file="../include/header.jsp" %>
	<!--게시판-->
    <section>
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-md-9 write-wrap">
                        <div class="titlebox">
                            <p>상세보기</p>
                        </div>
                        
                        <form action="freeModify" method="post">
                            <div>
                                <label>DATE</label>
                                <p><fmt:formatDate value="${boardVO.regdate }" pattern="yyyy-MM-dd"/></p>
                            </div>   
                            <div class="form-group">
                                <label>번호</label>
                                <input class="form-control" name='bno' value="${boardVO.bno }" readonly>
                            </div>
                            <div class="form-group">
                                <label>작성자</label>
                                <input class="form-control" name='writer' value="${boardVO.writer }" readonly>
                            </div>    
                            <div class="form-group">
                                <label>제목</label>
                                <input class="form-control" name='title' value="${boardVO.title }" readonly>
                            </div>

                            <div class="form-group">
                                <label>내용</label>
                                <textarea class="form-control" rows="10" name='content' readonly>${boardVO.content }</textarea>
                            </div>

                            <button type="submit" class="btn btn-primary">변경</button>
                            <button type="button" class="btn btn-dark">목록</button>
                    	</form>
                </div>
            </div>
        </div>
        </section>
        
        <section style="margin-top: 80px;">
            <div class="container">
                <div class="row">
                    <div class="col-xs-12 col-md-9 write-wrap">
                        <form class="reply-wrap">
                            <div class="reply-image">
                                <img src="../resources/img/profile.png">
                            </div>
                        <!--form-control은 부트스트랩의 클래스입니다-->
	                    <div class="reply-content">
	                        <textarea class="form-control" rows="3" id="reply"></textarea>
	                        
	                        <div class="reply-group">
	                              <div class="reply-input">
	                              <input type="text" class="form-control" id="replyId" placeholder="이름">
	                              <input type="password" class="form-control" id="replyPw" placeholder="비밀번호">
	                              </div>
	                              
	                              <button type="button" class="right btn btn-info" id="replyRegist">등록하기</button>
	                        </div>
	
	                    </div>
                        </form>

                        <!--여기에접근 반복-->
                        
                        <div id="replyList">
                        
					<!--  
                       <div class='reply-wrap'>
                            <div class='reply-image'>
                                <img src='../resources/img/profile.png'>
                            </div>
                            <div class='reply-content'>
                                <div class='reply-group'>
                                    <strong class='left'>honggildong</strong> 
                                    <small class='left'>2019/12/10</small>
                                    <a href='#' class='right'><span class='glyphicon glyphicon-pencil'></span>수정</a>
                                    <a href='#' class='right'><span class='glyphicon glyphicon-remove'></span>삭제</a>
                                </div>
                                <p class='clearfix'>여기는 댓글영역</p>
                            </div>
                        </div> 
                        -->
                        
                        </div>
                    </div>
                </div>
            </div>
        </section>
        
        <%@ include file="../include/footer.jsp" %>
        
        
        <script>
        	
        	//화면 로딩이 끝난 직후 실행되는 제이쿼리
        	$(document).ready(function() {
        		
        		$("#replyRegist").click(function() {
        			add();    			
        		})
        		
        		//등록함수
        		function add() {
        			
        			var bno = "${boardVO.bno}"; //컨트롤러에서 넘어온 게시글번호
        			var reply = $("#reply").val(); //reply태그의 값
        			var replyId = $("#replyId").val(); //replyId태그의 값
        			var replyPw = $("#replyPw").val(); //replyPw태그의 값
        			
        			
	       			if(reply === '' || replyId === '' || replyPw === '' ) {
	       				alert("이름, 비밀번호, 내용을 입력하세요");
	       				return;
	       			}
        			
        			$.ajax({
        				type: "POST", //요청방식
        				url: "../reply/replyRegist",
        				data: JSON.stringify({"bno": bno, "reply": reply, "replyId": replyId, "replyPw": replyPw}), //문자열의형태로 변경해서 요청
        				dataType: "text", //서버로 부터 어떤형식으로 받을건지(생략가능)
        				contentType: "application/json; charset=utf-8", //기본값은 폼형식을 지정하는데, JSON형식으로 보낼때는 반드시 타입을 명시해야함
        				success: function(data) { //요청성공시 돌려받을 콜백함수
        					if(data == 1){ //등록성공
        						$("#reply").val("");
        						$("#replyId").val("");
        						$("#replyPw").val("");
        						getList(); //목록메서드
        					}else{
        						alert("등록에 실패했습니다. 잠시 후에 다시 시도하세요");
        					}
        				},
        				error: function(status, error) { //에러 발생시 실행시킬 콜백함수
        					console.log("등록에 실패했습니다 관리자에게 문의하세요");
        				}
        			})
        			
        			
        			
        		}//add함수 end
        		
        		getList(); //상세화면 진입시에 리스트목록을 가져오기 위해
        		
        		
        		//목록 요청 메서드
        		function getList(){
        			
        			var bno = "${boardVO.bno}";
        			$.getJSON("../reply/getList/"+bno, //첫번째 매개변수는 경로, 다음은 성공시 콜백함수, get방식에 특화된 방식
        			function(data){
        				console.log(data);
        				
        				if(data.length <= 0 ){
        					return; //함수종료
        				}
        				
        				var strAdd = ""; //화면에 그려넣을 태그를 문자열의 형태로 추가할 변수
        				for(var i = 0 ; i < data.length; i++){
        					
                          	strAdd += "<div class='reply-wrap' style = 'display:none;''>'";
                        	strAdd += "<div class='reply-image'>";
                        	strAdd += "  <img src='../resources/img/profile.png'>";
                        	strAdd += "  </div>";
                        	strAdd += "  <div class='reply-content'>";
                        	strAdd += "   <div class='reply-group'>";
                        	strAdd += "       <strong class='left'>" + data[i].replyId+"</strong> ";
                        	strAdd += "       <small class='left'>" + timeStamp(data[i].replyDate) + "</small>";
                        	strAdd += "       <a href=' "+ data[i].rno + " ' class='right replyModify'><span class='glyphicon glyphicon-pencil'></span>수정</a>";
                        	strAdd += "       <a href=' "+ data[i].rno + " ' class='right replyDelete'><span class='glyphicon glyphicon-remove'></span>삭제</a>";
                        	strAdd += "    </div>";
                        	strAdd += "    <p class='clearfix'>" + data[i].reply + "</p>";
                        	strAdd += "    </div>";
                        	strAdd += "   </div> ";
                        
        				}
        				$("#replyList").html(strAdd); //relpyList에 문자열형식으로 한번에 추가
        				$(".reply-wrap").fadeIn(500); //화면을 그릴때  display:none으로 선언하고, 제이쿼리fadeIn함수로 서서히 보이게 처리
        			}) 
        			
        		}//getList  함수 end
        		
        		
        		//수정 삭제
        		/*
        		에이젝스의 실행이 더 늦게 완료가 되므로, 실제 이벤트의 선언이 먼저 실행되게 됩니다.
        		그러면 화면에 댓글 관련 창은 아무것도 등록 되지 않은 형태이므로, 일반 클릭이벤트가 동작하지 않습니다.
        		이때 이미 존재하는 replyList에 이벤트를 등록하고 해당 태그의 이벤트를 자식에게 전파시켜 사용하는 제이쿼리의 이벤트 
        		위임함수를 반드시 써야합니다.
        		*/
        		
        		$("#replyList").on("click", "a", function(){
        			event.preventDefault();
        			// 1. 수정버튼인지 확인
        			// 제이쿼리 this는 자바스크립트event.target코드와 비슷합니다.
        			// hasClass는 매개값이 포함되어있으면 true 아니면 false를 반환하는 클래스확인 함수입니다.
        			
        				var rno = $(this).attr("href");
        				$("#modalRno").val(rno);
        				
        			if( $(this).hasClass("replyModify") ){
        				//수정모달형식으로 변경
        				//모달창에 히든태그에 댓글의 변호를 세팅
        			
        				$(".modal-title").html("댓글수정");
        				$("#modalReply").css("display", "inline");
        				$("#modalModBtn").css("display", "lnline");
        				$("#modalDelBtn").css("display", "none");
        				$("#replyModal").modal("show");
        			}else{
        				//삭제모달형식으로 변경 replyDelete
        				//모달창에 히든태그에 댓글의 변호를 세팅
        				$("#modalRno").val($(".replyDelete").href());
        				$(".modal-title").html("댓글삭제")
        				$("#modalReply").css("display", "none");
        				$("#modalDelBtn").css("display", "inline");
        				$("#modalModBtn").css("display", "none");
        				$("#replyModal").modal("show");
        				
        			}
        		})
        		
        		
        		//수정함수
        		$("#modalModBtn").click(function(){
        			
        			var rno = 	$("#modalRno").val();
        			var replyPw =$("#modalPw").val(); 
        			var modalReply =$("#modalReply").val(); 
        			
        			console.log(rno);
        			console.log(replyPw);
        			console.log(modalReply);



        			
        			$.ajax({
        				type : "POST",
        				url : "../reply/update",
        				data: JSON.stringify({"rno": rno, "reply": modalReply, "replyPw": replyPw}),
        				dataType: "text", //서버로 부터 어떤형식으로 받을건지(생략가능)
        				contentType: "application/json; charset=utf-8", //기본값은 폼형식을 지정하는데, JSON형식으로 보낼때는 반드시 타입을 명시해야함
        				success: function(data) { 
        					console.log(date);
        					
        				if(data == 1){
        					alert("업데이트성공");
        				}
        				
        				},
        				error: function() { 
        					console.log("등록에 실패했습니다 관리자에게 문의하세요");
        				}
        			})//ajax end
        			
        		/*
        		1. 모달창에 rno값 replyPw값을 얻습니다.
        		2. ajax함수를 이용해서 POST방식으로 reply/update 요청으로, 필요한 값은 JSON형식으로 처리해서 요청
        		3. 서버에서요청을 받아서 비밀번호 확인하고, 비밀번호가 맞다면 업데이트 진행하면 됩니다.
        		4. 만약 비밀번호가 틀렸다면, 0을 반환해서 비밀번호가 틀렸습니다. 경고창을 띄우세요.
        		5. 업데이트가 진행된 다음에는 모달창의 값을 공백으로 초기화시키세요
        		*/
        		})
        		
        		//삭제함수
        		$("#modalDelBtn").click(function(){
        			
        		})
        		
        		
        		
        		timeStamp();
        		function timeStamp(millis){
        			var date =  new Date(); //현재날짜
        			var gap = date.getTime() - millis; //헌재날짜를 전체 밀리초로 변환 - 등록일 밀리초 == 시간차
        			
        			var time; //리턴할 시간
        			
        			if(gap < 1000 * 60 * 60 * 24){ //1일 이상인 경우
        				
        				if(gap < 1000 * 60 * 60){//1시간 미만인 경우
        					time = "방금전";
        				}else{//1시간 이상인 경우
        					time = parseInt(gap / (1000 * 60 * 60)) + "시간 전";
        				} 
        			
        			}else{ //1일 이상인 경우
        				var today = new Date(millis);
        				var year = today.getFullYear(); //년
        				var month = today.getMonth() + 1; //월
        				var day = today.getDate(); //일
        				var hour = today.getHours(); //시
        				var minute = today.getMinutes(); //분
        				var second = today.getSeconds(); //초
        				
        				time = year + "년" + month + "월" + day + "일 " + hour + ":" + minute + ":" + second ;
        				console.log(time)
        			}
        			
        			return time;
        		}
        		
        		
        	})//ready함수 end
        
        

        </script>
        
        
        <button data-target = "#replyModal" data-toggle = "modal">모달</button>
        
		<!-- 모달 -->
		<div class="modal fade" id="replyModal" role="dialog">
			<div class="modal-dialog modal-md">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="btn btn-default pull-right" data-dismiss="modal">닫기</button>
						<h4 class="modal-title">댓글수정</h4>
					</div>
					<div class="modal-body">
						<!-- 수정폼 id값을 확인하세요-->
						<div class="reply-content">
						<textarea class="form-control" rows="4" id="modalReply" placeholder="내용입력"></textarea>
						<div class="reply-group">
							<div class="reply-input">
							    <input type="hidden" id="modalRno">
								<input type="password" class="form-control" placeholder="비밀번호" id="modalPw">
							</div>
							<button class="right btn btn-info" id="modalModBtn">수정하기</button>
							<button class="right btn btn-info" id="modalDelBtn">삭제하기</button>
						</div>
						</div>
						<!-- 수정폼끝 -->
					</div>
				</div>
			</div>
		</div>
	
	
	
	
	
	
	
</body>
</html>