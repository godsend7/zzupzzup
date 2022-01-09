package com.zzupzzup.common.util;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.util.Date;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.HttpMethod;
import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.GeneratePresignedUrlRequest;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.util.IOUtils;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

public class S3ImageUpload {
	
	final private AmazonS3 s3Client;
	
	//@Value("${commonProperties['bucketName']}")
	String bucketName = "zzupzzup";
	
	//@Value("${commonProperties['accessKey']}")
	String accessKey = "AKIAR6WB263EJSZIAIIL";
	
	//@Value("${commonProperties['secretKey']}")
	String secretKey = "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";

	public S3ImageUpload() {
		AWSCredentials credentials = new BasicAWSCredentials(accessKey, secretKey);
		
		this.s3Client = AmazonS3ClientBuilder.standard()
                .withCredentials(new AWSStaticCredentialsProvider(credentials))
                .withRegion(Regions.AP_NORTHEAST_2)
                .build();
		// TODO Auto-generated constructor stub
	}
	
	//다중 image 업로드
	public void uploadMultiFile(MultipartFile multipartFile, String s3Path) {
		
	    try {
			// set ObjectMatadata
			byte[] bytes = IOUtils.toByteArray(multipartFile.getInputStream());

		    ObjectMetadata objectMetadata = new ObjectMetadata();
		    objectMetadata.setContentLength(bytes.length);
		    objectMetadata.setContentType(multipartFile.getContentType());
		
		    // save in S3
		    ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(bytes);
		    this.s3Client.putObject(this.bucketName, s3Path.replace(File.separatorChar, '/'), byteArrayInputStream, objectMetadata);
			  
		    byteArrayInputStream.close();
		      
		}catch(Exception e){
		    	e.printStackTrace();
		}
	}
	
	//단일 image 업로드
	public void uploadFile(MultipartFile image, String s3Path) {
		try {
			// set ObjectMatadata
			byte[] bytes = IOUtils.toByteArray(image.getInputStream());

		    ObjectMetadata objectMetadata = new ObjectMetadata();
		    objectMetadata.setContentLength(bytes.length);
		    objectMetadata.setContentType(image.getContentType());
		
		    // save in S3
		    ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(bytes);
		    this.s3Client.putObject(this.bucketName, s3Path.replace(File.separatorChar, '/'), byteArrayInputStream, objectMetadata);
			  
		    byteArrayInputStream.close();
		      
		}catch(Exception e){
		    	e.printStackTrace();
		}
	}

//    // upload thumbnail image file
//    public void uploadThumbFile(MultipartHttpServletRequest image, String thumbs3Path) {
//      try {
//        // make thumbnail image for s3
//        BufferedImage bufferImage = ImageIO.read(image.getInputStream());
//        BufferedImage thumbnailImage = Thumbnails.of(bufferImage).size(400, 333).asBufferedImage();
//
//        ByteArrayOutputStream thumbOutput = new ByteArrayOutputStream();
//        String imageType = image.getContentType();
//        ImageIO.write(thumbnailImage, imageType.substring(imageType.indexOf("/")+1), thumbOutput);
//
//        // set metadata
//        ObjectMetadata thumbObjectMetadata = new ObjectMetadata();
//        byte[] thumbBytes = thumbOutput.toByteArray();
//        thumbObjectMetadata.setContentLength(thumbBytes.length);
//        thumbObjectMetadata.setContentType(image.getContentType());
//
//        // save in s3
//        InputStream thumbInput = new ByteArrayInputStream(thumbBytes);
//        this.s3Client.putObject(this.bucketName, thumbs3Path.replace(File.separatorChar, '/'), thumbInput, thumbObjectMetadata);
//	
//        thumbInput.close();
//        thumbOutput.close();
//    }catch(Exception e){log.error(e.getMessage());}
//  }
	
	// get presigned URL
	public String getFileURL(String fileName) {
	  System.out.println("넘어오는 파일명 : "+fileName);

	  // set expiration
	  Date expiration = new Date();
	  long expTimeMillis = expiration.getTime();
	  expTimeMillis += 1000 * 60 * 60; // 1 hour
	  expiration.setTime(expTimeMillis);

	  // Generate the presigned URL.
	  GeneratePresignedUrlRequest generatePresignedUrlRequest =
	  	new GeneratePresignedUrlRequest(bucketName, (fileName).replace(File.separatorChar, '/'))
	      .withMethod(HttpMethod.GET)
	      .withExpiration(expiration);

	  return s3Client.generatePresignedUrl(generatePresignedUrlRequest).toString();
	}
}
