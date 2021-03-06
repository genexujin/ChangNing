package com.xiangyun.notary.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.xiangyun.notary.Constants;
import com.xiangyun.notary.common.ReservationStatus;
import com.xiangyun.notary.common.WorkdayDisplay;
import com.xiangyun.notary.domain.ReservSlot;
import com.xiangyun.notary.domain.Reservation;
import com.xiangyun.notary.domain.TimeSegment;
import com.xiangyun.notary.domain.User;
import com.xiangyun.notary.domain.Workday;
import com.xiangyun.notary.service.ReservationService;
import com.xiangyun.notary.service.TimeSegmentsService;
import com.xiangyun.notary.service.WorkdayService;
import com.xiangyun.sms.SMSManager;

@Controller
public class ReservationController {

	private static Logger log = LoggerFactory
			.getLogger(ReservationController.class);

	@Autowired
	private ReservationService reservationService;


	@Autowired
	private WorkdayService workdayService;

	@Autowired
	private TimeSegmentsService timeSegmentsService;

	/**
	 * 预约查询列表
	 * 
	 * @param request
	 * @return
	 * @throws ParseException
	 */
	@RequestMapping(value = "/reserv_Query.do")
	public ModelAndView reservQuery(HttpServletRequest request) {
		User user = (User) request.getSession(false).getAttribute(
				Constants.LOGIN_USER);
		ModelAndView mav = new ModelAndView("reserv_Query");
		HttpSession session = request.getSession(false);

		int pageNum;
		String pageNumStr = request.getParameter("pn");
		if (StringUtils.isEmpty(pageNumStr)) {
			pageNum = 1;
		} else {
			try {
				pageNum = Integer.parseInt(pageNumStr);
			} catch (NumberFormatException e) {
				pageNum = 1;
			}
		}

		// prepare reserve id param
		String readableId = request.getParameter("readable_id");
		if (readableId == null)
			readableId = (String) session
					.getAttribute("reserv_query_readable_id");
		else
			session.setAttribute("reserv_query_readable_id", readableId);
		mav.addObject("reserv_query_readable_id", readableId);
	

		// prepare requester param
		String requestorName = request.getParameter("requestor_name");
		if (requestorName == null)
			requestorName = (String) session
					.getAttribute("reserv_query_requestorName");
		else
			session.setAttribute("reserv_query_requestorName", requestorName);
		mav.addObject("reserv_query_requestorName", requestorName);

		// prepare startDate param
		DateFormat format = new SimpleDateFormat("MM/dd/yyyy");
		Date startDate = null;
		String startDatestr = request.getParameter("startDate");
		if (startDatestr != null) {
			if (!StringUtils.isEmpty(startDatestr)) {
				log.debug("startDatestr length: " + startDatestr.length() );
				log.debug("startDatestr: " + startDatestr);
				try {
					startDate = format.parse(startDatestr);
					session.setAttribute("reserv_query_startDate", startDate);
				} catch (ParseException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
			} else {
				session.setAttribute("reserv_query_startDate", null);
				startDate = null;
			}
		} else {
			startDate = (Date) session.getAttribute("reserv_query_startDate");
		}
		mav.addObject("reserv_query_startDate", startDatestr);

		// prepare endDate param
		Date endDate = null;
		String endDatestr = request.getParameter("endDate");
		if (endDatestr != null) {
			log.debug("startDatestr length: " + endDatestr.length() );
			log.debug("startDatestr: " + endDatestr);
			if (!StringUtils.isEmpty(endDatestr)) {
				try {
					endDate = format.parse(endDatestr);
					session.setAttribute("reserv_query_endDate", endDate);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			} else {
				session.setAttribute("reserv_query_endDate", null);
				endDate = null;
			}
		} else {
			endDate = (Date) session.getAttribute("reserv_query_endDate");
		}
		mav.addObject("reserv_query_endDate", endDatestr);

		// prepare status param
		ReservationStatus status = null;
		String statusStr = request.getParameter("status");
		if (statusStr != null) {
			log.debug("statusStr:  " +statusStr.length() );
			if (!StringUtils.isEmpty(statusStr)) {
				status = ReservationStatus.valueOf(statusStr);
				session.setAttribute("reserv_query_status", status);
			} else {
				session.setAttribute("reserv_query_status", null);
				status = null;
			}
		} else {
			status = (ReservationStatus) session
					.getAttribute("reserv_query_status");
		}
		mav.addObject("reserv_query_status", statusStr);

		Long userId = null;
		if (!user.isAdmin() && !user.isStaff()) {
			userId = user.getId();
		}

		Long reservationCount = reservationService.getReservationCount(
				readableId, requestorName, startDate, endDate, status, userId);
		Long pageCount = (reservationCount - 1) / Constants.QUERY_PAGE_SIZE + 1;
		List<Reservation> reservations = reservationService.findReservations(
				readableId, requestorName, startDate, endDate, status, userId,
				pageNum);
		
		mav.addObject("title", "预约查询");
		mav.addObject("pageCount", pageCount);
		mav.addObject("loopBegin", ((pageNum - 1) / Constants.PAGING_BAR_SIZE)
				* Constants.PAGING_BAR_SIZE + 1);
		mav.addObject(
				"loopEnd",
				(((pageNum - 1) / Constants.PAGING_BAR_SIZE)
						* Constants.PAGING_BAR_SIZE + Constants.PAGING_BAR_SIZE < pageCount) ? ((pageNum - 1) / Constants.PAGING_BAR_SIZE)
						* Constants.PAGING_BAR_SIZE + Constants.PAGING_BAR_SIZE
						: pageCount);
		mav.addObject("left", (((pageNum - 1) / Constants.PAGING_BAR_SIZE)
				* Constants.PAGING_BAR_SIZE - Constants.PAGING_BAR_SIZE - 1));
		mav.addObject("right", (((pageNum - 1) / Constants.PAGING_BAR_SIZE)
				* Constants.PAGING_BAR_SIZE + Constants.PAGING_BAR_SIZE + 1));
		mav.addObject("reservations", reservations);
		
		
	
		
		return mav;
	}
	
	

	/**
	 * 取消预约
	 * 
	 * @param readableId
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value = "cancleReserv.do")
	public void cancleReserv(String readableId, HttpServletResponse response)
			throws IOException {
		Reservation reservation = reservationService
				.findByReadableId(readableId);
		reservation.setReservationStatus(ReservationStatus.CANCELLED);
		reservationService.save(reservation);
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String dateString = format.format(reservation.getReservationDate());
		SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM-dd");
		try {
			Date datetimeDate  = format2.parse(dateString);
			Workday workday = workdayService.findByDate(datetimeDate);
			Set<TimeSegment> timeSegments = workday.getTimeSegments();
			for (TimeSegment timeSegment : timeSegments) {
				if (timeSegment.getStartTime().equals(
						reservation.getReservationTimeSegment())
						&& timeSegment.getResvCount() > 0) {
					timeSegment.setResvCount(timeSegment.getResvCount() - 1);
					timeSegmentsService.save(timeSegment);
				}
			}
			this.sendCancleMSG(reservation);
			PrintWriter out = response.getWriter();
			out.print(true);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * 完成预约
	 * 
	 * @param readableId
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value = "finishReserv.do")
	public void finishReserv(String readableId, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		Reservation reservation = reservationService
				.findByReadableId(readableId);
		reservation.setReservationStatus(ReservationStatus.FINISHED);
		User u = (User) request.getSession().getAttribute(Constants.LOGIN_USER);
		reservation.setAccepter(u);
		reservationService.save(reservation);

		SMSManager.sendSMS(
				new String[] { reservation.getRequestorMobile() },
				"您在长宁公证处的网上预约已经受理完成，预约号为："
						+ reservation.getReadableId() + "", 1);

		PrintWriter out = response.getWriter();
		out.print(true);
	}

	/**
	 * 取消后发送短信通知给客户
	 * 
	 * @param reservation
	 */
	@RequestMapping(value = "sendCancleMSG.do")
	public void sendCancleMSG(Reservation reservation) {
		SMSManager.sendSMS(
				new String[] { reservation.getRequestorMobile() },
				"尊敬的" + reservation.getRequestorName()
						+ "，您在长宁公证处的网上预约已经取消，预约号为："
						+ reservation.getReadableId() + "，谢谢使用长宁网上公证业务！", 1);
		
		System.err.println("ended!");
	}

	/**
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "enterReserv.do")
	public ModelAndView enterReserv(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("reserv_entry");
		User u = (User) request.getSession().getAttribute(Constants.LOGIN_USER);
		mav.addObject("currUser", u);
		List<Workday> dayList = workdayService.retrieveDayList();
		List<String> dayStrList = new ArrayList<String>();
		List<WorkdayDisplay> dayLinkStrList = new ArrayList<WorkdayDisplay>();
		
		//load all defined slots
		List<ReservSlot> slots = reservationService.findAllSlots();
		int segmentCount = slots.size();
		List<ReservSlot> amslots =  new ArrayList<ReservSlot>();
		List<ReservSlot> pmslots=  new ArrayList<ReservSlot>();
		for(ReservSlot slot: slots){
			if(slot.getAm().equalsIgnoreCase("Y"))
				amslots.add(slot);
			else
				pmslots.add(slot);
		}		
		mav.addObject("amslots", amslots);
		mav.addObject("pmslots", pmslots);
		mav.addObject("amSize", amslots.size());
		mav.addObject("pmSize", pmslots.size());

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
					if (rsvdCnt >= (segmentCount * Constants.BACK_OFFICER_COUNT)) {
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
		mav.addObject("limit", Constants.BACK_OFFICER_COUNT);
		return mav;
	}

	/**
	 * 
	 * @param sequence
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value = "checkSegment.do")
	public void checkSegment(String sequence, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		log.debug("sequence: " + sequence);
		Calendar endDate = Calendar.getInstance();
		endDate.setTime(new Date());
		endDate.add(Calendar.DAY_OF_MONTH, Integer.parseInt(sequence));
		log.debug("now is : " + endDate.getTime());
		int day = endDate.get(Calendar.DAY_OF_MONTH);
		int month = endDate.get(Calendar.MONTH) + 1;
		int year = endDate.get(Calendar.YEAR);
		Workday wkd = workdayService.findByDay(year, month, day);
		log.debug("get the workday !" + wkd.getDate());

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd E");
		Set<TimeSegment> segments = wkd.getTimeSegments();

		ObjectMapper mapper = new ObjectMapper();
		mapper.writeValue(response.getOutputStream(), wkd);
	}

	/**
	 * 
	 * @param title
	 * @param name
	 * @param mobile
	 * @param sequence
	 * @param startTime
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value = "makeReserv.do")
	public void makeReservation(String title, String name, String mobile,
			String sequence, String startTime, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		log.debug("start to make reservation ");
		
		Calendar endDate = Calendar.getInstance();
		endDate.setTime(new Date());
		endDate.add(Calendar.DAY_OF_MONTH, Integer.parseInt(sequence));
		log.debug("target day is : " + endDate.getTime());

		// check availability
		// get the workday
		int day = endDate.get(Calendar.DAY_OF_MONTH);
		int month = endDate.get(Calendar.MONTH) + 1;
		int year = endDate.get(Calendar.YEAR);
		Workday wkd = workdayService.findByDay(year, month, day);

		User u = (User) request.getSession().getAttribute(Constants.LOGIN_USER);

		// query segments
		TimeSegment theSeg = timeSegmentsService.find(wkd, startTime);
		
		//get user from session
		User user = (User) request.getSession().getAttribute(
				Constants.LOGIN_USER);

		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		if (user.isAdmin()||user.isStaff()||reservationService.checkCompliance(u)) {

			if (theSeg != null
					&& theSeg.getResvCount() >= Constants.BACK_OFFICER_COUNT) {
				// return reservation failed

				out.write("{\"sequence\": \"" + sequence + "\",");
				out.write("\"success\": \"0\"}");

				return;
			} else {
				// make reservation
				// new segment
				if (theSeg == null) {
					theSeg = new TimeSegment();
					theSeg.setDuration(30);
					theSeg.setResvCount(1);
					theSeg.setStartTime(startTime);
					theSeg.setWorkDay(wkd);
					if (wkd.getTimeSegments() == null)
						wkd.setTimeSegments(new HashSet<TimeSegment>());
					wkd.getTimeSegments().add(theSeg);
				} else {
					int count = theSeg.getResvCount();
					count++;
					theSeg.setResvCount(count);
				}
				timeSegmentsService.save(theSeg);

				// new reservation
				Reservation rsv = new Reservation();
				rsv.setRequestorMobile(mobile);
				rsv.setRequestorName(name);
				rsv.setReservationDate(endDate.getTime());
				rsv.setReservationStatus(ReservationStatus.SUBMITTED);
				rsv.setReservationTimeSegment(startTime);
				rsv.setReservationKey(title);
				rsv.setCreationDate(new Date());
				rsv.setUser(u);

				reservationService.save(rsv);

				SMSManager.sendSMS(new String[] { mobile },
						"尊敬的" + name + " 先生/女士" + "，您在长宁公证处的网上预约已经成功，预约号为："
								+ rsv.getReadableId() + "，谢谢使用长宁网上公证业务！", 1);

				// try {
				// System.out.println("Available SMS: "
				// + Math.floor(SMSManager.checkBalance()));
				// } catch (Exception e) {
				// // TODO Auto-generated catch block
				// e.printStackTrace();
				// }

				out.write("{\"sequence\": \"" + sequence + "\",");
				out.write("\"success\": \"1\"}");

				return;
			}
		} else {
			out.write("{\"sequence\": \"" + sequence + "\",");
			out.write("\"success\": \"2\"}");
		}
	}
	
	@RequestMapping(value = "enterSlots.do")
	public ModelAndView enterSlots(HttpServletRequest request) throws IOException {
		//check permission, only admin
		User user = (User) request.getSession().getAttribute(
				Constants.LOGIN_USER);
		if(!user.isAdmin()) return null;
		//get all slots
		ModelAndView mav = new ModelAndView("reserv_slots");
		List<ReservSlot> slots = reservationService.findAllSlots();
		List<ReservSlot> amslots =  new ArrayList<ReservSlot>();
		List<ReservSlot> pmslots=  new ArrayList<ReservSlot>();
		for(ReservSlot slot: slots){
			if(slot.getAm().equalsIgnoreCase("Y"))
				amslots.add(slot);
			else
				pmslots.add(slot);
		}
		
		mav.addObject("amslots", amslots);
		mav.addObject("pmslots", pmslots);
		mav.addObject("title", "预约时间段定义");
		//go to page
		return mav;
	}
	
	@RequestMapping(value = "saveSlot.do")
	public ModelAndView saveSlot(String amKey, String slotTag, HttpServletRequest request) throws IOException {
		//check permission, only admin
		User user = (User) request.getSession().getAttribute(
				Constants.LOGIN_USER);
		if(!user.isAdmin()) return null;
		ReservSlot slot = new ReservSlot();
		slot.setAm(amKey);
		slot.setTag(slotTag);
		log.debug("Start to save a slot : AM:" + amKey +" Tag: " + slotTag);
		//save the slot
		reservationService.saveSlot(slot);	
		
		//go to page
		return enterSlots(request);
	}
	
	@RequestMapping(value = "cleanSlots.do")
	public ModelAndView cleanSlots(HttpServletRequest request) throws IOException {
		//check permission, only admin
		User user = (User) request.getSession().getAttribute(
				Constants.LOGIN_USER);
		if(!user.isAdmin()) return null;
		
		log.debug("Start to clean all slots!");
		//save the slot
		reservationService.deleteAllSlots();			
		//go to page
		return enterSlots(request);
	}
}
