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
import org.apache.pdfbox.pdmodel.PDDocumentInformation;

import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Calendar;


@WebServlet("/FileInfo")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1,
        maxFileSize = 1024 * 1024 * 20,
        maxRequestSize = 1024 * 1024 * 100
)
public class FileInformation extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Part part = req.getPart("pdfFile");

        long size = part.getSize();
        String fileSize;

        if (size < 1024)
        {
            fileSize = size + "Byte";
        }else if(size < 1024 * 1024)
        {
            double sizeKB = (double) size / 1024;
            fileSize = String.format("%.2f KB",sizeKB);
        } else if (size < 1024 * 1024 * 1024) {
            double sizeMB = (double) size / (1024 * 1024);
            fileSize = String.format("%.2f MB",sizeMB);
        }else {
            double sizeGB = (double) size / (1024 * 1024 * 1024);
            fileSize = String.format("%.2f GB",sizeGB);
        }

       try {
           InputStream inputStream = part.getInputStream();
           PDDocument pdDocument = null;
           //load pdf
               pdDocument = PDDocument.load(inputStream);

           PDDocumentInformation pdDocumentInformation = pdDocument.getDocumentInformation();

           String fileName = part.getSubmittedFileName();
           String fileTitle = pdDocumentInformation.getTitle() != null ? pdDocumentInformation.getTitle() : "NOT AVAILABLE";
           String fileAuthor = pdDocumentInformation.getAuthor() != null ? pdDocumentInformation.getAuthor() : "NOT AVAILABLE";
           int pages = pdDocument.getNumberOfPages();
           boolean encrypted = pdDocument.isEncrypted();
           String lock;
           if(encrypted)
           {
               lock = "Protected";
           }else {
               lock = "Not Protected";
           }
           String fileSubject = pdDocumentInformation.getSubject() != null ? pdDocumentInformation.getSubject() : "NOT AVAILABLE";
           String fileKeywords = pdDocumentInformation.getKeywords() != null ? pdDocumentInformation.getKeywords() : "NOT AVAILABLE";
           String fileCreator = pdDocumentInformation.getCreator() != null ? pdDocumentInformation.getCreator() : "NOT AVAILABLE";
           String fileProducer = pdDocumentInformation.getProducer() != null ? pdDocumentInformation.getProducer() : "NOT AVAILABLE";
           Calendar creationdate = pdDocumentInformation.getCreationDate() != null ? pdDocumentInformation.getCreationDate() : null;
           Calendar modificationdate = pdDocumentInformation.getModificationDate() != null ? pdDocumentInformation.getModificationDate() : null;

           SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

           String creation = creationdate != null ? dateFormat.format(creationdate.getTime()) : "NOT AVAILABLE";
           String modification = modificationdate != null ? dateFormat.format(modificationdate.getTime()) : "NOT AVAILABLE";

           req.setAttribute("success","success");
           req.setAttribute("pdfInfo","success");
           req.setAttribute("fileName",fileName);
           req.setAttribute("pages",pages);
           req.setAttribute("lock",lock);
           req.setAttribute("title",fileTitle);
           req.setAttribute("fileSize",fileSize);
           req.setAttribute("author",fileAuthor);
           req.setAttribute("subject",fileSubject);
           req.setAttribute("keyword",fileKeywords);
           req.setAttribute("creator",fileCreator);
           req.setAttribute("producer",fileProducer);
           req.setAttribute("Creation",creation);
           req.setAttribute("Modification",modification);

           RequestDispatcher requestDispatcher = req.getRequestDispatcher("showfileinfo.jsp");
           requestDispatcher.forward(req,resp);


       } catch (Exception e) {
           req.setAttribute("error","Something went wrong while processing the PDF.");
           req.getRequestDispatcher("fileinfo.jsp").forward(req,resp);
           return;
       }
    }
}
