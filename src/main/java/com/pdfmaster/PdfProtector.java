package com.pdfmaster;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.encryption.AccessPermission;
import org.apache.pdfbox.pdmodel.encryption.StandardProtectionPolicy;

import java.io.IOException;
import java.io.InputStream;

@WebServlet("/fileProtector")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10,      // 10 MB
        maxRequestSize = 1024 * 1024 * 100   // 100 MB
)
public class PdfProtector extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        Part filePart = req.getPart("pdfFile");
        long size = filePart.getSize();
        String readAble;
        double sizeMB = (double) size / (1024 * 1024);

        if (size < 1024)
        {
            readAble = size + "Bytes";
        } else if (size < 1024 * 1024) {
           double sizeKB = (double) size / 1024;
           // readAble = String.format("%.2f KB",sizeKB);
        } else if (size < 1024 * 1024 * 1024) {
            //sizeMB = (double) size / (1024 * 1024);
            //readAble = String.format("%.2f MB",sizeMB);
        }else {
            double sizeGB = (double) size / (1024 * 1024 * 1024);
            //readAble = String.format("%.2f GB", sizeGB);
        }

        if(sizeMB > 50)
        {
            req.setAttribute("error","File Size is " + sizeMB + " Upload under 50MB in Free Tier.");
            RequestDispatcher requestDispatcher = req.getRequestDispatcher("pdflex-protectpdf.jsp");
            requestDispatcher.forward(req,resp);
        }

        String ownerPassword = req.getParameter("ownerPassword");
        String userPassword = req.getParameter("userPassword");

        try {
            InputStream inputStream = filePart.getInputStream();
            PDDocument pdDocument = PDDocument.load(inputStream);

            boolean allowPrinting = req.getParameter("allowPrinting") != null;
            boolean allowModifyContents = req.getParameter("allowModifyContents") != null;
            boolean allowCopy = req.getParameter("allowCopy") != null;
            boolean allowModifyAnnotations = req.getParameter("allowModifyAnnotations") != null;
            boolean allowFillInForms = req.getParameter("allowFillInForms") != null;
            boolean allowScreenReaders = req.getParameter("allowScreenReaders") != null;
            boolean allowAssembly = req.getParameter("allowAssembly") != null;
            AccessPermission accessPermission = new AccessPermission();
            accessPermission.setCanAssembleDocument(allowAssembly);
            accessPermission.setCanModify(allowModifyContents);
            accessPermission.setCanPrint(allowPrinting);
            accessPermission.setCanExtractContent(allowCopy);
            accessPermission.setCanFillInForm(allowFillInForms);
            accessPermission.setCanExtractForAccessibility(allowScreenReaders);
            accessPermission.setCanModifyAnnotations(allowModifyAnnotations);
            accessPermission.setReadOnly();

            StandardProtectionPolicy standardProtectionPolicy = new StandardProtectionPolicy(ownerPassword,userPassword,accessPermission);
            standardProtectionPolicy.setPermissions(accessPermission);
            standardProtectionPolicy.setEncryptionKeyLength(256);
            pdDocument.protect(standardProtectionPolicy);

        } catch (Exception e) {
            
        }

    }
}