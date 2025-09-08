<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PDF Information Results | PDFlex</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/showfileinfo.css">
    </head>
<body>
    <!-- Header/Navigation -->
    <header>
        <nav class="navbar">
            <a href="HomePage.html" class="logo">
                <i class="fas fa-file-pdf"></i>
                <span>PDFlex</span>
            </a>

            <div class="nav-links">
                <a href="MainPage.html">Tools</a>
                <a href="#features">Features</a>
                <a href="#pricing">Pricing</a>
                <a href="#about">About</a>
            </div>

            <div class="auth-buttons">
                <a href="login.html" class="btn btn-outline">Log In</a>
                <a href="signup.html" class="btn btn-primary">Sign Up</a>
            </div>
        </nav>
    </header>

    <!-- Main Content -->
    <main class="main-content">
        <div class="results-header">
            <h1>PDF File Information</h1>
            <p>Detailed information about your PDF file</p>
        </div>

        <!-- Server-side messages -->
        <% if (request.getAttribute("error") != null) { %>
            <div class="message error"><i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("error") %></div>
        <% } %>

        <!-- File Summary -->
        <div class="file-summary">
            <div class="file-icon">
                <i class="fas fa-file-pdf"></i>
            </div>
            <div class="file-details">
                <div class="file-name"><%= request.getAttribute("fileName") %></div>
                <div class="file-meta">
                    <span><i class="fas fa-file"></i> <%= request.getAttribute("fileSize") %></span>
                    <span><i class="fas fa-copy"></i> <%= request.getAttribute("pages") %> pages</span>
                    <span><i class="fas fa-lock"></i> <%= request.getAttribute("lock") %></span>
                </div>
            </div>
        </div>

        <!-- Information Grid -->
        <div class="info-grid">
            <div class="info-card">
                <h3><i class="fas fa-info-circle"></i> Basic Information</h3>
                <div class="info-item">
                    <span class="info-label">File Name:</span>
                    <span class="info-value"><%= request.getAttribute("fileName") %></span>
                </div>
                <div class="info-item">
                    <span class="info-label">File Size:</span>
                    <span class="info-value"><%= request.getAttribute("fileSize") %></span>
                </div>
                <div class="info-item">
                    <span class="info-label">Pages:</span>
                    <span class="info-value"><%= request.getAttribute("pages") %></span>
                </div>
                <div class="info-item">
                    <span class="info-label">Encrypted:</span>
                    <span class="info-value"><%= request.getAttribute("lock") %></span>
                </div>
            </div>

            <div class="info-card">
                <h3><i class="fas fa-database"></i> Document Metadata</h3>
                <div class="info-item">
                    <span class="info-label">Title:</span>
                    <span class="info-value <%= request.getAttribute("title") == null ? "not-specified" : "" %>">
                        <%= request.getAttribute("title") != null ? request.getAttribute("title") : "Not specified" %>
                    </span>
                </div>
                <div class="info-item">
                    <span class="info-label">Author:</span>
                    <span class="info-value <%= request.getAttribute("author") == null ? "not-specified" : "" %>">
                        <%= request.getAttribute("author") != null ? request.getAttribute("author") : "Not specified" %>
                    </span>
                </div>
                <div class="info-item">
                    <span class="info-label">Subject:</span>
                    <span class="info-value <%= request.getAttribute("subject") == null ? "not-specified" : "" %>">
                        <%= request.getAttribute("subject") != null ? request.getAttribute("subject") : "Not specified" %>
                    </span>
                </div>
                <div class="info-item">
                    <span class="info-label">Keywords:</span>
                    <span class="info-value <%= request.getAttribute("keyword") == null ? "not-specified" : "" %>">
                        <%= request.getAttribute("keyword") != null ? request.getAttribute("keyword") : "Not specified" %>
                    </span>
                </div>
                <div class="info-item">
                    <span class="info-label">Creator:</span>
                    <span class="info-value <%= request.getAttribute("creator") == null ? "not-specified" : "" %>">
                        <%= request.getAttribute("creator") != null ? request.getAttribute("creator") : "Not specified" %>
                    </span>
                </div>
                <div class="info-item">
                    <span class="info-label">Producer:</span>
                    <span class="info-value <%= request.getAttribute("producer") == null ? "not-specified" : "" %>">
                        <%= request.getAttribute("producer") != null ? request.getAttribute("producer") : "Not specified" %>
                    </span>
                </div>
            </div>

            <div class="info-card">
                <h3><i class="fas fa-calendar-alt"></i> Dates</h3>
                <div class="info-item">
                    <span class="info-label">Creation Date:</span>
                    <span class="info-value <%= request.getAttribute("Creation") == null ? "not-specified" : "" %>">
                        <%= request.getAttribute("Creation") != null ? request.getAttribute("Creation") : "Not available" %>
                    </span>
                </div>
                <div class="info-item">
                    <span class="info-label">Last Modification Date:</span>
                    <span class="info-value <%= request.getAttribute("Modification") == null ? "not-specified" : "" %>">
                        <%= request.getAttribute("Modification") != null ? request.getAttribute("Modification") : "Not available" %>
                    </span>
                </div>
            </div>
        </div>

        <div class="action-buttons">
            <a href="fileinfo.jsp" class="btn btn-primary btn-large">
                <i class="fas fa-redo"></i> Analyze Another PDF
            </a>
            <a href="MainPage.html" class="btn btn-secondary btn-large">
                <i class="fas fa-tools"></i> Explore More Tools
            </a>
        </div>
    </main>

    <!-- Footer -->
    <footer>
        <div class="footer-container">
            <div class="footer-col">
                <h4>About PDFlex</h4>
                <ul>
                    <li><a href="#"><i class="fas fa-chevron-right"></i> Our Story</a></li>
                    <li><a href="#"><i class="fas fa-chevron-right"></i> Careers</a></li>
                    <li><a href="#"><i class="fas fa-chevron-right"></i> Blog</a></li>
                </ul>
            </div>

            <div class="footer-col">
                <h4>Popular Tools</h4>
                <ul>
                    <li><a href="merge.html"><i class="fas fa-chevron-right"></i> Merge PDF</a></li>
                    <li><a href="split.html"><i class="fas fa-chevron-right"></i> Split PDF</a></li>
                    <li><a href="edit.html"><i class="fas fa-chevron-right"></i> PDF Editor</a></li>
                    <li><a href="convert.html"><i class="fas fa-chevron-right"></i> PDF Converter</a></li>
                </ul>
            </div>

            <div class="footer-col">
                <h4>Support</h4>
                <ul>
                    <li><a href="#"><i class="fas fa-chevron-right"></i> Help Center</a></li>
                    <li><a href="#"><i class="fas fa-chevron-right"></i> Contact Us</a></li>
                    <li><a href="#"><i class="fas fa-chevron-right"></i> Privacy Policy</a></li>
                    <li><a href="#"><i class="fas fa-chevron-right"></i> Terms of Service</a></li>
                </ul>
            </div>

            <div class="footer-col">
                <h4>Stay Connected</h4>
                <ul>
                    <li><a href="#"><i class="fab fa-facebook"></i> Facebook</a></li>
                    <li><a href="#"><i class="fab fa-twitter"></i> Twitter</a></li>
                    <li><a href="#"><i class="fab fa-linkedin"></i> LinkedIn</a></li>
                </ul>
                <div class="social-links">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-linkedin-in"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                </div>
            </div>
        </div>

        <div class="copyright">
            <p>&copy; 2023 PDFlex. All rights reserved.</p>
        </div>
    </footer>

    <script>
        // Enhanced animations for elements when page loads
        document.addEventListener('DOMContentLoaded', function() {
            const elements = document.querySelectorAll('.file-summary, .info-card, .action-buttons');

            // Initial state for all animated elements
            elements.forEach(element => {
                element.style.opacity = '0';
                element.style.transform = 'translateY(20px)';
                element.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
            });

            // Animate elements with staggered delay
            elements.forEach((element, index) => {
                setTimeout(() => {
                    element.style.opacity = '1';
                    element.style.transform = 'translateY(0)';
                }, 150 * index);
            });

            // Add hover effect to cards
            const cards = document.querySelectorAll('.info-card');
            cards.forEach(card => {
                card.addEventListener('mouseenter', () => {
                    card.style.transform = 'translateY(-8px)';
                });
                card.addEventListener('mouseleave', () => {
                    card.style.transform = 'translateY(0)';
                });
            });
        });
    </script>
</body>
</html>