
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <title>Title</title>
    <sec:csrfMetaTags/>
    <sec:authentication property="principal" var="customVO" />
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js" ></script>
<script>
    $(document).ready(function() {
        if(window.android){
            console.info("android");
            window.android.callSettingsActivity("${customVO.loginVO.email}");
        }
        else{
           location.href="/main";
        }
    });
</script>
<body>
</body>
</html>
