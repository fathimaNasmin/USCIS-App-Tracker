//
//  CaseAPIModel+Mapper.swift
//  USCISAppTracker
//
//  Created by Fathima Nasmin on 2/17/25.
//

extension CaseAPIModel {
	var domainModel: Case {
		return Case(
			receiptNo: case_status.receiptNumber,
			formType: case_status.formType,
			submittedDate: case_status.submitDate,
			lastUpdated: case_status.modifyDate,
			statusText: case_status.current_case_status_text_en,
			statusDescription: case_status.current_case_status_desc_en,
			status: case_status.current_case_status_text_en.convertToCaseStatus, history: case_status.hist_case_status?.compactMap { $0.history} ?? [])
	}
}



