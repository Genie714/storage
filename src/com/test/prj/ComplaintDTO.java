package com.test.prj;

public class ComplaintDTO
{
	// Complaint 테이블
	private String id;
	private String complainter_user_id;
	private String complaintee_user_id;
	private String reason_id;
	private String treatment_id;
	private String contents;
	private String complaint_date;
	private String treatment_reason;
	private String completion_date;

	// COMPLAINTLISTVIEW 추가 사항
	private String reason;
	private String complaint_contents;
	private String treatment;

	// getter/setter 구성
	public String getId()
	{
		return id;
	}

	public void setId(String id)
	{
		this.id = id;
	}

	public String getComplainter_user_id()
	{
		return complainter_user_id;
	}

	public void setComplainter_user_id(String complainter_user_id)
	{
		this.complainter_user_id = complainter_user_id;
	}

	public String getComplaintee_user_id()
	{
		return complaintee_user_id;
	}

	public void setComplaintee_user_id(String complaintee_user_id)
	{
		this.complaintee_user_id = complaintee_user_id;
	}

	public String getReason_id()
	{
		return reason_id;
	}

	public void setReason_id(String reason_id)
	{
		this.reason_id = reason_id;
	}

	public String getTreatment_id()
	{
		return treatment_id;
	}

	public void setTreatment_id(String treatment_id)
	{
		this.treatment_id = treatment_id;
	}

	public String getContents()
	{
		return contents;
	}

	public void setContents(String contents)
	{
		this.contents = contents;
	}

	public String getComplaint_date()
	{
		return complaint_date;
	}

	public void setComplaint_date(String complaint_date)
	{
		this.complaint_date = complaint_date;
	}

	public String getTreatment_reason()
	{
		return treatment_reason;
	}

	public void setTreatment_reason(String treatment_reason)
	{
		this.treatment_reason = treatment_reason;
	}

	public String getCompletion_date()
	{
		return completion_date;
	}

	public void setCompletion_date(String completion_date)
	{
		this.completion_date = completion_date;
	}

	public String getReason()
	{
		return reason;
	}

	public void setReason(String reason)
	{
		this.reason = reason;
	}

	public String getComplaint_contents()
	{
		return complaint_contents;
	}

	public void setComplaint_contents(String complaint_contents)
	{
		this.complaint_contents = complaint_contents;
	}

	public String getTreatment()
	{
		return treatment;
	}

	public void setTreatment(String treatment)
	{
		this.treatment = treatment;
	}

}
