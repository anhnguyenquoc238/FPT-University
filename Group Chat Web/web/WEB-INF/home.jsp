
<%@page import="model.Message"%>
<%@page import="java.util.List"%>
<%@page import="model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    User user = (User) request.getAttribute("user");
    String username = user.getName();
    List<User> onlineList = (List<User>) request.getAttribute("onlineList");
    List<Message> recentMessageList = (List<Message>) request.getAttribute("recentMessageList");
    int firstMessID = recentMessageList.size() == 0 ? 0 : recentMessageList.get(0).getID();
    int lastMessID = recentMessageList.size() == 0 ? 0 : recentMessageList.get(recentMessageList.size() - 1).getID();
%>


<!DOCTYPE html>
<html class=''>
    <meta charset='UTF-8'><meta name="robots" content="noindex">

    <title>Home</title>
    <link href='https://fonts.googleapis.com/css?family=Source+Sans+Pro:400,600,700,300' rel='stylesheet' type='text/css'>
    <link rel='stylesheet prefetch' href='https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css'>
    <link rel='stylesheet prefetch' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.6.2/css/font-awesome.min.css'>
    <%-- <script src='https://code.jquery.com/jquery-2.2.4.min.js'></script> --%>
    <script src="http://code.jquery.com/jquery-2.2.4.js"></script> 

    <style class="cp-pen-styles">
        body {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            background: #27ae60;
            font-family: "proxima-nova", "Source Sans Pro", sans-serif;
            font-size: 1em;
            letter-spacing: 0.1px;
            color: #32465a;
            text-rendering: optimizeLegibility;
            text-shadow: 1px 1px 1px rgba(0, 0, 0, 0.004);
            -webkit-font-smoothing: antialiased;
            background-image: url("images/ocean.jpg");
     
        }

        #frame {
            width: 95%;
            min-width: 360px;
            max-width: 1000px;
            height: 92vh;
            min-height: 300px;
            max-height: 720px;
            background: #E6EAEA;
        }
        @media screen and (max-width: 360px) {
            #frame {
                width: 100%;
                height: 100vh;
            }
        }
        #frame #sidepanel {
            float: left;
            min-width: 280px;
            max-width: 340px;
            width: 40%;
            height: 100%;
            background: #2c3e50;
            color: #f5f5f5;
            overflow: hidden;
            position: relative;
        }
        @media screen and (max-width: 735px) {
            #frame #sidepanel {
                width: 58px;
                min-width: 58px;
            }
        }
        #frame #sidepanel #profile {
            width: 80%;
            margin: 25px auto;
        }
        @media screen and (max-width: 735px) {
            #frame #sidepanel #profile {
                width: 100%;
                margin: 0 auto;
                padding: 5px 0 0 0;
                background: #32465a;
            }
        }
        #frame #sidepanel #profile.expanded .wrap {
            height: 210px;
            line-height: initial;
        }
        #frame #sidepanel #profile.expanded .wrap p {
            margin-top: 20px;
        }
        #frame #sidepanel #profile.expanded .wrap i.expand-button {
            -moz-transform: scaleY(-1);
            -o-transform: scaleY(-1);
            -webkit-transform: scaleY(-1);
            transform: scaleY(-1);
            filter: FlipH;
            -ms-filter: "FlipH";
        }
        #frame #sidepanel #profile .wrap {
            height: 60px;
            line-height: 60px;
            overflow: hidden;
            -moz-transition: 0.3s height ease;
            -o-transition: 0.3s height ease;
            -webkit-transition: 0.3s height ease;
            transition: 0.3s height ease;
        }
        @media screen and (max-width: 735px) {
            #frame #sidepanel #profile .wrap {
                height: 55px;
            }
        }
        #frame #sidepanel #profile .wrap img {
            width: 50px;
            border-radius: 50%;
            padding: 3px;
            border: 2px solid #e74c3c;
            height: auto;
            float: left;
            cursor: pointer;
            -moz-transition: 0.3s border ease;
            -o-transition: 0.3s border ease;
            -webkit-transition: 0.3s border ease;
            transition: 0.3s border ease;
        }
        @media screen and (max-width: 735px) {
            #frame #sidepanel #profile .wrap img {
                width: 40px;
                margin-left: 4px;
            }
        }
        #frame #sidepanel #profile .wrap img.online {
            border: 2px solid #2ecc71;
        }
        #frame #sidepanel #profile .wrap img.away {
            border: 2px solid #f1c40f;
        }
        #frame #sidepanel #profile .wrap img.busy {
            border: 2px solid #e74c3c;
        }
        #frame #sidepanel #profile .wrap img.offline {
            border: 2px solid #95a5a6;
        }
        #frame #sidepanel #profile .wrap p {
            float: left;
            margin-left: 15px;
        }
        @media screen and (max-width: 735px) {
            #frame #sidepanel #profile .wrap p {
                display: none;
            }
        }
        #frame #sidepanel #profile .wrap i.expand-button {
            float: right;
            margin-top: 23px;
            font-size: 0.8em;
            cursor: pointer;
            color: #435f7a;
        }
        @media screen and (max-width: 735px) {
            #frame #sidepanel #profile .wrap i.expand-button {
                display: none;
            }
        }
        #frame #sidepanel #profile .wrap #status-options {
            position: absolute;
            opacity: 0;
            visibility: hidden;
            width: 150px;
            margin: 70px 0 0 0;
            border-radius: 6px;
            z-index: 99;
            line-height: initial;
            background: #435f7a;
            -moz-transition: 0.3s all ease;
            -o-transition: 0.3s all ease;
            -webkit-transition: 0.3s all ease;
            transition: 0.3s all ease;
        }
        @media screen and (max-width: 735px) {
            #frame #sidepanel #profile .wrap #status-options {
                width: 58px;
                margin-top: 57px;
            }
        }
        #frame #sidepanel #profile .wrap #status-options.active {
            opacity: 1;
            visibility: visible;
            margin: 75px 0 0 0;
        }
        @media screen and (max-width: 735px) {
            #frame #sidepanel #profile .wrap #status-options.active {
                margin-top: 62px;
            }
        }
        #frame #sidepanel #profile .wrap #status-options:before {
            content: '';
            position: absolute;
            width: 0;
            height: 0;
            border-left: 6px solid transparent;
            border-right: 6px solid transparent;
            border-bottom: 8px solid #435f7a;
            margin: -8px 0 0 24px;
        }
        @media screen and (max-width: 735px) {
            #frame #sidepanel #profile .wrap #status-options:before {
                margin-left: 23px;
            }
        }
        #frame #sidepanel #profile .wrap #status-options ul {
            overflow: hidden;
            border-radius: 6px;
        }
        #frame #sidepanel #profile .wrap #status-options ul li {
            padding: 15px 0 30px 18px;
            display: block;
            cursor: pointer;
        }
        @media screen and (max-width: 735px) {
            #frame #sidepanel #profile .wrap #status-options ul li {
                padding: 15px 0 35px 22px;
            }
        }
        #frame #sidepanel #profile .wrap #status-options ul li:hover {
            background: #496886;
        }
        #frame #sidepanel #profile .wrap #status-options ul li span.status-circle {
            position: absolute;
            width: 10px;
            height: 10px;
            border-radius: 50%;
            margin: 5px 0 0 0;
        }
        @media screen and (max-width: 735px) {
            #frame #sidepanel #profile .wrap #status-options ul li span.status-circle {
                width: 14px;
                height: 14px;
            }
        }
        #frame #sidepanel #profile .wrap #status-options ul li span.status-circle:before {
            content: '';
            position: absolute;
            width: 14px;
            height: 14px;
            margin: -3px 0 0 -3px;
            background: transparent;
            border-radius: 50%;
            z-index: 0;
        }
        @media screen and (max-width: 735px) {
            #frame #sidepanel #profile .wrap #status-options ul li span.status-circle:before {
                height: 18px;
                width: 18px;
            }
        }
        #frame #sidepanel #profile .wrap #status-options ul li p {
            padding-left: 12px;
        }
        @media screen and (max-width: 735px) {
            #frame #sidepanel #profile .wrap #status-options ul li p {
                display: none;
            }
        }
        #frame #sidepanel #profile .wrap #status-options ul li#status-online span.status-circle {
            background: #2ecc71;
        }
        #frame #sidepanel #profile .wrap #status-options ul li#status-online.active span.status-circle:before {
            border: 1px solid #2ecc71;
        }
        #frame #sidepanel #profile .wrap #status-options ul li#status-away span.status-circle {
            background: #f1c40f;
        }
        #frame #sidepanel #profile .wrap #status-options ul li#status-away.active span.status-circle:before {
            border: 1px solid #f1c40f;
        }
        #frame #sidepanel #profile .wrap #status-options ul li#status-busy span.status-circle {
            background: #e74c3c;
        }
        #frame #sidepanel #profile .wrap #status-options ul li#status-busy.active span.status-circle:before {
            border: 1px solid #e74c3c;
        }
        #frame #sidepanel #profile .wrap #status-options ul li#status-offline span.status-circle {
            background: #95a5a6;
        }
        #frame #sidepanel #profile .wrap #status-options ul li#status-offline.active span.status-circle:before {
            border: 1px solid #95a5a6;
        }
        #frame #sidepanel #profile .wrap #expanded {
            padding: 100px 0 0 0;
            display: block;
            line-height: initial !important;
        }
        #frame #sidepanel #profile .wrap #expanded label {
            float: left;
            clear: both;
            margin: 0 8px 5px 0;
            padding: 5px 0;
        }
        #frame #sidepanel #profile .wrap #expanded input {
            border: none;
            margin-bottom: 6px;
            background: #32465a;
            border-radius: 3px;
            color: #f5f5f5;
            padding: 7px;
            width: calc(100% - 43px);
        }
        #frame #sidepanel #profile .wrap #expanded input:focus {
            outline: none;
            background: #435f7a;
        }
        #frame #sidepanel #search {
            border-top: 1px solid #32465a;
            border-bottom: 1px solid #32465a;
            font-weight: 300;
        }
        @media screen and (max-width: 735px) {
            #frame #sidepanel #search {
                display: none;
            }
        }
        #frame #sidepanel #search label {
            position: absolute;
            margin: 10px 0 0 20px;
        }
        #frame #sidepanel #search input {
            font-family: "proxima-nova",  "Source Sans Pro", sans-serif;
            padding: 10px 0 10px 46px;
            width: calc(100% - 25px);
            border: none;
            background: #32465a;
            color: #f5f5f5;
        }
        #frame #sidepanel #search input:focus {
            outline: none;
            background: #435f7a;
        }
        #frame #sidepanel #search input::-webkit-input-placeholder {
            color: #f5f5f5;
        }
        #frame #sidepanel #search input::-moz-placeholder {
            color: #f5f5f5;
        }
        #frame #sidepanel #search input:-ms-input-placeholder {
            color: #f5f5f5;
        }
        #frame #sidepanel #search input:-moz-placeholder {
            color: #f5f5f5;
        }
        #frame #sidepanel #contacts {
            height: calc(100% - 190px);
            overflow-y: scroll;
            overflow-x: hidden;
        }
        @media screen and (max-width: 735px) {
            #frame #sidepanel #contacts {
                height: calc(100% - 149px);
                overflow-y: scroll;
                overflow-x: hidden;
            }
            #frame #sidepanel #contacts::-webkit-scrollbar {
                display: none;
            }
        }
        #frame #sidepanel #contacts.expanded {
            height: calc(100% - 334px);
        }
        #frame #sidepanel #contacts::-webkit-scrollbar {
            width: 8px;
            background: #2c3e50;
        }
        #frame #sidepanel #contacts::-webkit-scrollbar-thumb {
            background-color: #243140;
        }
        #frame #sidepanel #contacts ul li.contact {
            position: relative;
            padding: 10px 0 25px 0;
            font-size: 0.9em;
            cursor: pointer;
        }
        @media screen and (max-width: 735px) {
            #frame #sidepanel #contacts ul li.contact {
                padding: 6px 0 46px 8px;
            }
        }
        #frame #sidepanel #contacts ul li.contact:hover {
            background: #32465a;
        }
        #frame #sidepanel #contacts ul li.contact.active {
            background: #32465a;
            border-right: 5px solid #435f7a;
        }
        #frame #sidepanel #contacts ul li.contact.active span.contact-status {
            border: 2px solid #32465a !important;
        }
        #frame #sidepanel #contacts ul li.contact .wrap {
            width: 88%;
            margin: 0 auto;
            position: relative;
        }
        @media screen and (max-width: 735px) {
            #frame #sidepanel #contacts ul li.contact .wrap {
                width: 100%;
            }
        }
        #frame #sidepanel #contacts ul li.contact .wrap span {
            position: absolute;
            left: 0;
            margin: -2px 0 0 -2px;
            width: 10px;
            height: 10px;
            border-radius: 50%;
            border: 2px solid #2c3e50;
            background: #95a5a6;
        }
        #frame #sidepanel #contacts ul li.contact .wrap span.online {
            background: #2ecc71;
        }
        #frame #sidepanel #contacts ul li.contact .wrap span.away {
            background: #f1c40f;
        }
        #frame #sidepanel #contacts ul li.contact .wrap span.busy {
            background: #e74c3c;
        }
        #frame #sidepanel #contacts ul li.contact .wrap img {
            width: 40px;
            border-radius: 50%;
            float: left;
            margin-right: 10px;
        }
        @media screen and (max-width: 735px) {
            #frame #sidepanel #contacts ul li.contact .wrap img {
                margin-right: 0px;
            }
        }
        #frame #sidepanel #contacts ul li.contact .wrap .meta {
            padding: 5px 0 0 0;
        }
        @media screen and (max-width: 735px) {
            #frame #sidepanel #contacts ul li.contact .wrap .meta {
                display: none;
            }
        }
        #frame #sidepanel #contacts ul li.contact .wrap .meta .name {
            font-weight: 600;
        }
        #frame #sidepanel #contacts ul li.contact .wrap .meta .preview {
            margin: 5px 0 0 0;
            padding: 0 0 1px;
            font-weight: 400;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            -moz-transition: 1s all ease;
            -o-transition: 1s all ease;
            -webkit-transition: 1s all ease;
            transition: 1s all ease;
        }
        #frame #sidepanel #contacts ul li.contact .wrap .meta .preview span {
            position: initial;
            border-radius: initial;
            background: none;
            border: none;
            padding: 0 2px 0 0;
            margin: 0 0 0 1px;
            opacity: .5;
        }
        #frame #sidepanel #bottom-bar {
            position: absolute;
            width: 100%;
            bottom: 0;
        }
        #frame #sidepanel #bottom-bar button {
            float: left;
            border: none;
            width: 50%;
            padding: 10px 0;
            background: #32465a;
            color: #f5f5f5;
            cursor: pointer;
            font-size: 0.85em;
            font-family: "proxima-nova",  "Source Sans Pro", sans-serif;
        }
        @media screen and (max-width: 735px) {
            #frame #sidepanel #bottom-bar button {
                float: none;
                width: 100%;
                padding: 15px 0;
            }
        }
        #frame #sidepanel #bottom-bar button:focus {
            outline: none;
        }
        #frame #sidepanel #bottom-bar button:nth-child(1) {
            border-right: 1px solid #2c3e50;
        }
        @media screen and (max-width: 735px) {
            #frame #sidepanel #bottom-bar button:nth-child(1) {
                border-right: none;
                border-bottom: 1px solid #2c3e50;
            }
        }
        #frame #sidepanel #bottom-bar button:hover {
            background: #435f7a;
        }
        #frame #sidepanel #bottom-bar button i {
            margin-right: 3px;
            font-size: 1em;
        }
        @media screen and (max-width: 735px) {
            #frame #sidepanel #bottom-bar button i {
                font-size: 1.3em;
            }
        }
        @media screen and (max-width: 735px) {
            #frame #sidepanel #bottom-bar button span {
                display: none;
            }
        }
        #frame .content {
            float: right;
            width: 60%;
            height: 94.3%;
            overflow: hidden;
            position: relative;
        }
        @media screen and (max-width: 735px) {
            #frame .content {
                width: calc(100% - 58px);
                min-width: 300px !important;
            }
        }
        @media screen and (min-width: 900px) {
            #frame .content {
                width: calc(100% - 340px);
            }
        }
        #frame .content .contact-profile {
            width: 100%;
            height: 60px;
            line-height: 60px;
            background: #f5f5f5;
        }
        #frame .content .contact-profile img {
            width: 40px;
            border-radius: 50%;
            float: left;
            margin: 9px 12px 0 9px;
        }
        #frame .content .contact-profile p {
            float: left;
        }
        #frame .content .contact-profile .social-media {
            float: right;
        }
        #frame .content .contact-profile .social-media i {
            margin-left: 14px;
            cursor: pointer;
        }
        #frame .content .contact-profile .social-media i:nth-last-child(1) {
            margin-right: 20px;
        }
        #frame .content .contact-profile .social-media i:hover {
            color: #435f7a;
        }
        #frame .content .messages {
            height: auto;
            min-height: calc(100% - 93px);
            max-height: calc(100% - 93px);
            overflow-y: scroll;
            overflow-x: hidden;
        }
        @media screen and (max-width: 735px) {
            #frame .content .messages {
                max-height: calc(100% - 105px);
            }
        }
        #frame .content .messages::-webkit-scrollbar {
            width: 8px;
            background: transparent;
        }
        #frame .content .messages::-webkit-scrollbar-thumb {
            background-color: rgba(0, 0, 0, 0.3);
        }
        #frame .content .messages ul li {
            display: inline-block;
            clear: both;
            float: left;
            margin: 15px 15px 5px 15px;
            width: calc(100% - 25px);
            font-size: 0.9em;
        }
        <%--
        #frame .content .messages ul li:nth-last-child(1) {
            margin-bottom: 20px;
        }
        --%>
        #frame .content .messages ul li.sent img {
            margin: 6px 8px 0 0;
        }
        #frame .content .messages ul li.sent p {
            background: #435f7a;
            color: #f5f5f5;
        }
        #frame .content .messages ul li.replies img {
            float: right;
            margin: 6px 0 0 8px;
        }
        #frame .content .messages ul li.replies p {
            background: #f5f5f5;
            float: right;
        }
        #frame .content .messages ul li img {
            width: 22px;
            border-radius: 50%;
            float: left;
        }
        #frame .content .messages ul li p {
            display: inline-block;
            padding: 10px 15px;
            border-radius: 20px;
            max-width: 205px;
            line-height: 130%;
        }
        @media screen and (min-width: 735px) {
            #frame .content .messages ul li p {
                max-width: 300px;
            }
        }
        #frame .content .message-input {
            position: absolute;
            bottom: 0;
            width: 100%;
            z-index: 99;
        }
        #frame .content .message-input .wrap {
            position: relative;
        }
        #frame .content .message-input .wrap input {
            font-family: "proxima-nova",  "Source Sans Pro", sans-serif;
            float: left;
            border: none;
            width: calc(100% - 90px);
            padding: 11px 32px 10px 8px;
            font-size: 0.8em;
            color: #32465a;
        }
        @media screen and (max-width: 735px) {
            #frame .content .message-input .wrap input {
                padding: 15px 32px 16px 8px;
            }
        }
        #frame .content .message-input .wrap input:focus {
            outline: none;
        }
        #frame .content .message-input .wrap .attachment {
            position: absolute;
            right: 60px;
            z-index: 4;
            margin-top: 10px;
            font-size: 1.1em;
            color: #435f7a;
            opacity: .5;
            cursor: pointer;
        }
        @media screen and (max-width: 735px) {
            #frame .content .message-input .wrap .attachment {
                margin-top: 17px;
                right: 65px;
            }
        }
        #frame .content .message-input .wrap .attachment:hover {
            opacity: 1;
        }
        #frame .content .message-input .wrap button {
            float: right;
            border: none;
            width: 50px;
            padding: 12px 0;
            cursor: pointer;
            background: #32465a;
            color: #f5f5f5;
        }
        @media screen and (max-width: 735px) {
            #frame .content .message-input .wrap button {
                padding: 16px 0;
            }
        }
        #frame .content .message-input .wrap button:hover {
            background: #435f7a;
        }
        #frame .content .message-input .wrap button:focus {
            outline: none;
        }
        #frame #sidepanel .signout1 {
            padding-top: 10px;
        }
        #frame #sidepanel .signout1 a:hover{
            cursor: pointer;
            background: #32465a;
            color: #f5f5f5;
            border: none; 
        }
    </style>

</head>
<body>
    <div id="frame">
        <div id="sidepanel">
            <div id="profile">
                <div class="wrap">
                    <img id="profile-img" src="http://emilcarlsson.se/assets/mikeross.png" class="online" alt="" />
                    <p><%=user.getName()%></p>
                </div>
            </div>
            <hr>
            <div class="title" >
                <p style="text-align: center;  margin: 0; color: #96e817; font-family: Georgia, serif">Online status</p>
            </div>
            <hr>
            <div id="contacts">
                <ul>
                    <%
                        for (User userTemp : onlineList) {
                    %>
                    <li class="contact">
                        <div class="wrap">
                            <img src="http://emilcarlsson.se/assets/mikeross.png" alt="" />
                            <div class="meta">
                                <p class="name"><%= userTemp.getName()%></p>
                                <p class="preview"></p>
                            </div>
                        </div>
                    </li>
                    <%
                        }
                    %>
                </ul>
            </div>
            <hr style="margin: 0"/>
            <div class="signout1"><a href="signout" style="color: white; padding-left: 20px;text-decoration: none; font-size: 16px;"><i class="fa fa-sign-out" aria-hidden="true" style="padding-right: 5px"></i>Sign out</a></div>
        </div>
        <div class="title" >
            <p style="text-align: center; padding-top: 5px; margin: 0; color: #1c1e21;font-weight: 600; font-size: 20px;">Group chat</p>
        </div>
        <hr>
        <div class="content">
            <div id="messages" class="messages" onscroll="scrollChange()">
                <ul id="messagesDisplayField">
                    <% for (Message m : recentMessageList) {
                            if (m.getUserName().equals(username)) {
                    %>
                    <li class="replies">
                        <img src="http://emilcarlsson.se/assets/harveyspecter.png" alt="" />
                        <p style="overflow-wrap: break-word"><%= m.getContent()%></p>
                    </li>
                    <%
                    } else {
                    %>
                    <li class="sent">
                        <!-- <p class="sa" style="color: #90949c; background-color: #E6EAEA; padding-right: 250px;">Sent name</p> -->
                        <img src="http://emilcarlsson.se/assets/mikeross.png" alt=""  style="margin-top: 50px" />
                        <p style="color: #90949c; background-color: #E6EAEA; padding-right: 83%;"><%= m.getUserName() %></p> 
                        <p style="overflow-wrap: break-word; margin-left: 5px"><%= m.getContent()%></p>
                    </li>
                    <%
                            }
                        }
                    %>

                </ul>
            </div>
            <div class="message-input">
                <div class="wrap">
                    <input id="messageField" type="text" placeholder="Write your message..." required/>
                    <button id="submitButton" class="submit" onclick="sendMessage()"><i class="fa fa-paper-plane" aria-hidden="true"></i></button>
                </div>
            </div>
        </div>
    </div>
    <script>
        var userID = <%= user.getID()%>;
        var username = '<%= user.getUsername()%>';
        var name = '<%= user.getName()%>';

        var firstMessID = <%= firstMessID%>;
        var lastMessID = <%= lastMessID%>;

        var height = 0;
        var scrollTopMax = 0;
        var check = true;

        $(document).ready(function () {
            height = 0;
            $("#messagesDisplayField li").each(function (i, value) {
                height += parseInt($(this).height());
                height += parseInt($(this).outerHeight());
            });
            document.getElementById("messages").scrollTop = height;
            scrollTopMax = document.getElementById("messages").scrollTop;
        });

        function scrollChange() {
            var y = document.getElementById("messages").scrollTop;
            //console.log("Max="+scrollTopMax);
            //console.log("Y="+y);
            if (y === 0)
                loadOldMessage();
            if (y < scrollTopMax - 5)
                check = false;
            else
                check = true;
            //console.log(check);
        }

        function loadOldMessage() {
            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function () {
                if (this.readyState === 4 && this.status === 200) {
                    showOldMessage(this);
                }
            };
            xhttp.open("POST", "getOldMess", true);
            xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            xhttp.send("firstMessID=" + firstMessID);

        }

        function showOldMessage(xhttp) {
            var xmlDoc = xhttp.responseXML;
            console.log(xmlDoc);
            var oldMessageList = xmlDoc.getElementsByTagName("message");
            if (oldMessageList.length > 0) {
                var heightCount = 0;
                for (var i = 0; i < oldMessageList.length; i++) {
                    var messageUserID = oldMessageList[i].getElementsByTagName("messageUserID")[0].childNodes[0].nodeValue;
                    var messageUserName = oldMessageList[i].getElementsByTagName("messageUserName")[0].childNodes[0].nodeValue;
                    var messageContent = oldMessageList[i].getElementsByTagName("messageContent")[0].childNodes[0].nodeValue;
                    var html;
                    if (messageUserID != userID) {
                        html = "<li class=\"sent\"><img src=\"http://emilcarlsson.se/assets/mikeross.png\" style=\"margin-top: 50px\" alt=\"\"/><p style=\"color: #90949c; background-color: #E6EAEA; padding-right: 83%;\">"+messageUserName +"</p><p style=\"overflow-wrap: break-word; margin-left: 5px\">" + messageContent + "</p></li>";
                    } else {
                        html = "<li class=\"replies\"><img src=\"http://emilcarlsson.se/assets/mikeross.png\" alt=\"\"/><p style=\"overflow-wrap: break-word\">" + messageContent + "</p></li>";
                    }
                    document.getElementById("messagesDisplayField").innerHTML = html + document.getElementById("messagesDisplayField").innerHTML;
                    heightCount += parseInt($("#messagesDisplayField li").first().outerHeight(true));
                    document.getElementById("messages").scrollTop = heightCount;
                    //console.log(heightCount);
                }
                height += heightCount;
                if (lastMessID === 0)
                    lastMessID = oldMessageList[0].getElementsByTagName("messageID")[0].childNodes[0].nodeValue;
                firstMessID = oldMessageList[oldMessageList.length - 1].getElementsByTagName("messageID")[0].childNodes[0].nodeValue;
            }
        }

        function loadInformation() {
            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function () {
                if (this.readyState === 4 && this.status === 200) {
                    showOnlineUser(this);
                    showNewMessage(this);
                }
            };
            xhttp.open("POST", "getInformation", true);
            xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
            xhttp.send("lastMessID=" + lastMessID);
        }

        function showOnlineUser(xhttp) {
            //console.log(xhttp.responseXML);
            var xmlDoc = xhttp.responseXML;
            var html = "<ul>";
            var nameList = xmlDoc.getElementsByTagName("name");
            for (var i = 0; i < nameList.length; i++) {
                html += "<li class=\"contact\"><div class=\"wrap\"><img src=\"http://emilcarlsson.se/assets/mikeross.png\" alt=\"\"/><div class=\"meta\"><p class=\"name\">";
                html += nameList[i].childNodes[0].nodeValue;
                html += "</p><p class=\"preview\"></p></div></div></li>";
            }
            html += "</ul>";
            document.getElementById("contacts").innerHTML = html;
        }

        function showNewMessage(xhttp) {
            var xmlDoc = xhttp.responseXML;
            var messageList = xmlDoc.getElementsByTagName("message");
            if (messageList.length > 0) {
                for (var i = 0; i < messageList.length; i++) {
                    var messageUserID = messageList[i].getElementsByTagName("messageUserID")[0].childNodes[0].nodeValue;
                    var messageUserName = messageList[i].getElementsByTagName("messageUserName")[0].childNodes[0].nodeValue;
                    var messageContent = messageList[i].getElementsByTagName("messageContent")[0].childNodes[0].nodeValue;
                    if (messageUserID != userID) {
                        var html = "<li class=\"sent\"><img src=\"http://emilcarlsson.se/assets/mikeross.png\" style=\"margin-top: 50px\" alt=\"\"/><p style=\"color: #90949c; background-color: #E6EAEA; padding-right: 83%;\">"+messageUserName +"</p><p style=\"overflow-wrap: break-word; margin-left: 5px\">" + messageContent + "</p></li>";
                        document.getElementById("messagesDisplayField").innerHTML += html;
                        height += parseInt($("#messagesDisplayField li").last().outerHeight(true));
                        if (check)
                            messageScrollDown();
                    } else {
                        var html = "<li class=\"replies\"><img src=\"http://emilcarlsson.se/assets/mikeross.png\" alt=\"\"/><p style=\"overflow-wrap: break-word\">" + messageContent + "</p></li>";
                        document.getElementById("messagesDisplayField").innerHTML += html;
                        messageScrollDown();
                    }
                    height += parseInt($("#messagesDisplayField li").last().outerHeight(true));
                }
                if (firstMessID === 0)
                    firstMessID = messageList[i].getElementsByTagName("messageID")[0].childNodes[0].nodeValue;
                lastMessID = messageList[messageList.length - 1].getElementsByTagName("messageID")[0].childNodes[0].nodeValue;
            }
        }

        var interval = setInterval(loadInformation, 1000);

        function messageScrollDown() {
            document.getElementById("messages").scrollTop = height;
        }

        function sendMessage() {
            var message = document.getElementById("messageField").value.trim();
            if (message === "") {
                return;
            }
            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function () {
                if (this.readyState === 4) {
                    if (this.status === 200) {
                        //document.getElementById("messagesDisplayField").innerHTML += "<li class=\"replies\"> <img src=\"http://emilcarlsson.se/assets/harveyspecter.png\" alt=\"\" /><p>" + message + "</p></li>";
                        document.getElementById("messageField").value = "";
                        //height += parseInt($("#messagesDisplayField li").last().outerHeight(true));
                        //messageScrollDown();
                        //check = true;
                    } else {
                        alert("Error occurred when sending message!");
                    }
                }
            };
            xhttp.open("POST", "sendMessage", true);
            xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded; charset=UTF-8");
            xhttp.send("content=" + message + "&userID=" + userID + "&username=" + name);
        }
    </script>
</body>
</html>
<%--
                   <li class="sent">
                       <img src="http://emilcarlsson.se/assets/mikeross.png" alt="" />
                       <p>How the hell am I supposed to get a jury to believe you when I am not even sure that I do?!</p>
                   </li>
                   <li class="replies">
                       <img src="http://emilcarlsson.se/assets/harveyspecter.png" alt="" />
                       <p>When you're backed against the wall, break the god damn thing down.</p>
                   </li>
--%>