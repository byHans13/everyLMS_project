package com.icia.materialUpload;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface IMaterialUploadDao {

	//시험문제
	List<MaterialUpload> selectTestMaterialClassList(MaterialUpload mu);

	int selectTestMaterialCountList(MaterialUpload mu);
	
	List<MaterialUpload> insertTestMaterialUploadPage(MaterialUpload mu);

	List<MaterialUpload> insertTestMaterialUploadFrmAjax(MaterialUpload mu);

	List<MaterialUpload> selectTestMaterialCourseAjax(MaterialUpload mu);

	List<MaterialUpload> selectTestMaterialCourse(MaterialUpload mu);
	
	boolean insertTestMaterialUploadProblemAjax(MaterialUpload mu);

	boolean insertTestMaterialUploadDetailProblemAjax(MaterialUpload mu);
	
	MaterialUpload selectViewTestMaterialUploadPageAjax(MaterialUpload mu);
	
	String selectClname(MaterialUpload mu);

	int selectCllcnum(MaterialUpload mu);

	
	//퀴즈문제
	List<MaterialUpload> selectQuizMaterialClassList(MaterialUpload mu);

	int selectQuizMaterialCountList(MaterialUpload mu);

	List<MaterialUpload> selectQuizMaterialClCoList(MaterialUpload mu);

	List<MaterialUpload> insertQuizMaterialUploadPage(MaterialUpload mu);

	List<MaterialUpload> insertQuizMaterialUploadFrmAjax(MaterialUpload mu);

	List<MaterialUpload> selectQuizMaterialCourseAjax(MaterialUpload mu);

	boolean insertQuizMaterialUploadProblemAjax(MaterialUpload mu);

	boolean insertQuizMaterialUploadDetailProblemAjax(MaterialUpload mu);









}
