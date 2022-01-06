package org.conan.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.conan.domain.AttachFileDTO;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
@AllArgsConstructor
public class UploadController {

	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);
	}

	@GetMapping("/uploadForm")
	public void uploadForm() {
		log.info("upload form");
	}

	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFile, Model model) {
		String uploadFolder = "c:/upload";

		for (MultipartFile multipartFile : uploadFile) {
			log.info("--------------------------------------------");
			log.info("Upload File Name : " + multipartFile.getOriginalFilename());
			log.info("Upload File Size : " + multipartFile.getSize());
			UUID uuid = UUID.randomUUID();
			String uploadFileName = multipartFile.getOriginalFilename();
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());
			try {
				multipartFile.transferTo(saveFile);
			} catch (Exception e) {
				log.error(e.getMessage());
			}
		}
	}

	@GetMapping("uploadAjax")
	public void uploadAjax() {
		log.info("upload ajax");
	}

	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		String uploadFolder = "c:/upload";
		List<AttachFileDTO> list = new ArrayList<>();
		File uploadPath = new File(uploadFolder, getFolder());
		log.info("upload Path : " + uploadPath);
		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		for (MultipartFile multipartFile : uploadFile) {
			AttachFileDTO attachDTO = new AttachFileDTO();
			log.info("========================================");
			log.info("Upload File Name : " + multipartFile.getOriginalFilename());
			log.info("Upload File Size : " + multipartFile.getSize());
			UUID uuid = UUID.randomUUID();
			String uploadFileName = multipartFile.getOriginalFilename();
			attachDTO.setFileName(uploadFileName);
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			File saveFile = new File(uploadPath, uploadFileName);
			try {
				multipartFile.transferTo(saveFile);
				attachDTO.setUuid(uuid.toString());
				attachDTO.setUploadPath(getFolder());
				if (checkImageType(saveFile)) {
					attachDTO.setImage(true);
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_" + uploadFileName));
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnail, 100, 100);
					thumbnail.close();
				}
				list.add(attachDTO);
				log.info("attachDTO : " + attachDTO);
			} catch (Exception e) {
				// TODO: handle exception
				log.error(e.getMessage());
			}
		}
		return new ResponseEntity<>(list, HttpStatus.OK);

	}

	private boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());
			return contentType.startsWith("image");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}

	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName) {
		log.info("fileName : " + fileName);
		File file = new File("c:/upload/" + fileName);
		log.info("file : " + file);
		ResponseEntity<byte[]> result = null;
		try {
			HttpHeaders header = new HttpHeaders();
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			// 적당한 MIME타입을 헤더에 추가
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return result;
	}

	@GetMapping(value = "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFile(String fileName) {

		log.info("download file :" + fileName);
		Resource resource = new FileSystemResource("c:/upload/" + fileName);

		Resource urid = new FileSystemResource("c:/upload/" + fileName);
		if (resource.exists() == false) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		log.info("resource : " + resource);
		String resourceName = resource.getFilename();
		// remove UUID
		String resourceOriginalName = resourceName.substring(resourceName.indexOf("_") + 1);
		log.info("resourceOriginalName : " + resourceOriginalName);
		HttpHeaders headers = new HttpHeaders();
		try {
			headers.add("Content-Disposition",
					"attachment; fileName=" + new String(resourceOriginalName.getBytes("UTF_8"), "ISO-8859-1"));// 다운로드시
																												// 저장되는
																												// 이름
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return new ResponseEntity<Resource>(resource, headers, HttpStatus.OK);
	}

	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileName, String type) {
		log.info("deleteFile : " + fileName);
		File file;
		try {
			file = new File("c:/upload/" + URLDecoder.decode(fileName, "UTF-8"));
			file.delete();
			if (type.equals("image")) {
				String targetFileName = file.getAbsolutePath().replace("s_", "");
				log.info("targetFileName : " + targetFileName);
				file = new File(targetFileName);
				file.delete();
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
			// TODO: handle exception
		}
		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}
}
