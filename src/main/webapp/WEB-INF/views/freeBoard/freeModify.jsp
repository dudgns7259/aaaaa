<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>    
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
                            <p>수정하기</p>
                        </div>
                        
                        <form action="#" name="modifyForm" method="post">
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
                                <input class="form-control" name='writer' value="${boardVO.writer }">
                            </div>    
                            <div class="form-group">
                                <label>제목</label>
                                <input class="form-control" name='title' value="${boardVO.title }">
                            </div>

                            <div class="form-group">
                                <label>내용</label>
                                <textarea class="form-control" rows="10" name='content'>${boardVO.content }</textarea>
                            </div>

                            <button type="button" class="btn btn-dark" id="listBtn">목록</button>    
                            <button type="button" class="btn btn-primary" id="updateBtn">변경</button>
                            <button type="button" class="btn btn-info" id="deleteBtn">삭제</button>
                    </form>
                                    
                </div>
            </div>
        </div>
        </section>
        
        <%@ include file="../include/footer.jsp" %>
        
        
        <script>
        	//목록이동
        	var listBtn = document.getElementById("listBtn");
        	listBtn.onclick = function() {
        		location.href = "freeList"; 
        	}
        	//수정버튼
        	var updateBtn = document.getElementById("updateBtn");
        	updateBtn.onclick = function() {
        		
        		/*
        		1. 폼에 데이터가 공백인지 확인처리
        		2. 공백이 없으면 Controller에 freeUpdate요청으로 데이터를 전송.
        		3. 컨트롤러에서는 int update()메서드를 사용해서 정보를 수정
        		4. 컨트롤러에서는 업데이트 성공시 "게시글 수정이 정상 처리되었습니다" 를 출력해주세요
        		*/
        		
        		if(document.modifyForm.writer.value === '') {
        			alert("작성자는 필수 사항 입니다");
        			document.modifyForm.writer.focus();
        			return;
        		} else if(document.modifyForm.title.value === '') {
        			alert("제목은 필수 사항 입니다");
        			document.modifyForm.title.focus();
        			return;
        		} else if(document.modifyForm.content.value === '') {
        			alert("내용은 필수 사항 입니다");
        			document.modifyForm.content.focus();
        			return;
        		} else {
        			//폼의 action값을 변경
        			document.modifyForm.action = "freeUpdate";
        			document.modifyForm.submit();
        		}
        		
        		
          	}
        	//삭제버튼
        	var deleteBtn = document.getElementById("deleteBtn");
        	deleteBtn.onclick = function() {
        		
        		document.modifyForm.action = "freeDelete";
        		document.modifyForm.submit();
        	}
        	
        </script>
        
        
</body>
</html>