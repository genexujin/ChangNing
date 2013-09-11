package com.xiangyun.notary.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.xiangyun.notary.Constants;
import com.xiangyun.notary.common.ReservationStatus;
import com.xiangyun.notary.domain.Reservation;
import com.xiangyun.notary.domain.User;
import com.xiangyun.notary.domain.Workday;
import com.xiangyun.notary.service.ReservationService;

@Controller
public class ReservationController {
	
	@Autowired
	private ReservationService reservationService;
	
	@RequestMapping(value="/enterReservQuery.do")
	public ModelAndView enterReservQuery(){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("reserv_query");
		return mav;
	}
	
	@RequestMapping(value="customQuery.do")
	public void customQuery(HttpServletResponse response,String readableId) throws IOException{
		String json = null;
		ObjectMapper objectMapper = new ObjectMapper();
		Reservation reservation = reservationService.findByReadableId(readableId);
		Map<String, Object> map=new HashMap<String, Object>();
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
	
	@RequestMapping(value="cancleReserv.do")
	public void cancleReserv(String readableId){
		Reservation reservation = reservationService.findByReadableId(readableId);
		reservation.setReservationStatus(ReservationStatus.CANCELLED);
		reservationService.save(reservation);
	}
	
	@RequestMapping(value="workerQuery.do")
	public void workerQuery(HttpServletResponse response,String readableId,ReservationStatus reservStatus,int pageNO) throws IOException{
		String json = null;
		ObjectMapper objectMapper = new ObjectMapper();
		List<Reservation> findList = reservationService.findByRIdOrRStatus(readableId,reservStatus,pageNO);
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
	
	@RequestMapping(value="submitReserv.do")
	public void submitReserv(String readableId){
		Reservation reservation = reservationService.findByReadableId(readableId);
		reservation.setReservationStatus(ReservationStatus.SUBMITTED);
		reservationService.save(reservation);
	}
	
	@RequestMapping(value="finishReserv.do")
	public void finishReserv(String readableId){
		Reservation reservation = reservationService.findByReadableId(readableId);
		reservation.setReservationStatus(ReservationStatus.FINISHED);
		reservationService.save(reservation);
	}
	
	@RequestMapping(value="enterReserv.do")
	public ModelAndView enterReserv(HttpServletRequest request){
		ModelAndView mav = new ModelAndView("enterReserv");
		User u = (User)request.getSession().getAttribute(Constants.LOGIN_USER);
		mav.addObject("currUser", u);
    	mav.addObject("title", "预约申请");
    	return mav;
	}
}
