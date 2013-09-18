package com.xiangyun.notary.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.xiangyun.notary.Constants;
import com.xiangyun.notary.common.ReservationStatus;
import com.xiangyun.notary.common.WorkdayDisplay;
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
	 */
	@RequestMapping(value = "/reserv_Query.do")
	public ModelAndView reservQuery(HttpServletRequest request) {
		User user = (User) request.getSession(false).getAttribute(
				Constants.LOGIN_USER);

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

		String readableId = request.getParameter("readable_id");
		if (StringUtils.isEmpty(readableId))
			readableId = null;

		ReservationStatus status = null;
		String statusStr = request.getParameter("status");
		if (!StringUtils.isEmpty(statusStr))
			status = ReservationStatus.valueOf(statusStr);

		Long userId = null;
		if (!user.isAdmin() && !user.isStaff()) {
			userId = user.getId();
		}

		Long reservationCount = reservationService.getReservationCount(
				readableId, status, userId);
		Long pageCount = (reservationCount - 1) / Constants.QUERY_PAGE_SIZE + 1;
		List<Reservation> reservations = reservationService.findReservations(
				readableId, status, userId, pageNum);
		ModelAndView mav = new ModelAndView("reserv_Query");
		mav.addObject("title", "预约查询");
		mav.addObject("pageCount", pageCount);
		mav.addObject("currPage", pageNum);
		mav.addObject("loopBegin", ((pageNum - 1) / 5) * 5 + 1);
		mav.addObject(
				"loopEnd",
				(((pageNum - 1) / 5) * 5 + 5 < pageCount) ? ((pageNum - 1) / 5) * 5 + 5
						: pageCount);
		mav.addObject("left", (((pageNum - 1) / 5) * 5 - 4));
		mav.addObject("right", (((pageNum - 1) / 5) * 5 + 6));
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
		Workday workday = workdayService.findByDate(reservation
				.getReservationDate());
		Set<TimeSegment> timeSegments = workday.getTimeSegments();
		for (TimeSegment timeSegment : timeSegments) {
			if (timeSegment.getStartTime().equals(
					reservation.getReservationTimeSegment())) {
				timeSegment.setResvCount(timeSegment.getResvCount() - 1);
				timeSegmentsService.save(timeSegment);
			}
		}
		this.sendCancleMSG(reservation);
		PrintWriter out = response.getWriter();
		out.print(true);
	}

	/**
	 * 完成预约
	 * 
	 * @param readableId
	 * @param response
	 * @throws IOException
	 */
	@RequestMapping(value = "finishReserv.do")
	public void finishReserv(String readableId, HttpServletResponse response)
			throws IOException {
		Reservation reservation = reservationService
				.findByReadableId(readableId);
		reservation.setReservationStatus(ReservationStatus.FINISHED);
		reservationService.save(reservation);
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
		SMSManager
				.sendSMS(
						new String[] { reservation.getRequestorMobile() },
						"尊敬的" + reservation.getRequestorName()
								+ "，您在长宁公证处的网上预约已经取消，预约号为"
								+ reservation.getReservationKey()
								+ "，谢谢使用长宁网上公证业务！", 1);
		try {
			System.out.println("Available SMS: "
					+ Math.floor(SMSManager.checkBalance()));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.err.println("ended!");
	}

	@RequestMapping(value = "enterReserv.do")
	public ModelAndView enterReserv(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("reserv_entry");
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
	public void checkSegment(String sequence, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		log.debug("sequence: " + sequence);
		Calendar endDate = Calendar.getInstance();
		endDate.setTime(new Date());
		endDate.add(Calendar.DAY_OF_MONTH, Integer.parseInt(sequence) + 1);
		log.debug("now is : " + endDate.getTime());
		int day = endDate.get(Calendar.DAY_OF_MONTH);
		int month = endDate.get(Calendar.MONTH) + 1;
		int year = endDate.get(Calendar.YEAR);
		Workday wkd = workdayService.findByDay(year, month, day);
		log.debug("get the workday !" + wkd.getDate());

	}
}
