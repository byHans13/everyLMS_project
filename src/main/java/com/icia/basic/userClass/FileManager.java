package com.icia.basic.userClass;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.icia.classup.ClassUpBean;
import com.icia.classup.IClassUpDao;
import com.icia.course.CourseFilesBean;
import com.icia.course.ICourseDao;

/*import com.han.board.dao.IBoardDao;
import com.han.board.bean.Board;
import com.han.board.bean.entity.BoardFile;*/

import lombok.extern.log4j.Log4j;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class FileManager {
	
	@Autowired
	private ICourseDao cd;
	
	@Autowired
	private IClassUpDao cud;
	 
	String fullpath = "C:/realwork/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/everyLMS_gahee/";
	//String fullpath = "C:/Users/gahee/Documents/project/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/everyLMS_project/";
	//String fullpath = "C:/work/springWork/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/RealProject_semi/";
	//String fullpath = "C:\\work\\springWork\\RealProject_semi\\src\\main\\webapp\\video";
	
	public boolean fileUp(MultipartHttpServletRequest multi,CourseFilesBean cfb) {
		
		// 1.이클립스의 물리적 저장경로 찾기
		String root = multi.getSession().getServletContext().getRealPath("/");
		System.out.println("root:  " + root);
		String path = root + "video/";
		System.out.println("fullpath: "+path);
		// 2.폴더 생성을 꼭 할것...
		File dir = new File(path);
		if (!dir.isDirectory()) { // upload폴더 없다면
			dir.mkdir(); // upload폴더 생성
		}


		// 3.파일을 가져오기-파일태그가 1개 일때
		List<MultipartFile> fList = multi.getFiles("fileName");
		
		boolean isFile = false;
		
		for (int i = 0; i < fList.size(); i++) {
			// 파일 메모리에 저장
			MultipartFile mf = fList.get(0); // 실제파일
			String oriFileName = mf.getOriginalFilename(); // a.txt
			System.out.println("oriFileName:  "+ oriFileName);
			// 4.시스템파일이름 생성 a.txt ==>112323242424.txt
			String sysFileName = System.currentTimeMillis() + "."+ oriFileName.substring(oriFileName.lastIndexOf(".") + 1);
			System.out.println("sysFileName:  "+ sysFileName);
			// 5.메모리->실제 파일 업로드
			cfb.setFl_oriname(oriFileName);
			cfb.setFl_sysname(sysFileName);
			try {
				mf.transferTo(new File(path + sysFileName)); // 서버upload에 파일 저장
				isFile = cd.courseFileInsert(cfb);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} // while or For end
		if (isFile)
			return true;
		
		return false;
	}
	
	
public boolean fileUpdate(MultipartHttpServletRequest multi, CourseFilesBean cfb) {
		
		// 1.이클립스의 물리적 저장경로 찾기
		String root = multi.getSession().getServletContext().getRealPath("/");
		System.out.println("root:  " + root);
		String path = root + "video/";
		System.out.println("fullpath: "+path);
		// 2.폴더 생성을 꼭 할것...
		File dir = new File(path);
		if (!dir.isDirectory()) { // upload폴더 없다면
			dir.mkdir(); // upload폴더 생성
		}
		// 3.파일을 가져오기-파일태그가 1개 일때
		List<MultipartFile> fList = multi.getFiles("fileName");
		
		boolean isFile = false;
		
		
			// 파일 메모리에 저장
			MultipartFile mf = fList.get(0); // 실제파일
			String oriFileName = mf.getOriginalFilename(); // a.txt
			System.out.println("oriFileName:  "+ oriFileName);
			// 4.시스템파일이름 생성 a.txt ==>112323242424.txt
			String sysFileName = System.currentTimeMillis() + "."+ oriFileName.substring(oriFileName.lastIndexOf(".") + 1);
			System.out.println("sysFileName:  "+ sysFileName);
			cfb.setFl_sysname(sysFileName);
			cfb.setFl_oriname(oriFileName);
			try {
				mf.transferTo(new File(path + sysFileName)); // 서버upload에 파일 저장
				isFile = cd.updateCourseFile(cfb);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		// while or For end
		if (isFile) 
			return true;
		
		return false;
		
	}




//파일 다운로드
	public void download(String fullpath, String sysFileName, HttpServletResponse resp) throws Exception {
		//String root = multi.getSession().getServletContext().getRealPath("/");
		fullpath =this.fullpath+"video/";
		System.out.println("fullpath: "+ fullpath);
		// 한글파일 깨짐 방지
		String downFile = URLEncoder.encode(sysFileName, "UTF-8");
		/* 파일명 뒤에 이상한 문자가 붙는 경우 아래코드를 해결 */
		// downFile = downFile.replaceAll("\\+", "");
		// 파일 객체 생성
		File file = new File(fullpath+sysFileName);
		// 다운로드 경로 파일을 읽어 들임
		InputStream is = new FileInputStream(file);
		// 반환객체설정
		
		String isImg = sysFileName.substring(sysFileName.lastIndexOf(".")+1);
		System.out.println("확장자    :  "+isImg);
		if(isImg.equals("jpg")||isImg.equals("png")||isImg.equals("gif")) {
			resp.setContentType("image/jpeg");
			
		}else {
			resp.setContentType("application/octet-stream");
			resp.setHeader("content-Disposition", "attachment; filename=\"" + downFile + "\";");
		}
		
		// 반환객체에 스트림 연결
		OutputStream os = resp.getOutputStream();

		// 파일쓰기
		byte[] buffer = new byte[1024];
		int length;
		while ((length = is.read(buffer)) != -1) {
			os.write(buffer, 0, length);
		}
		os.flush();
		os.close();
		is.close();
	}

	// 파일 삭제
	public void delete(List<CourseFilesBean> fileD) {
			
		for(CourseFilesBean f:fileD) {
			File file = new File(fullpath+ f.getFl_sysname());
			if (file.exists()) {
				System.out.println("파일 삭제");
				file.delete();
			} else {
				log.info("이미 삭제된 파일");
			}
			
		}

	}
	
	
	
public boolean pictureInsert(MultipartHttpServletRequest multi, ClassUpBean cb) {
		
		// 1.이클립스의 물리적 저장경로 찾기
		String root = multi.getSession().getServletContext().getRealPath("/");
		System.out.println("root:  " + root);
		String path = root + "picture/";
		System.out.println("fullpath: "+path);
		// 2.폴더 생성을 꼭 할것...
		File dir = new File(path);
		if (!dir.isDirectory()) { // upload폴더 없다면
			dir.mkdir(); // upload폴더 생성
		}


		// 3.파일을 가져오기-파일태그가 1개 일때
		List<MultipartFile> fList = multi.getFiles("fileName");
		
		boolean isFile = false;
		
		for (int i = 0; i < fList.size(); i++) {
			// 파일 메모리에 저장
			MultipartFile mf = fList.get(0); // 실제파일
			String oriFileName = mf.getOriginalFilename(); // a.txt
			System.out.println("oriFileName:  "+ oriFileName);
			
			String sysFileName = System.currentTimeMillis() + "."+ oriFileName.substring(oriFileName.lastIndexOf(".") + 1);
			System.out.println("sysFileName:  "+ sysFileName);
			// 5.메모리->실제 파일 업로드
			cb.setPi_pioriname(oriFileName);
			cb.setPi_pisysname(sysFileName);
			try {
				mf.transferTo(new File(path + sysFileName)); // 서버upload에 파일 저장
				isFile = cud.classFileInsert(cb);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} // while or For end
		if (isFile)
			return true;
		
		return false;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	


}
