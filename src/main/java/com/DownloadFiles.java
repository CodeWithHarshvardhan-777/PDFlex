package com;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;

@WebServlet("/DownloadFiles")
public class DownloadFiles extends HttpServlet {

    private static final String downloadPath = "C:\\Users\\Admin\\IdeaProject\\PDFMaster\\protectedFiles";
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get file name
        String fileName = request.getParameter("fileName");
        String filePath = request.getParameter("filePath");
        System.out.println(fileName);



        // Resolve actual file location
        File file = new File(downloadPath, filePath);

        if (!file.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found.");
            return;
        }

        // Set response headers for download
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
        response.setContentLengthLong(file.length());

        try (BufferedInputStream inStream = new BufferedInputStream(new FileInputStream(file));
             BufferedOutputStream outStream = new BufferedOutputStream(response.getOutputStream())) {

            byte[] buffer = new byte[4096];
            int bytesRead;

            while ((bytesRead = inStream.read(buffer)) != -1) {
                outStream.write(buffer, 0, bytesRead);
            }

            TempFileCleaner.cleaneFiles(downloadPath,1);
        }
    }
}
