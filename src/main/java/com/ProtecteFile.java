package com;

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
import java.io.OutputStream;
import java.lang.reflect.AccessibleObject;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 20 * 1024 * 1024,
        maxRequestSize = 40 * 1024 * 1024
)
@WebServlet("/protectPdf")
public class ProtecteFile extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // get file
        Part normalFile = req.getPart("pdfFile");
        String fileName = normalFile.getSubmittedFileName();

        // get user and owner password
        String ownerPassword = req.getParameter("ownerPassword");
        String confirmOwnerPassword = req.getParameter("confirmOwnerPassword");
        String userPassword = req.getParameter("userPassword");
        String confirmUserPassword = req.getParameter("confirmUserPassword");

        // check owner password
        if(!ownerPassword.equals(confirmOwnerPassword))
        {
            req.setAttribute("error","Owner Password not Match Confirmation.");
            req.getRequestDispatcher("pdflex-protectpdf.jsp").forward(req,resp);
            return;
        }

        // check user password
        if(!userPassword.equals(confirmUserPassword))
        {
            req.setAttribute("error","User Password not Match Confirmation.");
            req.getRequestDispatcher("pdflex-protectpdf.jsp").forward(req,resp);
            return;
        }

        try(InputStream inputStream = normalFile.getInputStream();
            PDDocument pdDocument = PDDocument.load(inputStream))
        {
            // configure permission
            AccessPermission permission = new AccessPermission();

            permission.setCanPrint(req.getParameter("allowPrinting") != null);
            permission.setCanModify(req.getParameter("allowModifyContents") != null);
            permission.setCanExtractContent(req.getParameter("allowCopy") != null);
            permission.setCanModifyAnnotations(req.getParameter("allowModifyAnnotations") != null);
            permission.setCanFillInForm(req.getParameter("allowFillInForms") != null);
            permission.setCanExtractForAccessibility(req.getParameter("allowScreenReaders") != null);
            permission.setCanAssembleDocument(req.getParameter("allowAssembly") != null);

            // set permissions

            StandardProtectionPolicy protectionPolicy = new StandardProtectionPolicy(ownerPassword,userPassword,permission);
            protectionPolicy.setEncryptionKeyLength(256);
            protectionPolicy.setPermissions(permission);

            pdDocument.protect(protectionPolicy);

            try(OutputStream outputStream = resp.getOutputStream())
            {
                pdDocument.save(outputStream);
            }catch (Exception e)
            {
                req.setAttribute("error", e.getMessage());
                req.getRequestDispatcher("pdflex-protectpdf.jsp").forward(req,resp);
                return;
            }

        }


    }
}
