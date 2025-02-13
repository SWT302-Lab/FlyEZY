<%-- 
    Document   : error
    Created on : Oct 16, 2024, 7:46:02 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Access Denied</title>
        <style>
            body {
                font-family: 'Arial', sans-serif;
                background: linear-gradient(135deg, #3C6E57, #BADF6C);
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
                overflow: hidden;
            }
            .container {
                text-align: center;
                background-color: rgba(255, 255, 255, 0.9);
                padding: 3rem;
                border-radius: 20px;
                box-shadow: 0 8px 32px rgba(60, 110, 87, 0.3);
                max-width: 80%;
                width: 400px;
            }
            h1 {
                color: #3C6E57;
                margin-top: 0;
                margin-bottom: 1rem;
                font-size: 2.5rem;
            }
            p {
                color: #4a4a4a;
                margin-bottom: 2rem;
                font-size: 1.1rem;
            }
            .btn {
                display: inline-block;
                padding: 12px 24px;
                background: linear-gradient(to right, #3C6E57, #BADF6C);
                color: white;
                text-decoration: none;
                border-radius: 30px;
                transition: all 0.3s ease;
                font-weight: bold;
                text-transform: uppercase;
                letter-spacing: 1px;
            }
            .btn:hover {
                transform: translateY(-3px);
                box-shadow: 0 4px 15px rgba(60, 110, 87, 0.4);
            }
            .logo {
                width: 100px;
                height: 100px;
                margin-bottom: 1rem;
            }
            @keyframes float {
                0% {
                    transform: translateY(0px);
                }
                50% {
                    transform: translateY(-20px);
                }
                100% {
                    transform: translateY(0px);
                }
            }
            .floating {
                animation: float 3s ease-in-out infinite;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <svg class="logo floating" viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
            <circle cx="50" cy="50" r="50" fill="#E57373"/>
            <path d="M30 30 L70 70 M70 30 L30 70" stroke="white" stroke-width="10" stroke-linecap="round"/>
            </svg>
            <h1>Access Denied</h1>
            <p>You do not have permission to access this page.</p>
            <a href="home" class="btn">Back to Home</a>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', (event) => {
                const container = document.querySelector('.container');
                container.style.opacity = '0';
                container.style.transform = 'translateY(20px)';
                container.style.transition = 'opacity 0.5s ease, transform 0.5s ease';

                setTimeout(() => {
                    container.style.opacity = '1';
                    container.style.transform = 'translateY(0)';
                }, 100);
            });
        </script>
    </body>
</html>

