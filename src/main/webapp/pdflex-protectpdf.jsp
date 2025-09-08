<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Protect PDF - Add Password Security | PDFlex</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/pdf-protect.css">
</head>
<body>
<header>
    <nav class="navbar">
        <a href="index.html" class="logo">
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
            <a href="login.html" class="btn btn-outline">Log In</a>
            <a href="signup.html" class="btn btn-primary">Sign Up</a>
        </div>
    </nav>
</header>

<main class="main-content">
    <div class="tool-header">
        <h1>Protect PDF Files</h1>
        <p>Add password protection to your PDF files to control access and prevent unauthorized changes.</p>
    </div>

    <% if (request.getAttribute("error") != null) { %>
        <div class="error-message">
            <i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("error") %>
        </div>
    <% } %>

    <% if (request.getAttribute("success") != null) { %>
        <div class="success-message">
            <i class="fas fa-check-circle"></i> <%= request.getAttribute("success") %>
        </div>
    <% } %>

    <form id="protectForm" action="protectPdf" method="post" enctype="multipart/form-data">
        <section class="upload-section">
            <div class="upload-icon">
                <i class="fas fa-lock"></i>
            </div>
            <h2>Select PDF file to protect</h2>
            <p>Choose a PDF file from your device</p>
            <input type="file" id="pdfFile" name="pdfFile" class="file-input" accept=".pdf" required>
            <label for="pdfFile" class="file-label btn-primary">Select PDF File</label>

            <div id="fileSelected" style="display: none;" class="file-selected">
                <i class="fas fa-check-circle"></i>
                <span id="fileNameDisplay"></span> selected
            </div>
        </section>

        <section class="options-section">
            <div class="options-header">
                <h2>Protection Options</h2>
            </div>

            <div class="protection-options">
                <div class="protection-card">
                    <h3>Password Protection</h3>

                    <div class="form-group">
                        <label for="ownerPassword">Owner Password (Required)*</label>
                        <div class="password-input-container">
                            <input type="password" id="ownerPassword" name="ownerPassword" class="form-control"
                                   placeholder="Enter password to control permissions" required>
                            <i class="fas fa-eye toggle-password" data-target="ownerPassword"></i>
                        </div>
                        <p class="password-hint">
                            <i class="fas fa-info-circle"></i> This password controls permissions and security settings.
                        </p>
                    </div>

                    <div class="form-group">
                        <label for="confirmOwnerPassword">Confirm Owner Password*</label>
                        <div class="password-input-container">
                            <input type="password" id="confirmOwnerPassword" name="confirmOwnerPassword" class="form-control"
                                   placeholder="Re-enter password" required>
                            <i class="fas fa-eye toggle-password" data-target="confirmOwnerPassword"></i>
                        </div>
                        <div class="password-match" id="ownerPasswordMatch">
                            <i class="fas fa-check-circle"></i>
                            <span>Passwords must match</span>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="userPassword">User Password (Optional)</label>
                        <div class="password-input-container">
                            <input type="password" id="userPassword" name="userPassword" class="form-control"
                                   placeholder="Enter password to open the PDF">
                            <i class="fas fa-eye toggle-password" data-target="userPassword"></i>
                        </div>
                        <p class="password-hint">
                            <i class="fas fa-info-circle"></i> If set, users will need this password to open the PDF.
                        </p>
                    </div>

                    <div class="form-group">
                        <label for="confirmUserPassword">Confirm User Password</label>
                        <div class="password-input-container">
                            <input type="password" id="confirmUserPassword" name="confirmUserPassword" class="form-control"
                                   placeholder="Re-enter password">
                            <i class="fas fa-eye toggle-password" data-target="confirmUserPassword"></i>
                        </div>
                        <div class="password-match" id="userPasswordMatch">
                            <i class="fas fa-check-circle"></i>
                            <span>Passwords must match</span>
                        </div>
                    </div>
                </div>

                <div class="permissions-options">
                    <h3>Permissions</h3>
                    <p>Choose what users can do with your PDF after opening it:</p>

                    <div class="permissions-grid">
                        <div class="option-checkbox">
                            <input type="checkbox" id="allowPrinting" name="allowPrinting" checked>
                            <label for="allowPrinting">Allow printing</label>
                        </div>

                        <div class="option-checkbox">
                            <input type="checkbox" id="allowModifyContents" name="allowModifyContents">
                            <label for="allowModifyContents">Allow content modification</label>
                        </div>

                        <div class="option-checkbox">
                            <input type="checkbox" id="allowCopy" name="allowCopy" checked>
                            <label for="allowCopy">Allow copying text and images</label>
                        </div>

                        <div class="option-checkbox">
                            <input type="checkbox" id="allowModifyAnnotations" name="allowModifyAnnotations">
                            <label for="allowModifyAnnotations">Allow annotation modification</label>
                        </div>

                        <div class="option-checkbox">
                            <input type="checkbox" id="allowFillInForms" name="allowFillInForms">
                            <label for="allowFillInForms">Allow form filling</label>
                        </div>

                        <div class="option-checkbox">
                            <input type="checkbox" id="allowScreenReaders" name="allowScreenReaders" checked>
                            <label for="allowScreenReaders">Allow screen readers</label>
                        </div>

                        <div class="option-checkbox">
                            <input type="checkbox" id="allowAssembly" name="allowAssembly">
                            <label for="allowAssembly">Allow document assembly</label>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <div class="action-buttons">
            <button type="button" id="cancelBtn" class="btn btn-secondary btn-large">Cancel</button>
            <button type="submit" id="submitBtn" class="btn btn-primary btn-large">Protect PDF</button>
        </div>
    </form>

    <section class="how-it-works">
        <h2>How to Protect PDF Files</h2>
        <div class="steps">
            <div class="step">
                <div class="step-number">1</div>
                <h3>Upload PDF File</h3>
                <p>Select your PDF file from your device</p>
            </div>
            <div class="step">
                <div class="step-number">2</div>
                <h3>Set Password & Permissions</h3>
                <p>Create passwords and choose access permissions</p>
            </div>
            <div class="step">
                <div class="step-number">3</div>
                <h3>Download Protected PDF</h3>
                <p>Download your password-protected PDF file</p>
            </div>
        </div>
    </section>

    <section class="faq-section">
        <h2>Frequently Asked Questions</h2>
        <div class="faq-container">
            <div class="faq-item">
                <div class="faq-question">
                    <h3>What's the difference between user and owner passwords?</h3>
                    <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    <p>The user password is required to open the PDF document. The owner password controls permissions and is required to change security settings. If you set both, you'll need the user password to open the file and the owner password to modify permissions.</p>
                </div>
            </div>

            <div class="faq-item">
                <div class="faq-question">
                    <h3>Is PDF password protection secure?</h3>
                    <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    <p>Yes, our PDF protection uses strong 256-bit AES encryption, which is the same standard used by banks and governments to secure sensitive data.</p>
                </div>
            </div>

            <div class="faq-item">
                <div class="faq-question">
                    <h3>What if I forget the password?</h3>
                    <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    <p>We don't store your passwords, so we cannot recover them if you forget. Make sure to keep your password in a safe place. For important documents, consider using a password manager.</p>
                </div>
            </div>
        </div>
    </section>
</main>

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
    document.addEventListener('DOMContentLoaded', function() {
        // File selection display
        document.getElementById('pdfFile').addEventListener('change', function() {
            if (this.files && this.files[0]) {
                document.getElementById('fileNameDisplay').textContent = this.files[0].name;
                document.getElementById('fileSelected').style.display = 'block';
            }
        });

        // Cancel button functionality
        document.getElementById('cancelBtn').addEventListener('click', function() {
            document.getElementById('protectForm').reset();
            document.getElementById('fileSelected').style.display = 'none';
            document.getElementById('pdfFile').value = '';

            // Reset password match indicators
            document.querySelectorAll('.password-match').forEach(el => {
                el.innerHTML = '<i class="fas fa-check-circle"></i><span>Passwords must match</span>';
                el.className = 'password-match';
            });
        });

        // FAQ toggle functionality
        document.querySelectorAll('.faq-question').forEach(question => {
            question.addEventListener('click', function() {
                const answer = this.nextElementSibling;
                const isActive = this.classList.contains('active');

                // Close all other FAQ items
                document.querySelectorAll('.faq-question').forEach(q => {
                    if (q !== this) {
                        q.classList.remove('active');
                        q.nextElementSibling.classList.remove('show');
                    }
                });

                // Toggle current item
                this.classList.toggle('active');
                answer.classList.toggle('show');
            });
        });

        // Password match checker
        function checkPasswordMatch(password, confirmPassword, matchElement) {
            if (password.length === 0 || confirmPassword.length === 0) {
                matchElement.innerHTML = '<i class="fas fa-check-circle"></i><span>Passwords must match</span>';
                matchElement.className = 'password-match';
                return;
            }

            if (password === confirmPassword) {
                matchElement.innerHTML = '<i class="fas fa-check-circle"></i><span>Passwords match</span>';
                matchElement.className = 'password-match match';
            } else {
                matchElement.innerHTML = '<i class="fas fa-times-circle"></i><span>Passwords do not match</span>';
                matchElement.className = 'password-match no-match';
            }
        }

        // Toggle password visibility
        document.querySelectorAll('.toggle-password').forEach(icon => {
            icon.addEventListener('click', function() {
                const targetId = this.getAttribute('data-target');
                const input = document.getElementById(targetId);
                const type = input.getAttribute('type') === 'password' ? 'text' : 'password';
                input.setAttribute('type', type);
                this.classList.toggle('fa-eye');
                this.classList.toggle('fa-eye-slash');
            });
        });

        // Real-time validation
        document.getElementById('ownerPassword').addEventListener('input', function() {
            const confirmPassword = document.getElementById('confirmOwnerPassword').value;
            const matchElement = document.getElementById('ownerPasswordMatch');
            checkPasswordMatch(this.value, confirmPassword, matchElement);
        });

        document.getElementById('confirmOwnerPassword').addEventListener('input', function() {
            const password = document.getElementById('ownerPassword').value;
            const matchElement = document.getElementById('ownerPasswordMatch');
            checkPasswordMatch(password, this.value, matchElement);
        });

        document.getElementById('userPassword').addEventListener('input', function() {
            const confirmPassword = document.getElementById('confirmUserPassword').value;
            const matchElement = document.getElementById('userPasswordMatch');
            checkPasswordMatch(this.value, confirmPassword, matchElement);
        });

        document.getElementById('confirmUserPassword').addEventListener('input', function() {
            const password = document.getElementById('userPassword').value;
            const matchElement = document.getElementById('userPasswordMatch');
            checkPasswordMatch(password, this.value, matchElement);
        });

        // Close loading overlay
        document.getElementById('closeOverlay').addEventListener('click', function() {
            document.getElementById('loadingOverlay').classList.remove('active');
        });

        // Form validation on submit
        document.getElementById('protectForm').addEventListener('submit', function(e) {
            const ownerPassword = document.getElementById('ownerPassword').value;
            const confirmOwnerPassword = document.getElementById('confirmOwnerPassword').value;
            const userPassword = document.getElementById('userPassword').value;
            const confirmUserPassword = document.getElementById('confirmUserPassword').value;

            // Validate owner passwords match
            if (ownerPassword !== confirmOwnerPassword) {
                e.preventDefault();
                document.getElementById('ownerPasswordMatch').innerHTML =
                    '<i class="fas fa-times-circle"></i><span>Passwords do not match</span>';
                document.getElementById('ownerPasswordMatch').className = 'password-match no-match';
                document.getElementById('ownerPassword').focus();
                return;
            }

            // Validate user passwords if provided
            if (userPassword && userPassword !== confirmUserPassword) {
                e.preventDefault();
                document.getElementById('userPasswordMatch').innerHTML =
                    '<i class="fas fa-times-circle"></i><span>Passwords do not match</span>';
                document.getElementById('userPasswordMatch').className = 'password-match no-match';
                document.getElementById('userPassword').focus();
                return;
            }

            // Show loading overlay with animation
            const loadingOverlay = document.getElementById('loadingOverlay');
            const loadingSpinner = document.getElementById('loadingSpinner');
            const successIcon = document.getElementById('successIcon');
            const loadingText = document.getElementById('loadingText');
            const progressBar = document.getElementById('progressBar');
            const progressPercentage = document.getElementById('progressPercentage');
            const progressStatus = document.getElementById('progressStatus');
            const downloadContainer = document.getElementById('downloadContainer');
            const processingSteps = document.getElementById('processingSteps');
            const step1 = document.getElementById('step1');
            const step2 = document.getElementById('step2');
            const step3 = document.getElementById('step3');
            const step4 = document.getElementById('step4');

            loadingOverlay.classList.add('active');

            // Reset all steps
            [step1, step2, step3, step4].forEach(step => {
                step.className = 'processing-step';
            });

            // Simulate processing steps (in a real app, you'd update this based on actual progress)
            let progress = 0;
            const progressInterval = setInterval(() => {
                progress += 1;
                progressBar.style.width = `${progress}%`;
                progressPercentage.textContent = `${progress}%`;

                // Update progress status and active step
                if (progress < 25) {
                    progressStatus.textContent = 'Uploading file...';
                    step1.classList.add('active');
                } else if (progress < 50) {
                    progressStatus.textContent = 'Applying password protection...';
                    step1.classList.add('completed');
                    step1.classList.remove('active');
                    step2.classList.add('active');
                } else if (progress < 75) {
                    progressStatus.textContent = 'Applying security settings...';
                    step2.classList.add('completed');
                    step2.classList.remove('active');
                    step3.classList.add('active');
                } else if (progress < 100) {
                    progressStatus.textContent = 'Generating protected PDF...';
                    step3.classList.add('completed');
                    step3.classList.remove('active');
                    step4.classList.add('active');
                }

                if (progress >= 100) {
                    clearInterval(progressInterval);
                    progressStatus.textContent = 'Processing complete!';
                    step4.classList.add('completed');
                    step4.classList.remove('active');

                    // Show success state
                    setTimeout(() => {
                        loadingSpinner.style.display = 'none';
                        successIcon.style.display = 'block';
                        loadingText.textContent = 'PDF Successfully Protected!';
                        progressBar.style.backgroundColor = '#10b981';
                        downloadContainer.style.display = 'block';
                    }, 500);
                }
            }, 50);
        });

        // check message
        <% if (request.getAttribute("success") != null) { %>
            showSuccessState();
        <% } %>

        // Function to show success state immediately
        function showSuccessState() {
            const loadingOverlay = document.getElementById('loadingOverlay');
            const loadingSpinner = document.getElementById('loadingSpinner');
            const successIcon = document.getElementById('successIcon');
            const loadingText = document.getElementById('loadingText');
            const progressBar = document.getElementById('progressBar');
            const progressPercentage = document.getElementById('progressPercentage');
            const progressStatus = document.getElementById('progressStatus');
            const downloadContainer = document.getElementById('downloadContainer');
            const processingSteps = document.getElementById('processingSteps');
            const step1 = document.getElementById('step1');
            const step2 = document.getElementById('step2');
            const step3 = document.getElementById('step3');
            const step4 = document.getElementById('step4');

            // Mark all steps as completed
            [step1, step2, step3, step4].forEach(step => {
                step.classList.add('completed');
            });

            // Show success state immediately without animation
            loadingOverlay.classList.add('active');
            loadingSpinner.style.display = 'none';
            successIcon.style.display = 'block';
            progressBar.style.width = '100%';
            progressBar.style.backgroundColor = '#10b981';
            progressPercentage.textContent = '100%';
            progressStatus.textContent = 'Processing complete!';
            loadingText.textContent = 'PDF Successfully Protected!';
            downloadContainer.style.display = 'block';

            // Set download link
            document.getElementById('downloadLink').href = 'download';
        }
    });
</script>
</body>
</html>