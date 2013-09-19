package com.xiangyun.notary.service;

import com.xiangyun.notary.domain.TimeSegment;
import com.xiangyun.notary.domain.Workday;

public interface TimeSegmentsService {
	
	public TimeSegment find(int workdayId,String startTime);
	
	public void save(TimeSegment timeSegment);

	TimeSegment find(Workday workday, String startTime);

}
