package com;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDDocumentInformation;

import java.io.IOException;
import java.io.InputStream;

@WebServlet("/SeeFileInformation")
public class SeeFileInformation extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        //get file
        Part file = req.getPart("");
        String fileName = file.getSubmittedFileName();

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

            // set Attribute
            req.setAttribute("fileName",fileName);
            req.setAttribute("title",information.getTitle());
            req.setAttribute("pages",document.getNumberOfPages());
            req.setAttribute("lock",lock);
            req.setAttribute("author",information.getAuthor());
            req.setAttribute("subject",information.getSubject());
            req.setAttribute("keyword",information.getKeywords());
            req.setAttribute("creator",information.getCreator());
            req.setAttribute("producer",information.getCreator());
            req.setAttribute("Creation",information.getCreationDate());
            req.setAttribute("Modification",information.getModificationDate());

            // forward attribute
            req.getRequestDispatcher("showfileinfo.jsp").forward(req,resp);

        } catch (Exception e) {
            throw new RuntimeException(e);
        }



    }
}
