<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PDF Information | PDFlex</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/fileinfo.css">
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
        <div class="tool-header">
            <h1>PDF File Information</h1>
            <p>View detailed information about your PDF files including metadata, page count, and more.</p>
        </div>

        <!-- Server-side error message -->
        <% if (request.getAttribute("error") != null) { %>
            <div class="message error"><%= request.getAttribute("error") %></div>
        <% } %>

        <!-- Upload Form -->
        <form id="infoForm" action="SeeFileInformation" method="post" enctype="multipart/form-data">
            <section class="upload-section">
                <div class="upload-icon">
                    <i class="fas fa-info-circle"></i>
                </div>
                <h2>Select PDF file to analyze</h2>
                <p>Choose a PDF file from your device to view its information</p>
                <input type="file" id="pdfFile" name="pdfFile" class="file-input" accept=".pdf" required
                       onchange="document.getElementById('fileNameDisplay').textContent = this.files[0].name;
                                 document.getElementById('fileSelected').style.display = 'block';
                                 document.getElementById('cancelBtn').style.display = 'inline-block';">
                <label for="pdfFile" class="file-label btn-primary">Select PDF File</label>

                <div id="fileSelected" style="display: none;" class="file-selected">
                    <i class="fas fa-check-circle"></i>
                    <span id="fileNameDisplay"></span> selected
                </div>
            </section>

            <div class="action-buttons">
                <button type="submit" class="btn btn-primary btn-large">Get PDF Information</button>
                <button type="button" id="cancelBtn" class="btn btn-danger btn-large" style="display: none;"
                        onclick="resetForm()">Cancel</button>
            </div>
        </form>

        <!-- How It Works -->
        <section class="how-it-works">
            <h2>How to View PDF Information</h2>
            <div class="steps">
                <div class="step">
                    <div class="step-number">1</div>
                    <h3>Upload PDF File</h3>
                    <p>Select your PDF file from your device</p>
                </div>
                <div class="step">
                    <div class="step-number">2</div>
                    <h3>Get Information</h3>
                    <p>Click the "Get PDF Information" button</p>
                </div>
                <div class="step">
                    <div class="step-number">3</div>
                    <h3>View Details</h3>
                    <p>See all the metadata and technical details about your PDF</p>
                </div>
            </div>
        </section>

        <!-- FAQ Section -->
        <section class="faq-section">
            <h2>Frequently Asked Questions</h2>
            <div class="faq-container">
                <div class="faq-item">
                    <div class="faq-question">
                        <h3>What information can I see about my PDF?</h3>
                        <i class="fas fa-chevron-down"></i>
                    </div>
                    <div class="faq-answer">
                        <p>You can view all the metadata including title, author, subject, keywords, as well as technical details like page count, file size, encryption status, creation and modification dates.</p>
                    </div>
                </div>

                <div class="faq-item">
                    <div class="faq-question">
                        <h3>Is my PDF file stored on your servers?</h3>
                        <i class="fas fa-chevron-down"></i>
                    </div>
                    <div class="faq-answer">
                        <p>No, we process your PDF file temporarily to extract the information and don't store it permanently on our servers.</p>
                    </div>
                </div>

                <div class="faq-item">
                    <div class="faq-question">
                        <h3>What's the maximum file size I can analyze?</h3>
                        <i class="fas fa-chevron-down"></i>
                    </div>
                    <div class="faq-answer">
                        <p>You can analyze PDF files up to 50MB for free. Registered users can analyze files up to 200MB.</p>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <!-- Footer -->
    <footer>
        <div class="footer-container">
            <div class="footer-col">
                <h4>About PDFlex</h4>
                <ul>
                    <li><a href="#">Our Story</a></li>
                    <li><a href="#">Careers</a></li>
                    <li><a href="#">Blog</a></li>
                </ul>
            </div>

            <div class="footer-col">
                <h4>Popular Tools</h4>
                <ul>
                    <li><a href="merge.html">Merge PDF</a></li>
                    <li><a href="split.html">Split PDF</a></li>
                    <li><a href="edit.html">PDF Editor</a></li>
                    <li><a href="convert.html">PDF Converter</a></li>
                </ul>
            </div>

            <div class="footer-col">
                <h4>Support</h4>
                <ul>
                    <li><a href="#">Help Center</a></li>
                    <li><a href="#">Contact Us</a></li>
                    <li><a href="#">Privacy Policy</a></li>
                    <li><a href="#">Terms of Service</a></li>
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
                    <a href="#"><i class="fab fa-facebook"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-linkedin"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                </div>
            </div>
        </div>

        <div class="copyright">
            <p>&copy; 2023 PDFlex. All rights reserved.</p>
        </div>
    </footer>

    <script>
        // Function to reset the form
        function resetForm() {
            document.getElementById('infoForm').reset();
            document.getElementById('fileSelected').style.display = 'none';
            document.getElementById('cancelBtn').style.display = 'none';
        }

        // Scroll animation for elements
        document.addEventListener('DOMContentLoaded', function() {
            // Initialize elements with visible class if they're in viewport
            checkVisibility();

            // Add scroll event listener
            window.addEventListener('scroll', checkVisibility);

            // FAQ toggle functionality
            const faqQuestions = document.querySelectorAll('.faq-question');
            faqQuestions.forEach(question => {
                question.addEventListener('click', function() {
                    this.classList.toggle('active');
                    const answer = this.nextElementSibling;
                    answer.classList.toggle('show');

                    // Close other open FAQs
                    faqQuestions.forEach(q => {
                        if (q !== this && q.classList.contains('active')) {
                            q.classList.remove('active');
                            q.nextElementSibling.classList.remove('show');
                        }
                    });
                });
            });
        });

        // Function to check if elements are in viewport and add visible class
        function checkVisibility() {
            const elements = document.querySelectorAll('.tool-header, .upload-section, .action-buttons, .how-it-works, .faq-section, .faq-item, .step');

            elements.forEach(element => {
                const elementTop = element.getBoundingClientRect().top;
                const elementBottom = element.getBoundingClientRect().bottom;

                // Only check if element hasn't already been marked as visible
                if (!element.classList.contains('visible')) {
                    // Check if element is in viewport (with some threshold)
                    if (elementTop < window.innerHeight - 100 && elementBottom > 0) {
                        element.classList.add('visible');
                    }
                }
            });
        }
    </script>
</body>
</html>

