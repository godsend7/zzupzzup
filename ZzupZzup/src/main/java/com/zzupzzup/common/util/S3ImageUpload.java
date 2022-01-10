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
	public void uploadFile(MultipartFile multipartFile, String s3Path) {
		
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
