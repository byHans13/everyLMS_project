package com.icia.adminMainPage;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.icia.introductionTeacherConfirm.IntroductionTeacherConfirmBean;
import com.icia.member.Member;

@Service
public class AdminMainPageMM {

	@Autowired
	IAdminMainPageDao ampDao;

	public Map<String, Object> selectJoinMemberAdmin() {
		LocalDate currentDate = LocalDate.now(); // 오늘 날짜
		String[] todayArr = currentDate.toString().split("-"); // 오늘날짜 배열
		String tdSpl1 = todayArr[0]; // 오늘연도
		String tdYearSearch = tdSpl1.substring(2, tdSpl1.length()) + "/"; // 검색용
		String tdSpl2 = todayArr[1]; // 오늘달
		int tdyear = Integer.parseInt(tdSpl1); // 오늘연도 숫자버젼
		int tdmonth = Integer.parseInt(tdSpl2); // 오늘달 숫자버젼
		LocalDate minusDate = LocalDate.now().minusYears(1); // 1년전 날짜
		String[] previosArr = minusDate.toString().split("-"); // 1년전 날짜 배열
		String pvSpl1 = previosArr[0]; // 지난연도
		String pvSpl2 = previosArr[1]; // 지난달
		String pvMonthSearch = "/" + pvSpl2 + "/";
		int pvyear = Integer.parseInt(pvSpl1); // 지난연도 숫자버젼
		int pvmonth = Integer.parseInt(pvSpl2) + 1; // 지난달 숫자버젼
		List<String> dateList = ampDao.selectJoinMemberAdmin(); // Dao count list
		Set<String> dateSet = new HashSet<String>(); // 연도 리스트
		// dateSet.add(pvSpl1); //연도 set
		// dateSet.add(tdSpl1); //
		Map<String, Object> graphMap = new HashMap<String, Object>(); // 최종
		Comparator<String> cop = (s1, s2)->s1.compareTo(s2); 
		Map<String, Object> inputMap = new TreeMap<String, Object>(cop);
		List<Integer> inputmonth = new ArrayList<Integer>();
		for (int i = 0; i < 13; i++) {
			if (pvmonth < 13 && pvmonth != 01) {
				inputmonth.add(pvmonth);
				pvmonth += 1;
			} else if (pvmonth > 12) {
				pvmonth = 01;
				inputmonth.add(pvmonth);
			} else if (pvmonth == 01) {
				pvmonth += 1;
			}
		}
		int cnt = 0;
		List<String> monthList = new ArrayList<String>();
		List<Integer> monthCount = new ArrayList<Integer>();
		for (int i = 0; i < dateList.size(); i++) {
			System.out.println("hans" + dateList.get(i).toString());
			String[] arr = dateList.get(i).split("-");
			String spl1 = arr[0];
			String spl2 = arr[1];
			if (spl1.equals(pvSpl1)) {
				dateSet.add(spl1);
			}
			if (spl1.equals(tdSpl1)) {
				dateSet.add(spl1);
			}
			monthList.add(spl2);
			if (monthList.get(i).toString().equals("0" + i)) {
				cnt++;
			}
		}
		Iterator<String> itr = dateSet.iterator();
		List<String> setComp = new ArrayList<String>();
		while (itr.hasNext()) {
			setComp.add(itr.next().toString());
		}
		// for(int i = 0 )
		if (Integer.parseInt(setComp.get(0)) < Integer.parseInt(setComp.get(1))) {
			System.out.println("비교가 가능함");
		}

		for (int i = 0; i < setComp.size(); i++) {
			for (int j = 0; j < setComp.size(); j++) {
				if (Integer.parseInt(setComp.get(i)) < Integer.parseInt(setComp.get(j))) {
					int a = Integer.parseInt(setComp.get(i));
					setComp.set(i, setComp.get(j));
					setComp.set(j, Integer.toString(a));
				}
			}
		} // setComp 정리
		String setCompLast = setComp.get(0).substring(2) + "/";
		String setCompToday = setComp.get(1).substring(2) + "/";
		int monJoinCnt;
		int chk = 0;
		for (int i = 0; i < 12; i++) {
			String searchMonth = ("/" + String.format("%02d", inputmonth.get(i)) + "/");
			// pvMonthSearch, tdYearSearch
			if (i > 0) {
				if (Integer.parseInt(inputmonth.get(i - 1).toString()) > Integer
						.parseInt(inputmonth.get(i).toString())) {
					chk = i;
					inputMap.put(setComp.get(1) + "_" + String.format("%02d", inputmonth.get(i)),
							monJoinCnt = ampDao.selectCountJoinMember(searchMonth, setCompToday));
					System.out.println("i=" + i);
					System.out.println("반복문의 결과(cnt) : " + monJoinCnt);
					System.out.println("chk=" + chk);
				}

			} else {
				if (inputmonth.get(i) > 1) {
					inputMap.put(setComp.get(0) + "_" + String.format("%02d", inputmonth.get(i)),
							monJoinCnt = ampDao.selectCountJoinMember(searchMonth, setCompLast));
				} else {
					inputMap.put(setComp.get(1) + "_" + String.format("%02d", inputmonth.get(i)),
							monJoinCnt = ampDao.selectCountJoinMember(searchMonth, setCompToday));
				}

			}
		}
		for (int i = 0; i < 12; i++) {
			String searchMonth = ("/" + String.format("%02d", inputmonth.get(i)) + "/");
			if (chk > i) {
				System.out.println("chk=" + chk);
				System.out.println("(chk>i)i=" + i);
				inputMap.put(setComp.get(0) + "_" + String.format("%02d", inputmonth.get(i)),
						monJoinCnt = ampDao.selectCountJoinMember(searchMonth, setCompLast));
			}
			if (chk < i) {
				System.out.println("chk=" + chk);
				System.out.println("(chk<i)i=" + i);
				inputMap.put(setComp.get(1) + "_" + String.format("%02d", inputmonth.get(i)),
						monJoinCnt = ampDao.selectCountJoinMember(searchMonth, setCompToday));
			}
		}
		graphMap.put("yearList", setComp);
		graphMap.put("result", inputMap);

		System.out.println("반복문 길이 : " + dateList.size());
		System.out.println("set 길이 : " + dateSet.size());
		System.out.println("set 내용 : " + dateSet.toString());
		System.out.println("set 내용뽑기 : " + dateSet.iterator().next().toString());
		System.out.println("set 내용뽑기 : " + dateSet.iterator().next().toString());
		System.out.println("setComp 정리하여 나열 : " + setComp);
		System.out.println("list 길이 : " + monthList.size());
		System.out.println("list 내용 : " + monthList.get(100).toString());
		System.out.println("1월 COUNT: " + cnt);
		System.out.println("오늘 날짜: " + currentDate);
		System.out.println("오늘년도 : " + tdSpl1);
		System.out.println("오늘달월  : " + tdSpl2);
		System.out.println("지난 년도 날짜: " + minusDate);
		System.out.println("지난년도 : " + pvSpl1);
		System.out.println("지난달월  : " + pvSpl2);
		System.out.println("지난달월 숫자버젼  : " + pvmonth);
		System.out.println("현재달부터 리스트 : " + inputmonth);
		System.out.println("현재달부터 리스트 2번쨰 인덱스 출력 : " + inputmonth.get(2) + "/");
		System.out.println("지난년도 숫자버젼 : " + pvyear);
		System.out.println("오늘년도 검색용 : " + tdYearSearch);
		System.out.println("inputMap 검색용 : " + inputMap);
		System.out.println("담을 Map -> {(yearList: dateSet), (result : map(inputmonth(i):dao.count))}");

		return graphMap;
	}

	public List<IntroductionTeacherConfirmBean> selectProfConfirm() {
		List<IntroductionTeacherConfirmBean> ctList = new ArrayList<IntroductionTeacherConfirmBean>();
		int length = ampDao.selectCountCtTable();
			ctList=ampDao.selectProfCerti();		
		return ctList;
	}

	public List<AdminMainPageBean> selectIntroduction(String mb_id, String ct_prof) {
		List<AdminMainPageBean> ampList = new ArrayList<AdminMainPageBean>();
		ampList=ampDao.selectIntroduction(mb_id, ct_prof);
		return ampList;
	}

	public List<AdminMainPageBean> selectCertification(String mb_id, String ct_prof) {
		List<AdminMainPageBean> ampList = new ArrayList<AdminMainPageBean>();
		ampList=ampDao.selectCertification(mb_id, ct_prof);
		return ampList;
	}

	
}
