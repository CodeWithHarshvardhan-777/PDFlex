<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Compress PDF - Reduce PDF File Size | PDFlex</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #2563eb;
            --primary-light: #3b82f6;
            --primary-dark: #1d4ed8;
            --secondary-color: #10b981;
            --danger-color: #ef4444;
            --text-dark: #1f2937;
            --text-medium: #4b5563;
            --text-light: #6b7280;
            --bg-light: #ffffff;
            --bg-med: #f9fafb;
            --border-radius-sm: 6px;
            --border-radius-md: 8px;
            --border-radius-lg: 12px;
            --shadow-sm: 0 1px 3px rgba(0, 0, 0, 0.1);
            --shadow-md: 0 4px 6px rgba(0, 0, 0, 0.1);
            --shadow-lg: 0 10px 15px rgba(0, 0, 0, 0.1);
            --transition: all 0.2s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--bg-light);
            color: var(--text-dark);
            line-height: 1.5;
        }

        /* Header Styles */
        header {
            background-color: var(--bg-light);
            box-shadow: var(--shadow-sm);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 2rem;
            max-width: 1200px;
            margin: 0 auto;
        }

        .logo {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-color);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .logo i {
            font-size: 1.8rem;
        }

        .nav-links {
            display: flex;
            gap: 1.5rem;
        }

        .nav-links a {
            color: var(--text-medium);
            text-decoration: none;
            font-weight: 500;
            transition: var(--transition);
        }

        .nav-links a:hover {
            color: var(--primary-color);
        }

        .auth-buttons {
            display: flex;
            gap: 1rem;
        }

        .btn {
            padding: 0.5rem 1rem;
            border-radius: var(--border-radius-sm);
            font-weight: 500;
            cursor: pointer;
            transition: var(--transition);
            text-decoration: none;
            display: inline-block;
        }

        .btn-outline {
            border: 1px solid var(--primary-color);
            color: var(--primary-color);
            background-color: transparent;
        }

        .btn-outline:hover {
            background-color: var(--primary-color);
            color: white;
        }

        .btn-primary {
            background-color: var(--primary-color);
            color: white;
            border: 1px solid var(--primary-color);
        }

        .btn-primary:hover {
            background-color: var(--primary-dark);
            border-color: var(--primary-dark);
        }

        /* Main Content */
        .main-content {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 2rem;
        }

        .tool-header {
            text-align: center;
            margin-bottom: 3rem;
            opacity: 0;
            transform: translateY(20px);
            transition: opacity 0.5s ease, transform 0.5s ease;
        }

        .tool-header.visible {
            opacity: 1;
            transform: translateY(0);
        }

        .tool-header h1 {
            font-size: 2.2rem;
            margin-bottom: 1rem;
            color: var(--text-dark);
        }

        .tool-header p {
            color: var(--text-medium);
            max-width: 700px;
            margin: 0 auto;
        }

        /* Upload Section */
        .upload-section {
            background-color: white;
            border-radius: var(--border-radius-md);
            padding: 3rem 2rem;
            box-shadow: var(--shadow-sm);
            text-align: center;
            margin-bottom: 3rem;
            border: 2px dashed #d1d5db;
            transition: var(--transition);
            opacity: 0;
            transform: translateY(20px);
            transition: opacity 0.5s ease 0.2s, transform 0.5s ease 0.2s, border-color 0.3s ease;
        }

        .upload-section.visible {
            opacity: 1;
            transform: translateY(0);
        }

        .upload-section:hover {
            border-color: var(--primary-color);
        }

        .upload-icon {
            font-size: 3rem;
            color: var(--primary-color);
            margin-bottom: 1.5rem;
        }

        .upload-section h2 {
            margin-bottom: 1rem;
            color: var(--text-dark);
        }

        .upload-section p {
            color: var(--text-light);
            margin-bottom: 1.5rem;
        }

        .file-input {
            display: none;
        }

        .file-label {
            display: inline-block;
            padding: 0.75rem 1.5rem;
            background-color: var(--primary-color);
            color: white;
            border-radius: var(--border-radius-sm);
            cursor: pointer;
            transition: var(--transition);
            font-weight: 500;
        }

        .file-label:hover {
            background-color: var(--primary-dark);
        }

        /* Selected file indicator */
        .file-selected {
            display: inline-block;
            margin-top: 1rem;
            padding: 0.5rem 1rem;
            background-color: #f0f5ff;
            border-radius: var(--border-radius-sm);
            color: var(--primary-color);
            font-weight: 500;
        }

        .file-selected i {
            margin-right: 0.5rem;
        }

        /* Compression Options */
        .options-section {
            background-color: white;
            border-radius: var(--border-radius-md);
            padding: 2rem;
            box-shadow: var(--shadow-sm);
            margin-bottom: 3rem;
            opacity: 0;
            transform: translateY(20px);
            transition: opacity 0.5s ease 0.4s, transform 0.5s ease 0.4s;
        }

        .options-section.visible {
            opacity: 1;
            transform: translateY(0);
        }

        .options-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .options-header h2 {
            font-size: 1.3rem;
            color: var(--text-dark);
        }

        .compression-levels {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .level-card {
            border: 1px solid #e5e7eb;
            border-radius: var(--border-radius-md);
            padding: 1.5rem;
            cursor: pointer;
            transition: var(--transition);
            position: relative;
        }

        .level-card:hover {
            border-color: var(--primary-color);
        }

        .level-card.selected {
            border-color: var(--primary-color);
            background-color: #eff6ff;
            box-shadow: 0 0 0 2px rgba(37, 99, 235, 0.2);
        }

        .level-card.selected::after {
            content: "\f00c";
            font-family: "Font Awesome 6 Free";
            font-weight: 900;
            position: absolute;
            top: -10px;
            right: -10px;
            width: 24px;
            height: 24px;
            background-color: var(--primary-color);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
        }

        .level-card h3 {
            margin-bottom: 0.5rem;
            color: var(--text-dark);
        }

        .level-card p {
            color: var(--text-light);
            font-size: 0.9rem;
        }

        .additional-options {
            margin-top: 2rem;
        }

        .option-checkbox {
            display: flex;
            align-items: center;
            margin-bottom: 1rem;
        }

        .option-checkbox input {
            margin-right: 0.75rem;
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin-bottom: 3rem;
            opacity: 0;
            transform: translateY(20px);
            transition: opacity 0.5s ease 0.6s, transform 0.5s ease 0.6s;
        }

        .action-buttons.visible {
            opacity: 1;
            transform: translateY(0);
        }

        .btn-large {
            padding: 0.75rem 2rem;
            font-size: 1.1rem;
        }

        .btn-secondary {
            background-color: white;
            color: var(--text-dark);
            border: 1px solid #d1d5db;
        }

        .btn-secondary:hover {
            background-color: #f9fafb;
        }

        /* How It Works */
        .how-it-works {
            background-color: #f8fafc;
            padding: 3rem 2rem;
            border-radius: var(--border-radius-md);
            margin-bottom: 3rem;
            opacity: 0;
            transform: translateY(20px);
            transition: opacity 0.5s ease 0.8s, transform 0.5s ease 0.8s;
        }

        .how-it-works.visible {
            opacity: 1;
            transform: translateY(0);
        }

        .how-it-works h2 {
            text-align: center;
            margin-bottom: 2rem;
            color: var(--text-dark);
        }

        .steps {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            max-width: 900px;
            margin: 0 auto;
        }

        .step {
            text-align: center;
            opacity: 0;
            transform: translateY(20px);
            transition: opacity 0.5s ease, transform 0.5s ease;
        }

        .step.visible {
            opacity: 1;
            transform: translateY(0);
        }

        .step:nth-child(1) { transition-delay: 0.8s; }
        .step:nth-child(2) { transition-delay: 1s; }
        .step:nth-child(3) { transition-delay: 1.2s; }

        .step-number {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            background-color: var(--primary-color);
            color: white;
            border-radius: 50%;
            font-weight: 600;
            margin-bottom: 1rem;
        }

        .step h3 {
            margin-bottom: 0.5rem;
            color: var(--text-dark);
        }

        .step p {
            color: var(--text-medium);
            font-size: 0.95rem;
        }

        /* FAQ Section */
        .faq-section {
            margin-bottom: 3rem;
            opacity: 0;
            transform: translateY(20px);
            transition: opacity 0.5s ease 1.4s, transform 0.5s ease 1.4s;
        }

        .faq-section.visible {
            opacity: 1;
            transform: translateY(0);
        }

        .faq-section h2 {
            text-align: center;
            margin-bottom: 2rem;
            color: var(--text-dark);
        }

        .faq-container {
            max-width: 800px;
            margin: 0 auto;
        }

        .faq-item {
            border-bottom: 1px solid #e5e7eb;
            padding: 1.5rem 0;
            opacity: 0;
            transform: translateY(20px);
            transition: opacity 0.5s ease, transform 0.5s ease;
        }

        .faq-item.visible {
            opacity: 1;
            transform: translateY(0);
        }

        .faq-item:nth-child(1) { transition-delay: 1.4s; }
        .faq-item:nth-child(2) { transition-delay: 1.6s; }
        .faq-item:nth-child(3) { transition-delay: 1.8s; }

        .faq-question {
            display: flex;
            justify-content: space-between;
            align-items: center;
            cursor: pointer;
        }

        .faq-question h3 {
            font-size: 1.1rem;
            color: var(--text-dark);
        }

        .faq-question i {
            color: var(--primary-color);
            transition: transform 0.3s ease;
        }

        .faq-question.active i {
            transform: rotate(180deg);
        }

        .faq-answer {
            color: var(--text-medium);
            padding-top: 1rem;
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.3s ease, padding-top 0.3s ease;
        }

        .faq-answer.show {
            max-height: 200px;
            padding-top: 1rem;
        }

        /* Footer */
        footer {
            background-color: #1f2937;
            color: white;
            padding: 4rem 2rem;
        }

        .footer-container {
            max-width: 1200px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 2.5rem;
            padding-bottom: 2rem;
            border-bottom: 1px solid #374151;
        }

        .footer-col h4 {
            margin-bottom: 1.5rem;
            font-size: 1.3rem;
            color: white;
            font-weight: 700;
        }

        .footer-col ul {
            list-style: none;
        }

        .footer-col li {
            margin-bottom: 0.8rem;
        }

        .footer-col a {
            color: #d1d5db;
            text-decoration: none;
            transition: var(--transition);
            font-size: 0.95rem;
        }

        .footer-col a:hover {
            color: white;
        }

        .social-links {
            display: flex;
            gap: 1rem;
            margin-top: 1rem;
        }

        .social-links a {
            color: white;
            font-size: 1.2rem;
        }

        .copyright {
            text-align: center;
            margin-top: 2rem;
            padding-top: 1rem;
            color: #9ca3af;
            font-size: 0.9rem;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                gap: 1rem;
                padding: 1rem;
            }

            .nav-links {
                flex-direction: column;
                align-items: center;
                gap: 0.5rem;
            }

            .compression-levels {
                grid-template-columns: 1fr;
            }

            .action-buttons {
                flex-direction: column;
            }

            .btn-large {
                width: 100%;
            }
        }

        /* Server-side message styling */
        .message {
            padding: 1rem;
            margin-bottom: 1.5rem;
            border-radius: var(--border-radius-sm);
            text-align: center;
            opacity: 0;
            transform: translateY(20px);
            transition: opacity 0.5s ease 0.1s, transform 0.5s ease 0.1s;
        }

        .message.visible {
            opacity: 1;
            transform: translateY(0);
        }

        .success {
            background-color: #d1fae5;
            color: #065f46;
            border: 1px solid #a7f3d0;
        }

        .error {
            background-color: #fee2e2;
            color: #b91c1c;
            border: 1px solid #fecaca;
        }

        /* Loading animation */
        .loader {
            display: none;
            width: 40px;
            height: 40px;
            margin: 20px auto;
            border: 4px solid #f3f3f3;
            border-top: 4px solid var(--primary-color);
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* Error message styling as requested */
        .error-message {
            padding: 1rem;
            margin: 1rem 0;
            background-color: #fee2e2;
            color: #b91c1c;
            border: 1px solid #fecaca;
            border-radius: 6px;
            text-align: center;
        }

        /* PDF Info Display */
        .pdf-info {
            background-color: #f8fafc;
            border-radius: var(--border-radius-md);
            padding: 1.5rem;
            margin: 1.5rem 0;
            box-shadow: var(--shadow-sm);
        }

        .pdf-info h3 {
            margin-bottom: 1rem;
            color: var(--text-dark);
            border-bottom: 1px solid #e5e7eb;
            padding-bottom: 0.5rem;
        }

        .pdf-info-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
        }

        .info-item {
            display: flex;
            flex-direction: column;
        }

        .info-label {
            font-size: 0.85rem;
            color: var(--text-light);
            margin-bottom: 0.25rem;
        }

        .info-value {
            font-weight: 500;
            color: var(--text-dark);
        }
    </style>
</head>
<body>
<!-- Header/Navigation -->
<header>
    <nav class="navbar">
        <a href="index.jsp" class="logo">
            <i class="fas fa-file-pdf"></i>
            <span>PDFlex</span>
        </a>

        <div class="nav-links">
            <a href="#tools">Tools</a>
            <a href="#features">Features</a>
            <a href="#pricing">Pricing</a>
            <a href="#about">About</a>
        </div>

        <div class="auth-buttons">
            <a href="login.jsp" class="btn btn-outline">Log In</a>
            <a href="signup.jsp" class="btn btn-primary">Sign Up</a>
        </div>
    </nav>
</header>

<!-- Main Content -->
<main class="main-content">
    <div class="tool-header">
        <h1>Compress PDF Files</h1>
        <p>Reduce the size of your PDF files without losing quality. Perfect for sharing, storing and uploading.</p>
    </div>

    <!-- Server-side messages -->
    <div class="message">
        <%
        // Display success message if present
        String successMessage = (String) request.getAttribute("successMessage");
        if (successMessage != null) {
        %>
        <div class="success"><%= successMessage %></div>
        <%
        }

        // Display error message if present
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (errorMessage != null) {
        %>
        <div class="error-message"><%= errorMessage %></div>
        <%
        }
        %>
    </div>

    <!-- PDF Information Display -->
    <%
    // Check if PDF info is available in request attributes
    String fileName = (String) request.getAttribute("fileName");
    String fileSize = (String) request.getAttribute("fileSize");
    String pageCount = (String) request.getAttribute("pageCount");

    if (fileName != null) {
    %>
    <div class="pdf-info">
        <h3>PDF Information</h3>
        <div class="pdf-info-details">
            <div class="info-item">
                <span class="info-label">File Name</span>
                <span class="info-value"><%= fileName %></span>
            </div>
            <div class="info-item">
                <span class="info-label">File Size</span>
                <span class="info-value"><%= fileSize != null ? fileSize : "N/A" %></span>
            </div>
            <div class="info-item">
                <span class="info-label">Page Count</span>
                <span class="info-value"><%= pageCount != null ? pageCount : "N/A" %></span>
            </div>
        </div>
    </div>
    <%
    }
    %>

    <!-- Upload Section - Form for Servlet processing -->
    <form id="compressForm" action="CompressPDFServlet" method="post" enctype="multipart/form-data">
        <section class="upload-section">
            <div class="upload-icon">
                <i class="fas fa-compress-alt"></i>
            </div>
            <h2>Select PDF file to compress</h2>
            <p>Choose a PDF file from your device</p>
            <input type="file" id="pdfFile" name="pdfFile" class="file-input" accept=".pdf" required
                   onchange="document.getElementById('fileNameDisplay').textContent = this.files[0].name;
                             document.getElementById('fileSelected').style.display = 'block';
                             extractPDFInfo(this.files[0]);">
            <label for="pdfFile" class="file-label btn-primary">Select PDF File</label>

            <!-- File selected indicator -->
            <div id="fileSelected" style="display: none;" class="file-selected">
                <i class="fas fa-check-circle"></i>
                <span id="fileNameDisplay"></span> selected
            </div>
        </section>

        <!-- Compression Options -->
        <section class="options-section">
            <div class="options-header">
                <h2>Compression Options</h2>
            </div>

            <div class="compression-levels">
                <label class="level-card">
                    <input type="radio" name="compressionLevel" value="basic" checked style="display: none;">
                    <h3>Basic Compression</h3>
                    <p>Good quality with moderate compression. Best for most documents.</p>
                </label>

                <label class="level-card">
                    <input type="radio" name="compressionLevel" value="strong" style="display: none;">
                    <h3>Strong Compression</h3>
                    <p>Smaller file size with noticeable quality reduction.</p>
                </label>

                <label class="level-card">
                    <input type="radio" name="compressionLevel" value="extreme" style="display: none;">
                    <h3>Extreme Compression</h3>
                    <p>Maximum compression with significant quality reduction.</p>
                </label>
            </div>

            <div class="additional-options">
                <h3>Additional Options</h3>
                <div class="option-checkbox">
                    <input type="checkbox" id="optimizeImages" name="optimizeImages" checked>
                    <label for="optimizeImages">Optimize images (recommended)</label>
                </div>
                <div class="option-checkbox">
                    <input type="checkbox" id="removeMetadata" name="removeMetadata">
                    <label for="removeMetadata">Remove metadata (author, title, etc.)</label>
                </div>
                <div class="option-checkbox">
                    <input type="checkbox" id="downsampleImages" name="downsampleImages">
                    <label for="downsampleImages">Downsample images to 150 DPI</label>
                </div>
            </div>
        </section>

        <!-- Loading indicator -->
        <div id="loader" class="loader"></div>

        <!-- Action Buttons -->
        <div class="action-buttons">
            <button type="button" id="cancelBtn" class="btn btn-secondary btn-large">Cancel</button>
            <button type="submit" class="btn btn-primary btn-large">Compress PDF</button>
        </div>
    </form>

    <!-- How It Works -->
    <section class="how-it-works">
        <h2>How to Compress PDF Files</h2>
        <div class="steps">
            <div class="step">
                <div class="step-number">1</div>
                <h3>Upload PDF File</h3>
                <p>Select your PDF file from your device</p>
            </div>
            <div class="step">
                <div class="step-number">2</div>
                <h3>Choose Compression</h3>
                <p>Select your preferred compression level and options</p>
            </div>
            <div class="step">
                <div class="step-number">3</div>
                <h3>Download Result</h3>
                <p>Download your compressed PDF file</p>
            </div>
        </div>
    </section>

    <!-- FAQ Section -->
    <section class="faq-section">
        <h2>Frequently Asked Questions</h2>
        <div class="faq-container">
            <div class="faq-item">
                <div class="faq-question">
                    <h3>Is PDF compression safe?</h3>
                    <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    <p>Yes, our PDF compression is completely safe. Files are processed securely on our servers.</p>
                </div>
            </div>

            <div class="faq-item">
                <div class="faq-question">
                    <h3>Will compression reduce PDF quality?</h3>
                    <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    <p>Basic compression maintains good quality while reducing file size. Stronger compression levels may reduce quality, especially for images.</p>
                </div>
            </div>

            <div class="faq-item">
                <div class="faq-question">
                    <h3>What's the maximum file size I can compress?</h3>
                    <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    <p>You can compress PDF files up to 50MB for free. Registered users can compress files up to 200MB.</p>
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
                <li><a href="merge.jsp">Merge PDF</a></li>
                <li><a href="split.jsp">Split PDF</a></li>
                <li><a href="edit.jsp">PDF Editor</a></li>
                <li><a href="convert.jsp">PDF Converter</a></li>
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
    // Scroll animation for elements
    document.addEventListener('DOMContentLoaded', function() {
        // Initialize elements with visible class if they're in viewport
        checkVisibility();

        // Add scroll event listener
        window.addEventListener('scroll', checkVisibility);

        // Compression level selection
        const levelCards = document.querySelectorAll('.level-card');
        levelCards.forEach(card => {
            card.addEventListener('click', function() {
                // Remove selected class from all cards
                levelCards.forEach(c => c.classList.remove('selected'));

                // Add selected class to clicked card
                this.classList.add('selected');

                // Check the radio input inside this card
                const radioInput = this.querySelector('input[type="radio"]');
                if (radioInput) {
                    radioInput.checked = true;
                }
            });
        });

        // Set the first level card as selected by default
        if (levelCards.length > 0) {
            levelCards[0].classList.add('selected');
        }

        // Cancel button functionality
        const cancelBtn = document.getElementById('cancelBtn');
        if (cancelBtn) {
            cancelBtn.addEventListener('click', function() {
                // Reset the form
                document.getElementById('compressForm').reset();

                // Hide the file selected indicator
                document.getElementById('fileSelected').style.display = 'none';

                // Reset the file input
                document.getElementById('pdfFile').value = '';

                // Reset the compression level selection
                levelCards.forEach(c => c.classList.remove('selected'));
                if (levelCards.length > 0) {
                    levelCards[0].classList.add('selected');
                    levelCards[0].querySelector('input[type="radio"]').checked = true;
                }
            });
        }

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

        // Form submission loading indicator
        const compressForm = document.getElementById('compressForm');
        if (compressForm) {
            compressForm.addEventListener('submit', function() {
                document.getElementById('loader').style.display = 'block';
            });
        }
    });

    // Function to check if elements are in viewport and add visible class
    function checkVisibility() {
        const elements = document.querySelectorAll('.tool-header, .upload-section, .options-section, .action-buttons, .how-it-works, .faq-section, .faq-item, .step');

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

    // Function to extract PDF info (simplified version)
    function extractPDFInfo(file) {
        // In a real implementation, you would use a PDF.js or similar library
        // to extract actual PDF metadata like page count
        console.log("File selected:", file.name, "Size:", formatFileSize(file.size));

        // This is a simplified implementation that just shows basic file info
        // A real implementation would need server-side processing or a client-side PDF library
    }

    // Helper function to format file size
    function formatFileSize(bytes) {
        if (bytes === 0) return '0 Bytes';
        const k = 1024;
        const sizes = ['Bytes', 'KB', 'MB', 'GB'];
        const i = Math.floor(Math.log(bytes) / Math.log(k));
        return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
    }
</script>
</body>
</html>