package com.icia.h2k5every;

import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.CoreMatchers.notNullValue;
import static org.junit.Assert.assertThat;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.icia.member.Member;
import com.icia.member.MemberMM;

import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "file:src/main/webapp/WEB-INF/spring/**/*-context.xml")
public class JoinFrmTest {

	
	@Autowired
	MemberMM mm;
	
	@Test
	public void testJoinIdMake() {		
		Member mb = new Member();
		List<Member> mlist = new ArrayList<Member>();
		for(int i=201;i<301;i++) {
			mb.setMb_addr("인천 남동구");
			mb.setMb_email("byvictor13@gmail.com");
			mb.setMb_gender("남");
			if (i<10) {
				mb.setMb_id("test"+"-00"+i);				
			}else if(i<100) {
				mb.setMb_id("test"+"-0"+i);
			}else {
				mb.setMb_id("test-"+i);
			}
			mb.setMb_loe("수원대학교");
			mb.setMb_name("한승호");
			mb.setMb_phone("01039772745");
			mb.setMb_point(0);
			mb.setMb_pw("gks9163");
			mb.setMb_rrn1(900829);
			mb.setMb_rrn2(1156410);
			mb.setCc_cc("인터넷");
			mlist.add(mb);
			String[] arr=mb.getMb_id().split("-");
			String spl1=arr[0];
			String spl2=arr[1];
			int spl3=Integer.parseInt(spl2);
			String mb_id=mb.getMb_id();
			mm.insertMemberJoin2(mb, mb_id, spl3);			
		}
		
		assertThat(mlist.size(), is(100));
	}
}
