package com.carshowroom.util;

import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

public class ImageUploadUtil {

    private static final Set<String> SUPPORTED_FORMATS = new HashSet<>(Arrays.asList("jpg", "jpeg", "png"));

    public static String saveImage(MultipartFile image, String uploadDir) throws IOException {
        String originalFilename = image.getOriginalFilename();
        if (originalFilename == null || originalFilename.isEmpty()) {
            throw new IOException("Invalid file name.");
        }

        String fileExtension = getFileExtension(originalFilename);
        if (!isSupportedFormat(fileExtension)) {
            throw new IOException("Unsupported file format. Only JPG, JPEG, and PNG are allowed.");
        }

        try {
            // Attempt to read the image to confirm it's valid
            BufferedImage bufferedImage = ImageIO.read(image.getInputStream());
            if (bufferedImage == null) {
                throw new IOException("Invalid image file.");
            }

            // Create the file path
            //String fileName = System.currentTimeMillis() + "." + fileExtension;
            String fileName = image.getOriginalFilename();
            File file = new File(uploadDir + fileName);

            // Write the image to the file
            ImageIO.write(bufferedImage, fileExtension, file);

            return fileName; // Return the file name for storing in the database
        } catch (IOException e) {
            throw new IOException("Failed to process image: " + e.getMessage(), e);
        }
    }

    private static String getFileExtension(String fileName) {
        int lastDotIndex = fileName.lastIndexOf('.');
        return (lastDotIndex == -1) ? "" : fileName.substring(lastDotIndex + 1).toLowerCase();
    }

    private static boolean isSupportedFormat(String fileExtension) {
        return SUPPORTED_FORMATS.contains(fileExtension);
    }
}

