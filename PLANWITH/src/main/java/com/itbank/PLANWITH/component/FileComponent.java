package com.itbank.PLANWITH.component;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.util.Arrays;
import java.util.UUID;

import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;

@Component
@Log4j
public class FileComponent {
	
	private String saveDirectory = "C:\\upload";
	
	Resource resource = new ClassPathResource("default.png");
	 
	public FileComponent() {
		File dir = new File(saveDirectory);
		if(dir.exists() == false) {
			dir.mkdirs();	
		}
		// 업로드 파일에 기본이미지(default.png) 저장
		try {
			File imageFile = resource.getFile();		 
			if(Arrays.asList(dir.list()).contains("default.png") == false) {			
				Path src = imageFile.toPath();
				Path dst = new File(saveDirectory, imageFile.getName()).toPath();
				Files.copy(src, dst,  StandardCopyOption.REPLACE_EXISTING);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public String uploadFile(MultipartFile f) {
		String extName = f.getOriginalFilename().substring(f.getOriginalFilename().lastIndexOf("."));
		String storedFileName = UUID.randomUUID().toString().replace("-", "") ;
		storedFileName += extName;
		File dest = new File(saveDirectory, storedFileName);
		try {
			f.transferTo(dest);
			return storedFileName;
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	public boolean deleteFile(String storedFileName) {
		File f = new File(saveDirectory, storedFileName);
		if (f.exists()) {
			return f.delete();
		}
		return false;
	}

//	public int uploadAndGetId(MultipartFile profileImage) {
//		
//		return 0;
//	}

	
}
