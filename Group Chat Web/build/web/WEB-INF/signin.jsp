<%-- 
    Document   : signin
    Created on : Mar 11, 2019, 2:54:19 PM
    Author     : Lenovo T530
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

            /* Add padding to containers */
            .container {
                margin-top: 10%;
                width: 50%;
                padding: 16px;
                background-color: white;
                margin-left: 25%;
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
    <body background="images/signin.jpg">

        <form action="signin" method="post">
            <div class="container">
                <h1>Sign in</h1>
                <hr>
                <label for="username"><b>Username</b></label>
                <input type="text" placeholder="Enter username" name="username"  value="<%=request.getParameter("username")!=null?request.getParameter("username"):""%>" required>
                <%
                    if (request.getAttribute("usernameErrorMessage") != null) {
                %>
                    <p><%= request.getAttribute("usernameErrorMessage")%></p>
                <%
                    }
                %>
                <%
                    if (request.getAttribute("duplicateAccountMessage") != null) {
                %>
                    <p><%= request.getAttribute("duplicateAccountMessage")%></p>
                <%
                    }
                %>
                <label for="password"><b>Password</b></label>
                <input type="password" placeholder="Enter Password" value="<%=request.getParameter("password")!=null?request.getParameter("password"):""%>" name="password" required>
                 <%
                    if (request.getAttribute("passwordErrorMessage") != null) {
                %>
                    <p><%= request.getAttribute("passwordErrorMessage")%></p>
                <%
                    }
                %>
                <button type="submit" class="registerbtn">Sign in</button>
            </div>
            <div class="container signin">
                <p>Create an account <a href="register">Register</a>.</p>
            </div>
        </form>

    </body>
</html>
