package com.adtec.daily.service.demand;

import com.adtec.daily.bean.demand.DemandDetail;

import java.util.List;

public interface DemandDetailService {

    /**
     * 查询所有项目信息
     */
    List<DemandDetail> getDemandDetail(DemandDetail demandDetail);
}
