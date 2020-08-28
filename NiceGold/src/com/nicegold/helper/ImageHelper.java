package com.nicegold.helper;

//import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
//import java.io.OutputStream;
//import java.nio.file.Files;
//import java.nio.file.Path;
//import java.nio.file.Paths;
//import java.util.Iterator;
//import javax.imageio.IIOImage;
//import javax.imageio.ImageIO;
//import javax.imageio.ImageWriteParam;
//import javax.imageio.ImageWriter;
//import javax.imageio.stream.ImageOutputStream;

public class ImageHelper {

    public boolean saveImage(InputStream is, String inputpath) throws IOException {
        Boolean b = false;
        byte[] data = new byte[is.available()];
        is.read(data);
        try (FileOutputStream fos = new FileOutputStream(inputpath, true)) {
            fos.write(data);
            fos.close();
            b=true;
        } catch (Exception e) {
        }
        return b;
    }

    public boolean deleteimagefromfolder(String path){
        boolean f = false;
        try{
            File input = new File(path);
            f=input.delete();
        }catch(Exception e){}
        return f;
    }
    
//    public Boolean compressImage(String path, String outpath, int size) {
//        boolean b = false;
//        try {
//            File input = new File(path);
//            File compressedImageFile = new File(outpath);
//            int a = (int) input.length();
//            if (a / 1024 > size) {
//                BufferedImage image = ImageIO.read(input);
//                OutputStream os = new FileOutputStream(compressedImageFile);
//                Iterator<ImageWriter> writers = ImageIO.getImageWritersByFormatName("jpg");
//                ImageWriter writer = (ImageWriter) writers.next();
//                ImageOutputStream ios = ImageIO.createImageOutputStream(os);
//                writer.setOutput(ios);
//                ImageWriteParam param = writer.getDefaultWriteParam();
//                param.setCompressionMode(ImageWriteParam.MODE_EXPLICIT);
//                param.setCompressionQuality(1.0f);
//                writer.write(null, new IIOImage(image, null, null), param);
//                input.delete();
//                os.close();
//                ios.close();
//                writer.dispose();
//                b = true;
//            } else {
//                Path p = Files.move(Paths.get(path), Paths.get(outpath));
//                b = true;
//            }
//        } catch (IOException exception) {
//
//        }
//        return b;
//    }
    
}
