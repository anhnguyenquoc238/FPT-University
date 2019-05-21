
<%@page import="java.util.List"%>
<%@page import="model.Message"%>
<%@page import="model.Message"%>
<%
    List<Message> oldMessageList = (List<Message>) request.getAttribute("oldMessageList");
%>
<%@page contentType="text/xml" pageEncoding="UTF-8"%>
<body>
<oldMessageList>
    <% for(Message m: oldMessageList){ %>
    <message>
        <messageID><%= m.getID() %></messageID>
        <messageUserID><%= m.getUserID() %></messageUserID>
        <messageUserName><%= m.getUserName() %></messageUserName>
        <messageContent><%= m.getContent() %></messageContent>
    </message>
    <% } %>
</oldMessageList>
</body>