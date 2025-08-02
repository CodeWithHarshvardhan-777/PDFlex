package com.pdfmaster;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDDocumentInformation;
import org.apache.pdfbox.pdmodel.common.PDMetadata;
import org.apache.pdfbox.cos.COSName;
import org.apache.pdfbox.cos.COSDictionary;

import javax.crypto.Cipher;
import java.io.File;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;

public class Compression {
    public static void main(String[] args) throws NoSuchAlgorithmException {
        System.out.println(Cipher.getMaxAllowedKeyLength("AES"));

    }
}