package com.ync365.oa.repository;


import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.ync365.oa.entity.LeaderAssessment;

public interface LeaderAssessmentDao extends PagingAndSortingRepository<LeaderAssessment, Long>, JpaSpecificationExecutor<LeaderAssessment> {
}
