package com.xiangyun.notary.service;

import com.xiangyun.notary.domain.TimeSegment;

public interface TimeSegmentsService {
	
	public TimeSegment find(int workdayId,String startTime);
	
	public void save(TimeSegment timeSegment);

}
