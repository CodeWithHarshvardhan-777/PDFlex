<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>File Protected Successfully</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
     <link rel="stylesheet" href="css/downloadpage.css">
</head>
<body>
    <header>
        <nav class="navbar">
            <a href="#" class="logo">
                <i class="fas fa-lock"></i>
                SecureFile
            </a>
            <div class="nav-links">
                <a href="#">Home</a>
                <a href="#">Tools</a>
                <a href="#">Pricing</a>
                <a href="#">Help</a>
            </div>
            <div class="auth-buttons">
                <a href="#" class="btn btn-outline">Sign In</a>
                <a href="#" class="btn btn-primary">Sign Up</a>
            </div>
        </nav>
    </header>

    <main class="main-content">
        <section class="success-section">
            <i class="fas fa-check-circle success-icon"></i>
            <h1>File Protected Successfully!</h1>
            <p>Your file has been encrypted and protected with the highest security standards. You can now download the secured file.</p>

            <div class="file-info">
                <%
                    String fileIcon = "fa-file-pdf";
                    String fileName = (String) request.getAttribute("fileName");
                    String filePath = (String) request.getAttribute("filePath");
                %>
                <i class="fas <%= fileIcon %> file-icon"></i>
                <div class="file-details">
                    <div class="file-name">
                        <%= (fileName != null) ? fileName : "ERROR : Name Not Found" %>
                    </div>
                    <div class="file-meta">
                        <%
                            String fileType = (String) request.getAttribute("fileType");
                            String fileSize = (String) request.getAttribute("fileSize");
                            if (fileType != null && fileSize != null) {
                        %>
                            <%= fileType %> • <%= fileSize %>
                        <%
                            }
                        %>
                    </div>
                </div>
            </div>

            <form class="download-form" action="DownloadFiles" method="post">
                <input type="hidden" name="filePath" value="<%= filePath != null ? filePath : "" %>">
                <input type="hidden" name="fileName" value="<%= fileName != null ? fileName : "" %>">
                <button type="submit" class="download-button">
                    <i class="fas fa-download"></i>
                    Download Protected File
                </button>
            </form>

            <div class="additional-options">
                <h3>More Options</h3>
                <div class="option-buttons">
                    <a href="upload.jsp" class="option-button">
                        <i class="fas fa-shield-alt"></i>
                        Protect Another File
                    </a>
                    <a href="#" class="option-button">
                        <i class="fas fa-envelope"></i>
                        Send via Email
                    </a>
                    <a href="#" class="option-button">
                        <i class="fas fa-cloud-upload-alt"></i>
                        Save to Cloud
                    </a>
                    <a href="#" class="option-button">
                        <i class="fas fa-link"></i>
                        Get Shareable Link
                    </a>
                </div>
            </div>
        </section>
    </main>

    <div class="copyright">
        &copy; 2023 SecureFile. All rights reserved.
    </div>

    <script>
        // Simple animation for the success icon
        document.addEventListener('DOMContentLoaded', function() {
            const successIcon = document.querySelector('.success-icon');
            successIcon.style.transform = 'scale(0)';

            setTimeout(() => {
                successIcon.style.transition = 'transform 0.5s ease-out';
                successIcon.style.transform = 'scale(1)';
            }, 100);
        });
    </script>
</body>
</html>