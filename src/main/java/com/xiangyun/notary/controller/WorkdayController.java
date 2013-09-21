package com.xiangyun.notary.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.taglibs.standard.tag.common.fmt.FormatDateSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.xiangyun.notary.common.WorkdayType;
import com.xiangyun.notary.domain.Workday;
import com.xiangyun.notary.service.WorkdayService;

@Controller
public class WorkdayController {

	@Autowired
	private WorkdayService workdayService;

	@RequestMapping(value = "/enterWorkdaySetting.do")
	public ModelAndView workdaySetting() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("workdaysetting");
		return mav;
	}

	@RequestMapping(value = "/saveWorkday.do")
	public ModelAndView saveWorkday(HttpServletRequest request,
			HttpServletResponse response, Workday workday) {
		ModelAndView mav = new ModelAndView();
		Workday w = workdayService.findByDate(workday.getDate());
		if (w == null) {
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(workday.getDate());
			workday.setYear(calendar.get(Calendar.YEAR));
			workday.setMonth(calendar.get(Calendar.MONTH) + 1);
			workday.setDay(calendar.get(Calendar.DAY_OF_MONTH));
			workday.setBatch("N");
			workdayService.save(workday);
		} else {
			w.setType(workday.getType());
			w.setDescription(workday.getDescription());
			w.setBatch("N");
			workdayService.save(w);
		}
		mav.setViewName("workdaysetting");
		return mav;
	}

	@RequestMapping(value = "/getWorkdayList.do")
	public void getWorkdayList(int year, int month, int pageNO,
			HttpServletResponse response) throws IOException {
		String json = null;
		ObjectMapper objectMapper = new ObjectMapper();
		List<Workday> findList = workdayService.findByYear(year, month, pageNO);
		List<Map<String, Object>> workdayList = new ArrayList<Map<String, Object>>();
		Map<String, Object> map;
		for (Workday data : findList) {
			map = new HashMap<String, Object>();
			map.put("id", data.getId());
			map.put("date", data.getDate());
			map.put("description", data.getDescription());
			map.put("type", data.getType());
			workdayList.add(map);
		}
		try {
			json = objectMapper.writeValueAsString(workdayList);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		PrintWriter out = response.getWriter();
		System.out.println(json);
		out.print(json);

	}

	@RequestMapping(value = "/setOneYear.do")
	public void setOneYear() {
		Calendar date = Calendar.getInstance();
		// Create workday for a year
		for (int i = 0; i < 365; i++) {
			Workday day = new Workday();
			day.setDate(date.getTime());
			day.setYear(date.get(Calendar.YEAR));
			day.setMonth(date.get(Calendar.MONTH) + 1);
			day.setDay(date.get(Calendar.DAY_OF_MONTH));

			if (date.get(Calendar.DAY_OF_WEEK) != Calendar.SUNDAY
					&& date.get(Calendar.DAY_OF_WEEK) != Calendar.SATURDAY) {

				day.setType(WorkdayType.WORKDAY);
			} else {
				day.setType(WorkdayType.NON_WORKDAY);
			}

			workdayService.saveByDate(day);
			date.add(Calendar.DATE, 1);
		}

	}

	@SuppressWarnings("null")
	@RequestMapping(value = "/setYear/{year}.do")
	public void setYear(@PathVariable("year") int year,HttpServletResponse response) throws IOException {
		List<Workday> workdays = workdayService.findYear(year);
		int msg =0;
		if (workdays.size() == 0) {
			Calendar date = Calendar.getInstance();
			date.set(Calendar.DAY_OF_MONTH, 1);
			date.set(Calendar.MONDAY, 0);
			date.set(Calendar.YEAR, year);
			for (int i = 0; i < 365; i++) {
				Workday day = new Workday();
				day.setDate(date.getTime());
				day.setYear(date.get(Calendar.YEAR));
				day.setMonth(date.get(Calendar.MONTH) + 1);
				day.setDay(date.get(Calendar.DAY_OF_MONTH));
				if (date.get(Calendar.DAY_OF_WEEK) != Calendar.SUNDAY
						&& date.get(Calendar.DAY_OF_WEEK) != Calendar.SATURDAY) {
					day.setType(WorkdayType.WORKDAY);
				} else {
					day.setType(WorkdayType.NON_WORKDAY);
				}
				day.setBatch("Y");
				workdayService.save(day);
				date.add(Calendar.DATE, 1);
			}
			msg=1;
		}
		PrintWriter out = response.getWriter();
		out.print(msg);
	}
}
