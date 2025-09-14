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

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;


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

        // make unique file name
        String baseFileName = fileName.substring(0,fileName.lastIndexOf("."));
        String timeStamp = new SimpleDateFormat("yyyyMMddHHss").format(new Date());
        String uniqueName = baseFileName + "_" + timeStamp + ".pdf";

        // create folder for save protected files
        String uploadPath = "C:\\Users\\Admin\\IdeaProject\\PDFMaster\\protectedFiles";
        File uploadFolder = new File(uploadPath);
        if(!uploadFolder.exists()) uploadFolder.mkdir();



        try(InputStream inputStream = normalFile.getInputStream();
            PDDocument pdDocument = PDDocument.load(inputStream))
        {

            // find file size
            long fileSize = normalFile.getSize();

            // Store in Human Readable Format
            String readAble;
            if(fileSize < 1024)
            {
                readAble = fileSize + "Bytes";
            } else if (fileSize < (1024 * 1024)) {
                double KB = fileSize / 1024.0;
                readAble = String.format("%.2f KB",KB);
            } else if (fileSize < (1024 * 1024 * 1024)) {
                double MB = fileSize / (1024.0 * 1024.0);
                readAble = String.format("%.2f MB",MB);
            }else {
                double GB = fileSize / (1024.0 * 1024.0 * 1024);
                readAble = String.format("%.2f GB",GB);
            }

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

            // save file in folder
            File saveFile = new File(uploadFolder, uniqueName);
            pdDocument.save(saveFile);

            req.setAttribute("success","PDF Protected Successfully.");
            req.setAttribute("filePath",uniqueName);
            req.setAttribute("fileName",fileName);
            req.setAttribute("fileSize",readAble);
            req.setAttribute("fileType","pdf");
            req.getRequestDispatcher("download-protectedfile.jsp").forward(req,resp);


        }


    }
}
