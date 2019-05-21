

<%@page import="model.Message"%>
<%@page import="model.User"%>
<%@page import="java.util.List"%>
<%
    List<User> onlineUserList = (List<User>) request.getAttribute("onlineUserList");
    List<Message> newMessageList = (List<Message>) request.getAttribute("newMessageList");
%>
<%@page contentType="text/xml" pageEncoding="UTF-8"%>
<body>
<onlineUserList>
    <% for (User userTemp : onlineUserList) {%>
    <user>
        <id><%= userTemp.getID()%></id>
        <username><%= userTemp.getUsername()%></username>
        <name><%= userTemp.getName()%></name>
    </user>
    <% } %>
</onlineUserList>

<messageList>
    <% for (Message m : newMessageList) {%>
    <message>
        <messageID><%= m.getID()%></messageID>
        <messageUserID><%= m.getUserID() %></messageUserID>
        <messageUserName><%= m.getUserName()%></messageUserName>
        <messageContent><%= m.getContent()%></messageContent>
    </message>
    <% }%>
</messageList>
</body>