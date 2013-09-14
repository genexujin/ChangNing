package com.xiangyun.notary.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.xiangyun.notary.Constants;
import com.xiangyun.notary.common.ReservationStatus;
import com.xiangyun.notary.common.WorkdayDisplay;
import com.xiangyun.notary.domain.Reservation;
import com.xiangyun.notary.domain.TimeSegment;
import com.xiangyun.notary.domain.User;
import com.xiangyun.notary.domain.Workday;
import com.xiangyun.notary.service.ReservationService;
import com.xiangyun.notary.service.WorkdayService;

@Controller
public class ReservationController {

	private static Logger log = LoggerFactory
			.getLogger(ReservationController.class);

	@Autowired
	private ReservationService reservationService;
	@Autowired
	private WorkdayService workdayService;

	@RequestMapping(value = "/enterReservQuery.do")
	public ModelAndView enterReservQuery() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("reserv_query");
		return mav;
	}

	@RequestMapping(value = "customQuery.do")
	public void customQuery(HttpServletResponse response, String readableId)
			throws IOException {
		String json = null;
		ObjectMapper objectMapper = new ObjectMapper();
		Reservation reservation = reservationService
				.findByReadableId(readableId);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("readableId", readableId);
		map.put("reservDate", reservation.getReservationDate());
		map.put("reservTime", reservation.getReservationTimeSegment());
		map.put("requestorName", reservation.getRequestorName());
		map.put("reservKey", reservation.getReservationKey());
		map.put("reservStatus", reservation.getReservationStatus());
		json = objectMapper.writeValueAsString(map);
		PrintWriter out = response.getWriter();
		out.print(json);
	}

	@RequestMapping(value = "cancleReserv.do")
	public void cancleReserv(String readableId) {
		Reservation reservation = reservationService
				.findByReadableId(readableId);
		reservation.setReservationStatus(ReservationStatus.CANCELLED);
		reservationService.save(reservation);
	}

	@RequestMapping(value = "workerQuery.do")
	public void workerQuery(HttpServletResponse response, String readableId,
			ReservationStatus reservStatus, int pageNO) throws IOException {
		String json = null;
		ObjectMapper objectMapper = new ObjectMapper();
		List<Reservation> findList = reservationService.findByRIdOrRStatus(
				readableId, reservStatus, pageNO);
		List<Map<String, Object>> reservationList = new ArrayList<Map<String, Object>>();
		Map<String, Object> map;
		for (Reservation data : findList) {
			map = new HashMap<String, Object>();
			map.put("readableId", data.getReadableId());
			map.put("reservDate", data.getReservationDate());
			map.put("reservTime", data.getReservationTimeSegment());
			map.put("requestorName", data.getRequestorName());
			map.put("reservKey", data.getReservationKey());
			map.put("reservStatus", data.getReservationStatus());
			reservationList.add(map);
		}
		try {
			json = objectMapper.writeValueAsString(reservationList);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		PrintWriter out = response.getWriter();
		System.out.println(json);
		out.print(json);
	}

	@RequestMapping(value = "submitReserv.do")
	public void submitReserv(String readableId) {
		Reservation reservation = reservationService
				.findByReadableId(readableId);
		reservation.setReservationStatus(ReservationStatus.SUBMITTED);
		reservationService.save(reservation);
	}

	@RequestMapping(value = "finishReserv.do")
	public void finishReserv(String readableId) {
		Reservation reservation = reservationService
				.findByReadableId(readableId);
		reservation.setReservationStatus(ReservationStatus.FINISHED);
		reservationService.save(reservation);
	}

	@RequestMapping(value = "enterReserv.do")
	public ModelAndView enterReserv(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("enterReserv");
		User u = (User) request.getSession().getAttribute(Constants.LOGIN_USER);
		mav.addObject("currUser", u);
		List<Workday> dayList = workdayService.retrieveDayList();
		List<String> dayStrList = new ArrayList<String>();
		List<WorkdayDisplay> dayLinkStrList = new ArrayList<WorkdayDisplay>();

		log.debug("dayList size is : " + dayList.size());
		if (dayList != null) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd E");
			for (Workday wd : dayList) {
				// 循环加入日期标头行数据
				dayStrList.add(sdf.format(wd.getDate()));
				log.debug("workday type: " + wd.getType());
				// 循环加入忙闲行数据
				WorkdayDisplay dis = new WorkdayDisplay();
				if (wd.getType().toString().equals("WORKDAY")) {
					Set<TimeSegment> segs = wd.getTimeSegments();
					int rsvdCnt = 0;
					for (TimeSegment seg : segs) {
						rsvdCnt += seg.getResvCount();
					}
					log.debug("workday: " + wd.getDate() + " rsv count: "
							+ rsvdCnt);
					if (rsvdCnt >= (Constants.WORKDAY_SEGMENT_COUNT * Constants.BACK_OFFICER_COUNT)) {
						dis.setStyle("fullworkday");
						dis.setLinkText("坐席满");
					} else {
						dis.setStyle("workday");
						dis.setLinkText("选择时间");
					}
				} else {
					dis.setStyle("nonworkday");
					dis.setLinkText("非工作日");
				}
				dayLinkStrList.add(dis);
			}
		}
		mav.addObject("dayTypeList", dayLinkStrList);
		mav.addObject("dayList", dayStrList);
		mav.addObject("title", "预约申请");
		return mav;
	}

	@RequestMapping(value = "checkSegment.do")
	public void checkSegment(String seq, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		
		Calendar endDate = Calendar.getInstance();
    	endDate.setTime(new Date());
    	endDate.add(Calendar.DAY_OF_MONTH, Integer.parseInt(seq));
    	Workday wkd = workdayService.findByDate(endDate.getTime());
        log.debug("get the workday !" + wkd.getDate());
        
		

	}
}
