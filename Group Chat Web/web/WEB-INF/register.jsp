<%-- 
    Document   : register
    Created on : Mar 12, 2019, 9:42:48 AM
    Author     : Daichi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <style>
            body {
                font-family: Arial, Helvetica, sans-serif;
                background-color: black;
            }

            * {
                box-sizing: border-box;
            }

            body{
                height: 100%;

            }

            /* Add padding to containers */
            .container {
                width: 50%;
                margin-top: 3%;
                padding: 16px;
                margin-left: 25%;
                background-color: white;
                /*height: 500px;*/
            }

            /* Full-width input fields */
            input[type=text], input[type=password] {
                width: 100%;
                padding: 15px;
                margin: 5px 0 22px 0;
                display: inline-block;
                border: none;
                background: #f1f1f1;
            }

            input[type=text]:focus, input[type=password]:focus {
                background-color: #ddd;
                outline: none;
            }

            input[type=email] {
                width: 100%;
                padding: 15px;
                margin: 5px 0 22px 0;
                display: inline-block;
                border: none;
                background: #f1f1f1;
            }

            input[type=email]:focus {
                background-color: #ddd;
                outline: none;
            }

            /* Overwrite default styles of hr */
            hr {
                border: 1px solid #f1f1f1;
                margin-bottom: 25px;
            }

            /* Set a style for the submit button */
            .registerbtn {
                background-color: #4CAF50;
                color: white;
                padding: 16px 20px;
                margin: 8px 0;
                border: none;
                cursor: pointer;
                width: 100%;
                opacity: 0.9;
            }

            .registerbtn:hover {
                opacity: 1;
            }


            /* Set a grey background color and center the text of the "sign in" section */
            .signin {
                margin: 0;
                background-color: #f1f1f1;
                text-align: center;
                margin-left: 25%;
            }
        </style>

    </head>
    <body background="images/blog.jpg">

        <form action="register" method="post">
            <div class="container">
                <h1>Register</h1>
                <p>Please fill in this form to create an account.</p>
                <hr>

                <label for="email"><b>Email</b></label>
                <input type="email" required placeholder="Enter Email" name="email" value="<%=request.getParameter("email") != null ? request.getParameter("email") : ""%>">
                
                <label for="username"><b>User Name</b></label>
                <input type="text" placeholder="Enter username" name="username" required value="<%=request.getParameter("username")!=null?request.getParameter("username"):""%>">
                <%
                    if (request.getAttribute("userEmptyErrorMessage") != null) {
                %>
                    <p><%=request.getAttribute("userEmptyErrorMessage")%></p>
                <%
                    }
                %>
                <%
                    if (request.getAttribute("userExistedErrorMessage") != null) {
                %>
                    <p><%=request.getAttribute("userExistedErrorMessage")%></p>
                <%
                    }
                %>
                <label for="displayname"><b>Display Name</b></label>
                <input type="text" placeholder="Enter displayname" name="displayname" value="<%=request.getParameter("displayname")!=null?request.getParameter("displayname"):""%>" required>
                <%
                    if (request.getAttribute("nameEmptyErrorMessage") != null) {
                %>
                    <p><%=request.getAttribute("nameEmptyErrorMessage")%></p>
                <%
                    }
                %>
                
                <label for="psw"><b>Password</b></label>
                <input type="password" placeholder="Enter Password" name="psw" value="<%=request.getParameter("psw")!=null?request.getParameter("psw"):""%>" required>
                <%
                    if (request.getAttribute("pswSpaceErrorMessage") != null) {
                %>
                    <p><%=request.getAttribute("pswSpaceErrorMessage")%></p>
                <%
                    }
                %>
                
                <label for="psw-repeat"><b>Repeat Password</b></label>
                <input type="password" placeholder="Repeat Password" name="psw-repeat" required value="<%=request.getParameter("psw-repeat")!=null ? request.getParameter("psw-repeat") : ""%>">
                <%
                    if (request.getAttribute("pswRepeatErrorMessage") != null) {
                %>
                    <p><%=request.getAttribute("pswRepeatErrorMessage")%></p>
                <%
                    }
                %>
                <hr>


                <button type="submit" class="registerbtn">Register</button>
            </div>

            <div class="container signin">
                <p>Already have an account? <a href="home">Sign in</a>.</p>
            </div>
        </form>

    </body>

</html>
