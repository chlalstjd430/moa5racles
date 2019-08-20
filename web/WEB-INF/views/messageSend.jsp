<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
    <meta name="viewport" content="width=device-width, user-scalable=no">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>
    <script src="${pageContext.request.contextPath}/resources/js/messageSend.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/messageSend.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/requestStoreInfo.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.9.0/css/all.css">
    <link href="https://fonts.googleapis.com/css?family=Nanum+Gothic&display=swap" rel="stylesheet">
    <sec:csrfMetaTags/>
    <title>MOA</title>
</head>
<body>
<%@ include file="navbar.jsp" %>
<div class="popup_wrapper"></div>
<div class="container">
    <div class="content">
        <div class="mypage_menubar">
            <div class="menubar_title">
                <h1>마이 페이지</h1>
            </div>
            <div class="menubar_subtitle">
                <h3>MY PAGE</h3>
            </div>
            <div class="menubar_list">
                <ul>
                    <li onclick="location.href='/mypage/myinfo'">개인정보</li>
                    <li class="current_menu" onclick="location.href='/mypage/message'">메세지함</li>
                    <li onclick="moveToTransaction();">거래내역</li>
                    <li onclick="location.href='/mypage/requestlist/1'">보관해주세요 신청 목록</li>
                    <li onclick="moveToLatest();">최근 본 보관소</li>
                    <li onclick="moveToFavorite();">즐겨찾는 보관소</li>
                </ul>
            </div>
        </div>

        <div class="main">
            <div class="main_title">
                <table>
                    <tr>
                        <th id="table_title1" onclick="location.href='/mypage/message/receive'">받은 메세지</th>
                        <th id="table_title2" onclick="location.href='/mypage/message/send'">보낸 메세지</th>
                        <th id="table_space">
                            <button id="add_btn"type="button" name="button"
                                    onclick="sendPopup()">
                                메세지 작성
                            </button>
                            <button id="delete_btn"type="button" name="button">
                                삭제
                            </button>
                        </th>
                    </tr>
                </table>
            </div>

            <div class="main_content">
                <table>
                    <tr>
                        <td id="title_select">선택<input id="selectAll"type="checkbox"></td>
                        <td id="title_profile">읽음</td>
                        <td id="title_nick">닉네임</td>
                        <td id="title_content">내용</td>
                        <td id="title_date">날짜</td>
                        <td id="title_time">시간</td>
                    </tr>
                    <c:choose>
                        <c:when test="${pagination.listCnt == 0}">

                            <tr>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td>보낸 메시지가 없습니다.</td>
                                <td></td>
                                <td></td>
                            </tr>

                        </c:when>
                        <c:when test="${pagination.listCnt != 0}">
                            <c:forEach var="i" begin="0" end="${pagination.curListCnt}" step="1" items="${messageVOList}">
                                    <tr>
                                        <td><input type="checkbox" name="chk" value="${i.messageId}"></td>
                                        <c:if test="${i.readState == 0}">
                                            <td><i class="far fa-envelope"></i></td>
                                        </c:if>
                                        <c:if test="${i.readState == 1}">
                                            <td><i class="far fa-envelope-open"></i></td>
                                        </c:if>
                                        <td>${i.receiverNick}</td>
                                        <c:if test="${fn:length(i.content) > 30}">
                                            <td onclick="popupOpen(${i.messageId})" style="text-align: left;">${fn:substring(i.content,0,35).concat("...")}</td>
                                        </c:if>
                                        <c:if test="${fn:length(i.content) <= 30}">
                                            <td onclick="popupOpen(${i.messageId})" style="text-align: left;">${i.content}</td>
                                        </c:if>

                                        <td>${i.sendDate}</td>
                                        <td>${i.sendTime}</td>
                                    </tr>

                            </c:forEach>
                        </c:when>
                    </c:choose>
                    
                    

                </table>
            </div>
            <div class="main_paging">
                <c:if test="${pagination.curPage == 1}">
                    <i class="fas fa-angle-left"></i>
                </c:if>
                <c:if test="${pagination.curPage != 1}">
                    <i class="fas fa-angle-left" style="cursor: pointer" onclick="location.href='/mypage/message/send/${pagination.curPage - 1}'"></i>
                </c:if>

                <c:forEach var="i" begin="${pagination.startPage}" end="${pagination.endPage}" step="1">
                    <c:if test="${pagination.curPage == i}">
                        <span style="font-weight: bold">&nbsp;${i}&nbsp;</span>
                    </c:if>
                    <c:if test="${pagination.curPage != i}">
                        <span style="cursor: pointer" onclick="location.href='/mypage/message/send/${i}'">&nbsp;${i}&nbsp;</span>
                    </c:if>
                </c:forEach>

                <c:if test="${pagination.curPage == pagination.endPage}">
                    <i class="fas fa-angle-right"></i>
                </c:if>
                <c:if test="${pagination.curPage != pagination.endPage}">
                    <i class="fas fa-angle-right" style="cursor: pointer" onclick="location.href='/mypage/message/send/${pagination.curPage + 1}'"></i>
                </c:if>
            </div>

        </div>

    </div>
</div>
<%@ include file="footer.jsp" %>
</body>
</html>