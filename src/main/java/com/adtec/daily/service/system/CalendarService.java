package com.adtec.daily.service.system;

import com.adtec.daily.bean.system.TCalendar;

/**
 * @version V1.0
 * @Description: 万年历
 */
public interface CalendarService {

    /**
     * 新增
     */
    void saveCalendar(TCalendar calendar) throws Exception;
}
