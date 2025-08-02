
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Merge PDF - Combine PDF Files | PDFlex</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
      <link rel="stylesheet" href="css/MergePDF.css">
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
        <h1>Merge PDF Files</h1>
        <p>Combine multiple PDF files into one document in the order you want. Fast and easy merging.</p>
    </div>

    <!-- Message display area -->
    <% if (request.getAttribute("message") != null) { %>
        <div class="message <%= request.getAttribute("messageType") %> visible">
            <%= request.getAttribute("message") %>
        </div>
    <% } %>

    <!-- Upload Section - Form for Servlet processing -->
    <form id="mergeForm" action="MergePDFServlet" method="post" enctype="multipart/form-data">
        <section class="upload-section">
            <div class="upload-icon">
                <i class="fas fa-file-pdf"></i>
            </div>
            <h2>Select PDF files to merge</h2>
            <p>Choose multiple PDF files from your device</p>
            <input type="file" id="pdfFiles" name="pdfFiles" class="file-input" accept=".pdf" multiple required
                   onchange="updateSelectedFiles(this.files)">
            <label for="pdfFiles" class="file-label btn-primary">Select PDF Files</label>

            <!-- Selected files counter -->
            <div id="fileCounter" style="margin-top: 1rem; font-weight: 500; display: none;">
                Selected files: <span id="count">0</span>
            </div>

            <!-- Selected files list -->
            <div id="selectedFiles" class="selected-files">
                <!-- Files will be added here dynamically -->
            </div>
        </section>

        <!-- Merge Options -->
        <section class="options-section">
            <div class="options-header">
                <h2>Merge Options</h2>
            </div>

            <div class="additional-options">
                <h3>Output Options</h3>
                <div class="option-checkbox">
                    <input type="checkbox" id="removeBlankPages" name="removeBlankPages">
                    <label for="removeBlankPages">Remove blank pages</label>
                </div>
                <div class="option-checkbox">
                    <input type="checkbox" id="optimizeOutput" name="optimizeOutput" checked>
                    <label for="optimizeOutput">Optimize output file (recommended)</label>
                </div>
                <div class="option-checkbox">
                    <input type="checkbox" id="addPageNumbers" name="addPageNumbers">
                    <label for="addPageNumbers">Add page numbers to footer</label>
                </div>
            </div>
        </section>

        <!-- Loading indicator -->
        <div id="loader" class="loader"></div>

        <!-- Action Buttons -->
        <div class="action-buttons">
            <button type="button" id="cancelBtn" class="btn btn-secondary btn-large">Cancel</button>
            <button type="submit" class="btn btn-primary btn-large">Merge PDFs</button>
        </div>
    </form>

    <!-- How It Works -->
    <section class="how-it-works">
        <h2>How to Merge PDF Files</h2>
        <div class="steps">
            <div class="step">
                <div class="step-number">1</div>
                <h3>Upload PDF Files</h3>
                <p>Select multiple PDF files from your device</p>
            </div>
            <div class="step">
                <div class="step-number">2</div>
                <h3>Arrange & Options</h3>
                <p>Reorder files and set merge options</p>
            </div>
            <div class="step">
                <div class="step-number">3</div>
                <h3>Download Result</h3>
                <p>Download your merged PDF file</p>
            </div>
        </div>
    </section>

    <!-- FAQ Section -->
    <section class="faq-section">
        <h2>Frequently Asked Questions</h2>
        <div class="faq-container">
            <div class="faq-item">
                <div class="faq-question">
                    <h3>Is there a limit to how many PDFs I can merge?</h3>
                    <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    <p>You can merge up to 20 PDF files at once. The total size of all files combined should not exceed 50MB for free users or 200MB for registered users.</p>
                </div>
            </div>

            <div class="faq-item">
                <div class="faq-question">
                    <h3>Can I rearrange the order of pages?</h3>
                    <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    <p>Yes, you can reorder the files before merging. The pages will appear in the merged PDF in the order you specify.</p>
                </div>
            </div>

            <div class="faq-item">
                <div class="faq-question">
                    <h3>Will the quality of my PDFs be affected?</h3>
                    <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    <p>No, the merge process preserves the original quality of your PDFs. If you enable optimization, some images might be compressed to reduce file size.</p>
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
                <li><a href="compress.jsp">Compress PDF</a></li>
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

        // Cancel button functionality
        const cancelBtn = document.getElementById('cancelBtn');
        if (cancelBtn) {
            cancelBtn.addEventListener('click', function() {
                // Reset the form
                document.getElementById('mergeForm').reset();

                // Clear the selected files list
                document.getElementById('selectedFiles').innerHTML = '';
                document.getElementById('selectedFiles').classList.remove('visible');

                // Hide the file counter
                document.getElementById('fileCounter').style.display = 'none';
                document.getElementById('count').textContent = '0';

                // Reset the file input
                document.getElementById('pdfFiles').value = '';
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
        const mergeForm = document.getElementById('mergeForm');
        if (mergeForm) {
            mergeForm.addEventListener('submit', function() {
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

    // Function to update the selected files list and counter
    function updateSelectedFiles(files) {
        const selectedFilesContainer = document.getElementById('selectedFiles');
        const fileCounter = document.getElementById('fileCounter');
        const countSpan = document.getElementById('count');

        selectedFilesContainer.innerHTML = '';
        countSpan.textContent = files.length;

        if (files.length > 0) {
            selectedFilesContainer.classList.add('visible');
            fileCounter.style.display = 'block';

            for (let i = 0; i < files.length; i++) {
                const file = files[i];
                const fileItem = document.createElement('div');
                fileItem.className = 'file-item';

                // Format file size
                const fileSize = formatFileSize(file.size);

                fileItem.innerHTML = `
                    <div class="file-info">
                        <i class="fas fa-file-pdf file-icon"></i>
                        <div>
                            <div class="file-name">${file.name}</div>
                            <div class="file-size">${fileSize}</div>
                        </div>
                    </div>
                    <div class="file-order-controls">
                        ${i > 0 ? '<button class="order-btn move-up" data-index="${i}"><i class="fas fa-arrow-up"></i></button>' : ''}
                        ${i < files.length - 1 ? '<button class="order-btn move-down" data-index="${i}"><i class="fas fa-arrow-down"></i></button>' : ''}
                    </div>
                    <i class="fas fa-times file-remove" data-index="${i}"></i>
                `;

                selectedFilesContainer.appendChild(fileItem);
            }

            // Add event listeners for remove buttons
            document.querySelectorAll('.file-remove').forEach(btn => {
                btn.addEventListener('click', function() {
                    const index = parseInt(this.getAttribute('data-index'));
                    removeFile(index);
                });
            });

            // Add event listeners for move up buttons
            document.querySelectorAll('.move-up').forEach(btn => {
                btn.addEventListener('click', function() {
                    const index = parseInt(this.getAttribute('data-index'));
                    moveFileUp(index);
                });
            });

            // Add event listeners for move down buttons
            document.querySelectorAll('.move-down').forEach(btn => {
                btn.addEventListener('click', function() {
                    const index = parseInt(this.getAttribute('data-index'));
                    moveFileDown(index);
                });
            });
        } else {
            selectedFilesContainer.classList.remove('visible');
            fileCounter.style.display = 'none';
        }
    }

    // Function to format file size
    function formatFileSize(bytes) {
        if (bytes === 0) return '0 Bytes';
        const k = 1024;
        const sizes = ['Bytes', 'KB', 'MB', 'GB'];
        const i = Math.floor(Math.log(bytes) / Math.log(k));
        return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
    }

    // Function to remove a file from the list
    function removeFile(index) {
        const fileInput = document.getElementById('pdfFiles');
        const files = Array.from(fileInput.files);
        files.splice(index, 1);

        // Create a new DataTransfer object to update the files
        const dataTransfer = new DataTransfer();
        files.forEach(file => dataTransfer.items.add(file));
        fileInput.files = dataTransfer.files;

        // Update the UI
        updateSelectedFiles(fileInput.files);
    }

    // Function to move a file up in the order
    function moveFileUp(index) {
        const fileInput = document.getElementById('pdfFiles');
        const files = Array.from(fileInput.files);

        if (index > 0) {
            // Swap with previous file
            [files[index], files[index - 1]] = [files[index - 1], files[index]];

            // Create a new DataTransfer object to update the files
            const dataTransfer = new DataTransfer();
            files.forEach(file => dataTransfer.items.add(file));
            fileInput.files = dataTransfer.files;

            // Update the UI
            updateSelectedFiles(fileInput.files);
        }
    }

    // Function to move a file down in the order
    function moveFileDown(index) {
        const fileInput = document.getElementById('pdfFiles');
        const files = Array.from(fileInput.files);

        if (index < files.length - 1) {
            // Swap with next file
            [files[index], files[index + 1]] = [files[index + 1], files[index]];

            // Create a new DataTransfer object to update the files
            const dataTransfer = new DataTransfer();
            files.forEach(file => dataTransfer.items.add(file));
            fileInput.files = dataTransfer.files;

            // Update the UI
            updateSelectedFiles(fileInput.files);
        }
    }
</script>
</body>
</html>