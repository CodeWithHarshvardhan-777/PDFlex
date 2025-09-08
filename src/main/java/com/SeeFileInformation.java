package com;

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

// set for enable file size control, memory handling, Access to File
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50
)
@WebServlet("/SeeFileInformation")
public class SeeFileInformation extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        //get file
        Part file = req.getPart("pdfFile");
        String fileName = file.getSubmittedFileName();

        // find file size in all format
        long fileSize = file.getSize();

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


        try(InputStream inputStream = file.getInputStream();
            PDDocument document = PDDocument.load(inputStream)
        ){

            // get information object
            PDDocumentInformation information = document.getDocumentInformation();

            boolean isEncrypted = document.isEncrypted();
            String lock = "";
            if(isEncrypted)
            {
                lock = "Encrypted";
            }else {
                lock = "Not Encrypted";
            }

            // get creation date from metadata
            Calendar calendar = information.getCreationDate();
            // get modification date from metadata
            Calendar calendar1 = information.getModificationDate();

            // make data formatter
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss a z");


                    // set Attribute
            req.setAttribute("fileName",fileName);
            req.setAttribute("title",information.getTitle());
            req.setAttribute("fileSize",readAble);
            req.setAttribute("pages",document.getNumberOfPages());
            req.setAttribute("lock",lock);
            req.setAttribute("author",information.getAuthor());
            req.setAttribute("subject",information.getSubject());
            req.setAttribute("keyword",information.getKeywords());
            req.setAttribute("creator",information.getCreator());
            req.setAttribute("producer",information.getCreator());
            req.setAttribute("Creation",simpleDateFormat.format(calendar.getTime()));
            req.setAttribute("Modification",simpleDateFormat.format(calendar1.getTime()));

            // forward attribute
            req.getRequestDispatcher("showfileinfo.jsp").forward(req,resp);

        } catch (Exception e) {
            throw new RuntimeException(e);
        }



    }
}
