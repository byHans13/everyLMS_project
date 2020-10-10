package com.icia.classHome;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.icia.classHome.AdmiApplicationBean;
import com.icia.classHome.ClassBean;
import com.icia.classHome.CourseBean;
import com.icia.classHome.CourseBoardBean;
import com.icia.classHome.FileBean;
import com.icia.classHome.MemoBean;
import com.icia.classHome.ProblemBean;
import com.icia.classHome.ScheduleBean;
import com.icia.member.Member;
import com.google.gson.Gson;

@Service
public class ClassHomeService {
	@Autowired
	private ClassHomeDao cDao;
	ModelAndView mav;

	public ModelAndView selectMyCalendar(AdmiApplicationBean ab, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		ab.setAa_id(session.getAttribute("id").toString()); // 아직 더미데이터로 작업해야해서 아이디 주고 시작 ;
		List<AdmiApplicationBean> aList;
		aList = cDao.selectMyCalendar(ab); // 수강신청값 받아옴
		if (aList != null) {
			System.out.println("selectMyCalendar select success");
			mav.setViewName("Student/ClassManagement/MyScheduel");
			mav.addObject("classList", new Gson().toJson(aList));
		} else {
			System.out.println("selectMyCalendar select fail");
		}
		return mav;
	}

	public List<ScheduleBean> selectSchedule(ScheduleBean sb, HttpSession session) {
		sb.setSc_id(session.getAttribute("id").toString());
		System.out.println("cb="+sb);
		List<ScheduleBean> sList = cDao.selectSchedule(sb);
		System.out.println("sList="+sList);
		if (sList != null) {
			return sList;
		} else {
			return null;
		}
	}

	public List<ScheduleBean> insertSchedule(ScheduleBean sb, HttpSession session) {
		sb.setSc_id(session.getAttribute("id").toString());
		List<ScheduleBean> sList = null;

		if (cDao.insertSchedule(sb)) { // insert가 된 경우
			sList = cDao.selectSchedule(sb); // 년 월 일 필요
			System.out.println("달력 insert 성공 후 select까지 성공");
		} else {
			sList = cDao.selectSchedule(sb);
			System.out.println("달력 insert 실패 후 select는 성공");
		}

		return sList;
	}

	public List<ScheduleBean> deleteSchedule(ScheduleBean sb, HttpSession session) {
		// sb.setSc_id(session.getAttribute("id").toString());
		sb.setSc_id(session.getAttribute("id").toString());
		List<ScheduleBean> sList = null;
		if (cDao.deleteSchedule(sb)) {
			sList = cDao.selectSchedule(sb);
			System.out.println("calendar delete success after select calendar");
		} else {
			sList = cDao.selectSchedule(sb);
			System.out.println("calendar delete fail after select calendar");
		}
		return sList;
	}

	public List<CourseBean> classLecture(ClassBean cb, HttpSession session) {
		String aa_id = session.getAttribute("id").toString(); // 여기 원래 sessionId 넣어줘야함
		CourseBean cob = new CourseBean();
		cob.setAa_id(aa_id);
		cob.setCo_idnum(cb.getCl_idnum());
		cob.setCo_lv(cb.getCl_lv());
		List<CourseBean> cList = cDao.classLecture(cob);
		if (cList != null) {
			return cList;
		} else {
			return null;
		}
	}

	public List<CourseBean> selectCourseList(CourseBean cb) {
		System.out.println("dons cb="+cb);
		List<CourseBean> cList;
		cList = cDao.selectCourseList(cb);
		System.out.println("dons test"+cList.get(0).getCo_lv());
		if (cList != null) {
			return cList;
		}
		return null;
	}

	public ModelAndView selectClassHomePage(ClassBean cb, HttpSession session) {
		List<ClassBean> cList;
		List<CourseBoardBean> rList;
		mav = new ModelAndView();
		String view;
		String avgNum=null;
		cList = cDao.selectClassHome(cb);
		session.setAttribute("classId", cList.get(0).getCl_id());
		if (cList != null) {
			avgNum = cDao.selectClassAvgNum(cb);
			if(avgNum == null) {
				avgNum="0";
			}
			rList = cDao.selectInfoReview(cb);
			System.out.println(rList);
			view = "Student/ClassHome/ClassHome";
		} else {
			view = "./";
			rList = null;
		}
		mav.addObject("classInfo", new Gson().toJson(cList));
		mav.addObject("avgNum", avgNum);
		mav.addObject("infoReview", new Gson().toJson(rList));
		mav.setViewName(view);
		return mav;
	}

	public ModelAndView selectClassLectureVideoPage(CourseBean cob, HttpSession session) {
		FileBean fl = new FileBean();
		mav = new ModelAndView();
		String view;
		fl.setFl_idnum(cob.getCo_idnum());
		fl.setFl_num(cob.getCo_num());
		fl.setFl_lv(cob.getCo_lv());
		List<FileBean> fList;
		fList = cDao.selectLectureVideoPage(fl);
		fl.setFl_id(session.getAttribute("id").toString()); // 아직 session 받아올 id값이 없음
		if (fList != null) { // select success
			view = "Student/ClassHome/LectureVideo";
			RestTimeBean rtBean = new RestTimeBean();
			rtBean = cDao.selectRestTime(fl);
			if (rtBean != null) {
				mav.addObject("restTime", new Gson().toJson(rtBean));
				System.out.println("restTime=" + rtBean);
			} else {
				mav.addObject("restTime", null);
			}

		} else {
			view = "./";
		}
		mav.addObject("LectureInfo", new Gson().toJson(fList));
		System.out.println("atmk="+cob.getAtd_atmk());
		if(cob.getAtd_atmk() != null) {
			mav.addObject("atmk", cob.getAtd_atmk());			
		}else {
			mav.addObject("atmk", 0);
		}
		mav.setViewName(view);

		return mav;
	}

	public List<MemoBean> insertMemo(MemoBean mb, HttpSession session) {
		List<MemoBean> mList;
		mb.setMo_id(session.getAttribute("id").toString()); // sessionID로 수정해야하는 값
		int memoCnt = cDao.selectMemoCnt(mb); // 작성하기 전 테이블에 저장값 있는지 확인
		if (memoCnt != 0) {
			System.out.println("이미 테이블에 메모 저장값 있음");
			if (cDao.updateMemo(mb)) {
				System.out.println("update success");
				mList = cDao.selectMemo(mb);
			} else {
				System.out.println("update fail");
				mList = null;
			}
		} else {// 저장값 확인 위한 if문 END
			if (cDao.insertMemo(mb)) {
				System.out.println("insert success");
				mList = cDao.selectMemo(mb);
			} else {
				System.out.println("insert fail");
				mList = null;
			}
		} // 저장값이 없어서 insert 돌린 문 END
		return mList;
	}// insertMemo END

	public List<MemoBean> selectMemoForStart(MemoBean mb, HttpSession session) {
		mb.setMo_id(session.getAttribute("id").toString()); // sessionID값으로 바꿔줘야함
		List<MemoBean> mList;
		System.out.println(mb.getMo_idnum());
		System.out.println(mb.getMo_num());
		mList = cDao.selectMemo(mb);
		if (mList != null) {
			return mList;
		} else
			return null;
	}

	public ModelAndView selectPreviewQuiz(ClassBean cl, HttpSession session) {
		System.out.println(cl);
		ProblemBean pb = new ProblemBean();
		Random random = new Random();
		Map<String, List<ProblemBean>> pMap = new HashMap<>();
		int QuizNum = 5;
		int[] coNum = new int[QuizNum];
		int[] pbNum = new int[QuizNum];
		List<CourseBean> cList = cDao.selectCourseNum(cl);

		for (int i = 0; i < QuizNum; i++) {
			if (cList != null) {
				int courseNum = random.nextInt(cList.size()) + 1;
				pb.setPb_idnum(cl.getCl_idnum());
				pb.setPb_lv(cl.getCl_lv());
				pb.setPb_num(courseNum);
				coNum[i] = courseNum;
				pb.setPb_id(session.getAttribute("classId").toString());
				List<ProblemBean> pList = cDao.selectProblemNum(pb);
				if (pList != null) {
					pb.setPb_pbnum(random.nextInt(pList.size()) + 1);
					pbNum[i] = pb.getPb_pbnum();
					pList = cDao.selectPreviewQuiz(pb);
					System.out.println(pList);
					if (pList != null) {
						pMap.put("Quiz" + (i + 1), pList);
						if (i > 0) {
							for (int j = 0; j < i; j++) {
								if (coNum[j] == coNum[i] && pbNum[j] == pbNum[i]) {
									i--;
									break;
								}
							}
						}
					} else {
						System.out.println("problemView table select fail");
						mav.addObject("previewQuiz", "문제 출력에 실패했습니다. 원인: 퀴즈 일련번호 오류");
					}
				} else {
					System.out.println("problem table select fail");
					mav.addObject("previewQuiz", "문제 출력에 실패했습니다. 원인: 강좌 일련번호 오류");
				}
			} else {
				System.out.println("course table select fail");
				mav.addObject("previewQuiz", "문제 출력에 실패했습니다. 원인: 강의 일련번호 오류");
			}
		} // 초기 for문
		if (pMap != null) {
			mav.addObject("previewQuiz", new Gson().toJson(pMap));
		}
		mav.setViewName("Student/ClassHome/PreviewQuiz");
		return mav;
	}

	public List<CourseBoardBean> selectClassNotice(CourseBoardBean CNB) {
		List<CourseBoardBean> CNBList = cDao.selectClassNotice(CNB);
		if (CNBList != null) {
			return CNBList;
		} else {
			return null;
		}
	}

	public List<CourseBoardBean> selectClassQNA(CourseBoardBean QNA, HttpSession session) {
		QNA.setCob_id(session.getAttribute("id").toString()); // sessionID 넣어야함
		List<CourseBoardBean> QNAList = cDao.selectClassQNA(QNA);
		if (QNAList != null) {
			return QNAList;
		} else {
			return null;
		}
	}

	public List<CourseBoardBean> insertMyClassQNA(CourseBoardBean QNA, HttpSession session) {
		// id , bonum
		if (QNA.getCob_kind() != 2) {
			return null;
		} else {
			List<CourseBoardBean> QNAList;
			QNA.setCob_id(session.getAttribute("id").toString()); // sessionID 넣어야
			QNA.setCob_bonum("MQ");
			String cont = QNA.getCob_cont();
			System.out.println(cont);
			cont.replace("\r\n", "<br/>");
			QNA.setCob_cont(cont);
			if (cDao.insertMyClassQna(QNA)) {
				System.out.println("success success success");
				QNAList = cDao.selectClassQNA(QNA);
				return QNAList;
			} else {
				System.out.println("fail fail fail fail");
				return null;
			}
		}
	}

	public List<CourseBoardBean> selectMyQnaDetail(CourseBoardBean QNA) {
		List<CourseBoardBean> QNAList;
		int cnt = 0;
		cnt = cDao.selectDetailViewReplyCount(QNA);
		if (cnt != 0) {
			QNAList = cDao.selectClassDetailViewReply(QNA);
			System.out.println("댓글 있음");
			return QNAList;
		} else {
			System.out.println("댓글 없음");
			QNAList = cDao.selectClassDetailView(QNA);
			return QNAList;
		}
	}

	public String insertQnaReply(CourseBoardBean QR, HttpSession session) {
		String reply = QR.getCr_reply();
		QR = cDao.selectReplyNumInfo(QR);
		if (QR.getCob_idnum() != null) {
			QR.setCob_id(session.getAttribute("id").toString()); // session ID
			QR.setCr_reply(reply);
			if (cDao.insertQnaReply(QR)) {
				String semiBonum = QR.getCob_bonum();
				String bonum = new Gson().toJson(semiBonum);
				return bonum;
			} else {

				return null;
			}
		} else {
			return null;
		}
	}

	public List<CourseBoardBean> selectClassReview(CourseBoardBean review) {
		List<CourseBoardBean> rList = cDao.selectClassReview(review);
		System.out.println(rList);
		if (rList != null) {
			return rList;
		} else {
			return null;
		}
	}

	public double selectMyClassAvg(CourseBoardBean review, HttpSession session) {
		review.setCob_id(session.getAttribute("id").toString()); // session
		int gpaCnt = cDao.selectGpaCount(review); // sessionID가 강좌평가한 cnt
		int courseCnt = cDao.selectCourseCount(review) - 1; // idnum에 강좌가 몇개인지
		double classAvg;
		System.out.println(review.getCob_idnum());
		System.out.println("gpaCnt =" + gpaCnt);
		System.out.println("courseCnt=" + courseCnt);
		if (gpaCnt >= courseCnt && gpaCnt != 0 && courseCnt != 0) {
			classAvg = cDao.selectMyClassAvg(review);
			return classAvg;
		} else {
			int admi = cDao.selectClassAdmi(review);
			System.out.println("admi=" + admi);
			if (admi == 1) {
				classAvg = -1;
				return classAvg;
			} else {
				classAvg = 0;
				return classAvg;
			}
		}
	}

	public String insertClassReview(CourseBoardBean review, HttpSession session) {
		String bonum;
		review.setCob_id(session.getAttribute("id").toString());// session
		review.setCob_num(0);
		if (review.getCob_kind() == 3) {
			review.setCob_bonum("CR");
		}
		int reviewNum = cDao.selectClassReviewCnt(review); // 강의후기 작성했는지 Chk
		if (reviewNum != 0) {
			bonum = "이미 해당강의의 리뷰를 작성하셨습니다.";
			return bonum;
		} else {
			if (cDao.insertClassReviewBoard(review)) {
				if (cDao.insertClassReviewGpa(review)) {
					bonum = cDao.selectClassReviewBoardNum(review);
					System.out.println("cob_bonum=" + bonum);
					if (bonum != null) {
						// board, gpa insert success >> bonum select success
						bonum = new Gson().toJson(bonum);
						return bonum;
					} else {
						// bonum 출력 실패
						return null;
					}
				} else {
					bonum = "rollback되야함 왜? board에만 insert 됨";
					System.out.println("gpa insert fail need transaction!");
					return bonum;
				}
			} else {
				bonum = "강의후기 작성에 실패했습니다.";
				return bonum;
			}
		} // 제일 위 if의 else
	}

	public List<CourseBoardBean> selectClassReviewDetail(CourseBoardBean review, HttpSession session) {
		List<CourseBoardBean> rList;
		review.setCob_id(session.getAttribute("id").toString()); // session으로 바꿔줘야함
		int cnt = 0;
		cnt = cDao.selectDetailViewReplyCount(review);
		if (cnt != 0) {
			rList = cDao.selectClassDetailViewReply(review);
			System.out.println("댓글 있음");
			return rList;
		} else {
			System.out.println("댓글 없음");
			rList = cDao.selectClassDetailView(review);
			return rList;
		}
	}

	public String insertReviewReply(CourseBoardBean review, HttpSession session) {
		String reply = review.getCr_reply();
		review = cDao.selectReplyNumInfo(review);
		if (review.getCob_idnum() != null) {
			review.setCob_id(session.getAttribute("id").toString()); // session ID
			review.setCr_reply(reply);
			if (cDao.insertQnaReply(review)) {
				String bonum = review.getCob_bonum();
				bonum = new Gson().toJson(bonum);
				return bonum;
			} else {

				return null;
			}
		} else {
			return null;
		}

	}

	public int insertRestTime(RestTimeBean rt, HttpSession session) {
		rt.setRt_id(session.getAttribute("id").toString());
		System.out.println("rt=" + rt);
		int inOrUp = cDao.selectRestTimeCount(rt);
		System.out.println("inOrUp=" + inOrUp);
		if (inOrUp != 0) {
			if (cDao.updateRestTime(rt)) {
				return 1;
			} else {
				return 0;
			}
		} else {
			if (cDao.insertRestTime(rt)) {
				int rtCnt = cDao.selectRestTimeCount(rt);
				System.out.println("rtCnt=" + rtCnt);
				if (rtCnt != 0) {
					return rtCnt;
				} else {
					return 0;
				}
			} else {
				return 0;
			}
		}

	}

	public ModelAndView selectCourseQuiz(EvaluationBean ef, HttpSession session) {
		mav = new ModelAndView();
		String view;
		List<EvaluationBean> eList;
		HashSet<String> Set;
		HashMap<String, List<EvaluationBean>> eMap = new HashMap<>();
		Set = cDao.selectEfItemForEvaluation(ef);
		Iterator<String> efSet = Set.iterator();

		int i = 0;
		while (efSet.hasNext()) {
			ef.setEf_item(efSet.next().toString());
			eList = cDao.selectCourseQuiz(ef);
			if (eList != null) {
				eMap.put("evaluation" + i, eList);
				i = i + 1;
			}
		}
		if (eMap.size() != 0) {
			mav.addObject("evaluation", new Gson().toJson(eMap));
			eList = cDao.selectAnswerKind();
			if (eList != null) {
				mav.addObject("answerKind", new Gson().toJson(eList));
				view = "Student/ClassHome/CourseQuiz";
			} else {
				mav.addObject("answerKind", null);
				view = "Student/ClassHome/CourseQuiz";
			}
		} else {
			mav.addObject("evaluation", null);
			view = "Student/ClassHome/CourseQuiz";
		}
		mav.setViewName(view);
		return mav;
	}

	public int insertCourseEvaluation(HashMap<String, EvaluationBean> eMap, HttpSession session) {
		int chkNum = 0;
		int QuizCnt = 0;
		int gpa = 0;
		for (int i = 0; i < eMap.size(); i++) {
			if (cDao.insertCourseEvaluation(eMap.get("ef" + i))) {
				gpa += eMap.get("ef" + i).getAk_score();
			} else {
				chkNum = 1;
				break;
			}
		}
		System.out.println(gpa);
		if (chkNum != 1) {
			gpa = gpa / 4;
			System.out.println("gpa/=" + gpa);
			eMap.get("ef0").setAk_score(gpa);
			if (cDao.insertCourseGpa(eMap.get("ef0"))) {
				eMap.get("ef0").setEa_id(session.getAttribute("classId").toString());
				QuizCnt = cDao.selectCourseQuizCnt(eMap.get("ef0"));
				return QuizCnt;
			} else {
				QuizCnt = 0;
				return QuizCnt;
			}
		} else {
			QuizCnt = 0;
			return QuizCnt;
		}
	}

	public int selectEvaluationCntChk(EvaluationBean eBean, HttpSession session) {
		eBean.setEa_id(session.getAttribute("id").toString());
		int cnt = cDao.selectEvaluationCntChk(eBean);
		if (cnt != 0) {
			eBean.setEa_id(session.getAttribute("classId").toString());
			int QuizCnt = cDao.selectCourseQuizCnt(eBean);
			return QuizCnt;
		} else {
			return 0;
		}
	}

	public List<ProblemBean> selectCoursePbnum(ProblemBean pb, HttpSession session) {
		pb.setPb_id(session.getAttribute("classId").toString());
		List<ProblemBean> numList = cDao.selectCoursePbnum(pb);
		if (numList != null) {
			return numList;
		} else {
			return null;
		}
	}

	public List<ProblemBean> selectCourseQuizWithPbnum(ProblemBean pb, HttpSession session) {
		List<ProblemBean> pList;
		pb.setPb_id(session.getAttribute("id").toString());
		int cnt = cDao.selectCoQuizCntForchk(pb);
		if (cnt != 0) {
			pList = cDao.selectCoQuizThroughId(pb); // 체크한 값 가져오기
		} else {
			pb.setPb_id(session.getAttribute("classId").toString());
			pList = cDao.selectCoQuizThroughId(pb);// 교수 id로 select
		}
		System.out.println(pList);
		if (pList != null) {
			return pList;
		} else {
			return null;
		}
	}

	public int insertCourseQuiz(ProblemBean pb, HttpSession session) {
		String sessionID = session.getAttribute("id").toString();
		pb.setPb_id(sessionID);
		String pb_pbstudent = pb.getPb_pbstudent();
		int insertChk = cDao.selectCourseQuizForInsertChk(pb);
		int pbnum = 0;
		if (insertChk != 0) {
			if (cDao.updateCourseQuiz(pb)) {
				pbnum = pb.getPb_pbnum();
			} else {
				pbnum = 0;
			}
		} else {
			pb.setPb_id(session.getAttribute("classId").toString());
			pb = cDao.selectPbdata(pb);
			pb.setPb_pbstudent(pb_pbstudent);
			pb.setPb_id(sessionID);
			if (cDao.insertCourseQuiz(pb)) {
				pbnum = pb.getPb_pbnum();
				;
			} else {
				pbnum = 0;
			}
		}
		return pbnum;
	}

	public int lastQuizInsert(ProblemBean pb, HttpSession session) {
		String sessionClassId = session.getAttribute("classId").toString();
		String sessionID = session.getAttribute("id").toString();
		List<ProblemBean> pList;
		int insertChk = 0;
		pb.setPb_id(sessionClassId);
		int CourseQuizCnt = cDao.selectcqCnt(pb);
		int[] defaultArr = new int[CourseQuizCnt];
		int[] myQuizArr = new int[CourseQuizCnt];
		boolean result = false;
		double quizGrade = 0;
		int pb_lv = pb.getPb_lv();
		if (pb.getPb_pbstudent() != null) {
			String pb_pbstudent = pb.getPb_pbstudent();
			pb.setPb_id(sessionID);
			insertChk = cDao.selectCourseQuizForInsertChk(pb); // 마지막으로 가져온 문제 풀었는지 여부
			if (insertChk != 0) {
				result = cDao.updateCourseQuiz(pb);// 풀었으면 업데이트
			} else {
				pb.setPb_id(sessionClassId);
				pb = cDao.selectPbdata(pb);// 정보가 없으므로 기본 데이터 출력
				pb.setPb_pbstudent(pb_pbstudent);
				pb.setPb_id(sessionID);
				result = cDao.insertCourseQuiz(pb); // 가져온 답으로 insert
			}
		} else {
			result = true; // 번호 입력 x로 퀴즈 끝
		}
		if (result) {
			System.out.println("insert or update success or not student");
		}
		pb.setPb_id(sessionClassId);
		pList = cDao.selectCourseQuizPbnum(pb); // pList에 해당 회차 모든 퀴즈pk값 넣어줌 + length
		for (int i = 0; i < pList.size(); i++) {
			defaultArr[i] = pList.get(i).getPb_pbnum();
		}
		pb.setPb_id(sessionID);
		pList = cDao.selectCourseQuizPbnum(pb); // pList에 내가 푼 문제 값 넣어줌
		for (int i = 0; i < pList.size(); i++) {
			myQuizArr[i] = pList.get(i).getPb_pbnum();
		}
		for (int i = 0; i < defaultArr.length; i++) {
			insertChk = 0;
			pb.setPb_pbnum(defaultArr[i]);
			pb.setPb_id(sessionClassId);
			pb.setPb_lv(pb_lv);
			pb = cDao.selectPbdata(pb);
			pb.setPb_id(sessionID);
			pb.setPb_pbstudent("0");
			for (int j = 0; j < myQuizArr.length; j++) {
				if (defaultArr[i] == myQuizArr[j]) {
					insertChk = 1;
				} // j:if
			} // j
			if (insertChk == 0) {
				if (pb.getPb_pbstudent().equals(pb.getPb_pbexplain())) {// ==0 문제를 못 풀어서 default값 0 입력 실질적으로 if true문 실행 안됨
					pb.setPb_answerchk(1);
					result = cDao.insertLastQuiz(pb);
					quizGrade += 1;
				} else {
					pb.setPb_answerchk(0);
					result = cDao.insertLastQuiz(pb);
					quizGrade += 0;
				}
			} else { // insertChk == 1
				pb.setPb_id(sessionID);
				pb = cDao.selectPbdata(pb);
				System.out.println("update before ="+pb.getPb_pbstudent().equals(pb.getPb_pbexplain()));
				System.out.println("eeeeee="+pb.getPb_pbstudent());
				System.out.println("rrrrrrr="+pb.getPb_pbexplain());
				if (pb.getPb_pbstudent().equals(pb.getPb_pbexplain())) {
					pb.setPb_answerchk(1);
					System.out.println("pb_answerchk="+pb.getPb_answerchk());
					result = cDao.updateCourseQuizAnswerchk(pb);
					quizGrade += 1;
				} else {
					pb.setPb_answerchk(0);
					result = cDao.updateCourseQuizAnswerchk(pb);
					quizGrade += 0;
				}
			}
		} // i
		GradeBean gb = new GradeBean();
		if (result == true) {
			double insertGrade = quizGrade / defaultArr.length;
			insertGrade = Math.floor(insertGrade*100);
			gb.setGr_score(insertGrade);
			gb.setGr_id(sessionID);
			gb.setGr_idnum(pb.getPb_idnum());
			gb.setGr_lv(pb.getPb_lv());
			gb.setGr_num(pb.getPb_num());
			if(gb.getGr_num() ==0) {
				gb.setGr_kind("H");
			}else {
				gb.setGr_kind("Q");				
			}
			result = cDao.insertCourseGrade(gb);
		}
		int count = cDao.selectLastQuizCnt(pb);
		if(gb.getGr_num()!=0) {
			if (defaultArr.length == count) {
				if (cDao.insertCourseAtmk(pb)) {
					System.out.println("출석 변경 성공");
					gb.setGr_score(1);
					gb.setGr_kind("A");
					cDao.insertCourseGrade(gb);
					// insert 출석점수
					return 1;
				} else {
					return 0;
				}
			} else {
				return 0;
			}
		}else {
			if(result==true) {
				return 1;
			}else {
				return 0;
			}
		}
	}
	public boolean insertOrientationAtmk(ProblemBean pb, HttpSession session) {
		boolean result = false;
		pb.setPb_id(session.getAttribute("id").toString());
		result = cDao.insertOrientationAtmk(pb);
		return result;
	}

	public boolean insertClassLike(LikeBean lb) {
		boolean result = false;
		Integer count = 0;
		count = cDao.selectClassLikeById(lb);
		System.out.println("count값=" + count);

		if (count == null) {
			lb.setLikes_check(1);
			result = cDao.insertClassLike(lb);
		} else {
			if (count != 0) {
				lb.setLikes_check(0);
				result = cDao.updateClassLike(lb);
				if (result) {
					result = false;
				}
			} else {
				lb.setLikes_check(1);
				result = cDao.updateClassLike(lb);
			}
		}
		return result;
	}// insertClassLike END

	public ModelAndView selectClassManagementPage(HttpSession session) {
		mav = new ModelAndView();
		AdmiApplicationBean aaBean = new AdmiApplicationBean();
		String sessionId = session.getAttribute("id").toString();
		int deleteChk = 0;
		if (sessionId != null) {
			List<AdmiApplicationBean> myClassList;
			aaBean.setAa_id(sessionId);
			myClassList = cDao.selectMyCalendar(aaBean);// idnum, lv, name, 강수, 수강값 출력
			int size = myClassList.size();
			for (int x = 0; x < size; x++) {
				aaBean = myClassList.get(x);
				aaBean.setAt_atmkCnt(cDao.selectCountMyClassAtmk(aaBean));
				myClassList.set(x, aaBean);
			}
			if (myClassList != null) {
				mav.addObject("myClassList", new Gson().toJson(myClassList));
			} else {
				mav.addObject("myClassList", null);
			}
			List<LikeBean> myLikeList; // 장바구니 리스트
			List<ClassBean> myLikeListInfo = new ArrayList<>();// 장바구니 리스트 수강값 제거한 리스트
			myLikeList = cDao.selectMyLikeList(sessionId);// idnum, lv id check
			System.out.println(myLikeList);
			for (int i = 0; i < myLikeList.size(); i++) {// 좋아요 강의 수
				for (int j = 0; j < myClassList.size(); j++) {// 듣는 강의 수
					deleteChk = 0;
					if (myLikeList.get(i).getLikes_idnum().equals(myClassList.get(j).getCl_idnum())
							&& myLikeList.get(i).getLikes_lv() == myClassList.get(j).getCl_lv()) {
						// 장바구니 값이 이미 수강신청한 경우
						myLikeList.remove(i); // list size 여기서 줄어들
						deleteChk = 1;
						break;
					}
				} // for j
				if (deleteChk == 1) {
					i--;
					continue;
				} else {
					ClassBean cBean = new ClassBean();
					cBean = cDao.selectMyLikeListInfo(myLikeList.get(i));
					myLikeListInfo.add(cBean);
				}
			} // for i
			if (myLikeListInfo != null) {
				mav.addObject("myLikeList", new Gson().toJson(myLikeListInfo));
			} else {
				mav.addObject("myLikeList", null);
			}
		} else {
			mav.addObject("myClassList", null);
			mav.addObject("myLikeList", null);
		}
		mav.setViewName("Student/ClassManagement/ClassManagementPage");
		return mav;
	}

	public Map<String, Object> selectBuyClass(ClassBean cb, HttpSession session) {
		Member mb = new Member();
		Map<String, Object> buyMap = new HashMap<>();
		String sessionId = session.getAttribute("id").toString();
		System.out.println("초기 cb= idnum, lv" + cb);
		cb = cDao.selectClassInfo(cb);
		System.out.println("dao 갔다온 cb=" + cb);
		if (cb.getCl_pt() != null) {
			buyMap.put("cb", cb);
			System.out.println("초기 mb=" + mb);
			mb = cDao.selectMemberInfo(sessionId);
			System.out.println("dao 갔다온 mb=" + mb);
			if (mb != null) {
				buyMap.put("mb", mb);
			} else {
				buyMap = null;
			}
		} else {
			buyMap = null;
		}
		return buyMap;
	}

	public boolean insertBuyClass(ClassBean cb, HttpSession session) {
		boolean result = false;
		String sessionId = session.getAttribute("id").toString();
		Member mb = new Member();
		PointBean pb = new PointBean();
		int classPt = cb.getCl_pt();
		int deductPt = 0;

		mb = cDao.selectMemberInfo(sessionId);
		if (mb != null) {
			deductPt = mb.getMb_point() - classPt;
			System.out.println(deductPt);
			if (deductPt < 0) {
				result = false;
			} else {
				mb.setMb_point(deductPt); // 보유하던 포인트 - 강의point
				if (cDao.updateMyPoint(mb) == true) {
					System.out.println("update query success");
					classPt = classPt * -1;
					pb.setPoint_pt(classPt);
					pb.setPoint_id(sessionId);
					if (cDao.insertPointBreakdown(pb) == true) {
						System.out.println("point insert query success");
						cb.setCl_id(sessionId);
						System.out.println(cb);
						if (cDao.insertClassAdmiApplication(cb) == true) {
							System.out.println("insert AdmiApplication query success");
							result = true;
						} else {
							System.out.println("admi insert fail");
							result = false;
						}
					} else {
						System.out.println("point insert fail");
						result = false;
					}
				} else {
					System.out.println("update point fail");
					result = false;
				}
			}
		} else {
			result = false;
		}
		System.out.println("result=" + result);
		return result;
	}

	public ModelAndView selectLevelCheckPage(HttpSession session) {
		mav = new ModelAndView();
		String sessionId = session.getAttribute("id").toString();
		List<ConcernBean> ccList;
		if(sessionId != null) {
			ccList = cDao.selectLevelCheckPage(sessionId);
			System.out.println("ccBean="+ccList);
			if(ccList != null) {
				mav.addObject("concern", new Gson().toJson(ccList));
			}else {
				mav.addObject("concern", null);
			}
		}else {
			mav.addObject("concern", null);
		}
		mav.setViewName("Student/RecomendClassManagement/LevelCheckPage");
		return mav;
	}

	public Map<String, List<ProblemBean>> selectLevelCheckQuiz(ProblemBean pb) {
		Map<String, List<ProblemBean>> pMap = new HashMap<String, List<ProblemBean>>();
		List<ProblemBean> pList;
		HashSet<Integer> set;
		set = cDao.selectConcernMaxLevel(pb);
		Iterator<Integer> itSet = set.iterator();
		boolean result= false;
		while(itSet.hasNext()) {
			if(pb.getPb_lv() == itSet.next()) {
				result = true;
			}
		}
		System.out.println("result="+result);
		if(result == true) {			
			pList = cDao.selectLevelCheckRandomQuizInfo(pb);//list size=3 
			for(int i=0; i<pList.size(); i++) {
				List<ProblemBean> pListForMap;			
				pListForMap= cDao.selectLevelCheckQuizDetail(pList.get(i));
				pMap.put("Quiz"+i, pListForMap);
			}
			System.out.println(pMap);
			if(pMap !=null) {
				return pMap;
			}else {
				return pMap;			
			}
		}else {
			return pMap;
		}
	}

	public ModelAndView selectClassFinalTest(ProblemBean pb, HttpSession session) {
		mav = new ModelAndView();
		String view;
		List<ProblemBean> pList;
		pb.setPb_id(session.getAttribute("id").toString());
		pList = cDao.selectClassFinalTest(pb);
		mav.addObject("finalTest", new Gson().toJson(pList));
		mav.setViewName("Student/ClassHome/ClassFinalTest");
		return mav;
	}
}// classHomeService END
