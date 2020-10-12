package com.icia.classHome;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.icia.classHome.ClassBean;
import com.icia.classHome.CourseBean;
import com.icia.classHome.CourseBoardBean;
import com.icia.classHome.MemoBean;
import com.icia.classHome.ScheduleBean;
import com.icia.homework.HomeworkBean;

@RequestMapping(value="/stud")
@RestController
public class ClassHomeRestController {
	@Autowired
	ClassHomeService cs;
	
	@PostMapping(value="rest/selectScheduleAjax")
	public  List<ScheduleBean> SelectSchedule(ScheduleBean sb, HttpSession session) {
		List<ScheduleBean> sList = cs.selectSchedule(sb, session);
		return sList;
	}
	@PostMapping(value="rest/insertScheduleAjax")
	public List<ScheduleBean> InsertSchedule(ScheduleBean sb, HttpSession session){
		 List<ScheduleBean> sList = cs.insertSchedule(sb, session);
		 return sList;
	}
	@PostMapping(value="rest/deleteScheduleAjax")
	public  List<ScheduleBean> deleteSchedule(ScheduleBean sb, HttpSession session) {
		List<ScheduleBean> sList = cs.deleteSchedule(sb, session);
		return sList;
	}
	@PostMapping(value="rest/selectCourseListAjax")
	public  List<CourseBean> selectCourseList(CourseBean cb) {
		List<CourseBean> cList = cs.selectCourseList(cb);
		return cList;
	}
	@PostMapping(value="rest/insertClassLike")
	public boolean insertClassLike(LikeBean lb) {
		boolean result = cs.insertClassLike(lb);
		return result;
	}
	@PostMapping(value="rest/classLectureAjax")
	public List<CourseBean> classLecture(ClassBean cb, HttpSession session){
		List<CourseBean> cList = cs.classLecture(cb, session);
		return cList;
	}
	@PostMapping(value="rest/insertRestTimeAjax")
	public int insertRestTime(RestTimeBean rt, HttpSession session) {
		int cnt = cs.insertRestTime(rt, session);
		return cnt;
	}
	@PostMapping(value="rest/selectEvaluationCntChkAjax")
	public int selectEvaluationCntChk(EvaluationBean eBean, HttpSession session) {
		int cnt = cs.selectEvaluationCntChk(eBean, session);
		return cnt;
	}
	@PostMapping(value="rest/insertCourseEvaluationAjax")
	public int insertCourseEvaluation(@RequestBody List<HashMap<String, Object>> obj, HttpSession session) {
		EvaluationBean eBean; new EvaluationBean();
		HashMap<String, EvaluationBean> eMap = new HashMap<>();
		for(int i=0; i<obj.size(); i++) {
			eBean=new EvaluationBean();
			eBean.setEa_id(session.getAttribute("id").toString());
			eBean.setEf_question(obj.get(i).get("ef_question").toString());
			eBean.setAk_score(Integer.parseInt(obj.get(i).get("ak_score").toString()));
			eBean.setEf_lv(Integer.parseInt(obj.get(i).get("ef_lv").toString()));
			eBean.setEf_idnum(obj.get(i).get("ef_idnum").toString());
			eBean.setEf_num(Integer.parseInt(obj.get(i).get("ef_num").toString()));
			eBean.setEf_item(obj.get(i).get("ef_item").toString());
			eMap.put("ef"+i, eBean);
		}
		int QuizCnt = cs.insertCourseEvaluation(eMap, session);
		return QuizCnt;
	}
	@PostMapping(value="rest/selectCoursePbnumAjax")
	public List<ProblemBean> selectCoursePbnumAjax(ProblemBean pb, HttpSession session){
		List<ProblemBean> numList = cs.selectCoursePbnum(pb, session);
		return numList;
	}
	@PostMapping(value="rest/selectCourseQuizWithPbnum")
	public List<ProblemBean> selectCourseQuizWithPbnum(ProblemBean pb, HttpSession session){
		List<ProblemBean> pList = cs.selectCourseQuizWithPbnum(pb, session);
		return pList;
	}
	@PostMapping(value="rest/insertCourseQuiz")
	public int insertCourseQuiz(ProblemBean pb, HttpSession session) {
		int pbnum = cs.insertCourseQuiz(pb, session);
		return pbnum;
	}
	@PostMapping(value="rest/insertOrientationAtmk")
	public boolean insertOrientationAtmk(ProblemBean pb, HttpSession session) {
		boolean result = cs.insertOrientationAtmk(pb, session);
		return result;
	}
	@PostMapping(value="rest/lastQuizInsert")
	public int lastQuizInsert (ProblemBean pb, HttpSession session) {
		int cnt = cs.lastQuizInsert(pb, session);
		return cnt;
	}
	@PostMapping(value="rest/selectMemoForStart")
	public List<MemoBean> selectMemoForStart(MemoBean mb, HttpSession session){
		List<MemoBean> mList = cs.selectMemoForStart(mb, session);
			return mList;			
		
	}
	@PostMapping(value="rest/insertMemoAjax")
	public List<MemoBean> insertMemo(MemoBean mb, HttpSession session){
		List<MemoBean> mList = cs.insertMemo(mb, session);
		return mList;
	}
	@PostMapping(value="rest/selectClassNoticeAjax")
	public List<CourseBoardBean> selectClassNotice(CourseBoardBean CNB){
		List<CourseBoardBean> CNBList = cs.selectClassNotice(CNB);
		return CNBList;
	}
	@PostMapping(value="rest/selectClassQNA")
	public List<CourseBoardBean> selectClassQNA(CourseBoardBean QNA, HttpSession session){
		List<CourseBoardBean> QNAList = cs.selectClassQNA(QNA, session);
		
		return QNAList;
	}
	@PostMapping(value="rest/insertMyClassQnaAjax")
	public List<CourseBoardBean> insertMyClassQNA(CourseBoardBean QNA, HttpSession session) {
		List<CourseBoardBean> QNAList = cs.insertMyClassQNA(QNA, session);
		return QNAList;
	}
	@PostMapping(value="rest/selectClassQnaDetail")
	public List<CourseBoardBean> selectMyQnaDetail(CourseBoardBean QNA){
		List<CourseBoardBean> QNAList = cs.selectMyQnaDetail(QNA);
		return QNAList;
	}
	@PostMapping(value="rest/insertQnaReply")
	public String insertQnaReply(CourseBoardBean QR, HttpSession session) {
		String bonum = cs.insertQnaReply(QR, session);
		return bonum;
	}
	@PostMapping(value="rest/selectClassReview")
	public List<CourseBoardBean> selectClassReview(CourseBoardBean review){
		List<CourseBoardBean> rList = cs.selectClassReview(review);
		return rList;
	}
	@PostMapping(value="rest/selectMyClassAvg")
	public double selectMyClassAvg(CourseBoardBean review, HttpSession session){
		double classAvg = cs.selectMyClassAvg(review, session);
		return classAvg;
	}
	@PostMapping(value="rest/insertClassReview")
	public String insertClassReview(CourseBoardBean review, HttpSession session) {
		String bonum = cs.insertClassReview(review, session);
		return bonum;
	}
	@PostMapping(value="rest/selectClassReviewDetail")
	public List<CourseBoardBean> selectClassReviewDetail(CourseBoardBean review, HttpSession session){
		List<CourseBoardBean> rList = cs.selectClassReviewDetail(review, session);
		return rList;
	}
	@PostMapping(value="rest/insertReviewReply")
	public String insertReviewReply(CourseBoardBean review, HttpSession session) {
		String bonum = cs.insertReviewReply(review, session);
		return bonum;
	}
	@GetMapping(value="rest/selectBuyClass")
	public Map<String, Object> selectBuyClass (ClassBean cb, HttpSession session){
		Map<String, Object> buyMap = cs.selectBuyClass(cb, session);
		return buyMap;
	}
	@PostMapping(value="rest/insertBuyClass")
	public boolean insertBuyClass(ClassBean cb, HttpSession session) {
		boolean result = cs.insertBuyClass(cb, session);
		return result;
	}
	@GetMapping(value="rest/selectLevelCheckQuiz")
	public Map<String, List<ProblemBean>>  selectLevelCheckQuiz(ProblemBean pb){
		System.out.println(pb.getDp_pbexmnum());
		Map<String, List<ProblemBean>> pMap = cs.selectLevelCheckQuiz(pb);
		return pMap;
	}
	@GetMapping(value="rest/selectFinalTestPbnum")
	public List<ProblemBean> selectFinalTestPbnum(ProblemBean pb) {
		List<ProblemBean> pbnum = cs.selectFinalTestPbnum(pb);
		return pbnum;
	}
	@GetMapping(value="rest/insertFinalTestForceStop")
	public boolean insertFinalTestForceStop(ProblemBean pb, HttpSession session) {
		boolean result = cs.insertFinalTestPbnum(pb, session);
		return result;
	}
	@GetMapping(value="rest/selectClassHomeworkList")
	public List<HomeworkBean> selectClassHomeworkList (HomeworkBean hw, HttpSession session){
		List<HomeworkBean> hwList = cs.selectClassHomeworkList(hw, session);
		return hwList;
	}
}
