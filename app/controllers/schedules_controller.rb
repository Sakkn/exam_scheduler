require 'json'
require "date"

class SchedulesController < ApplicationController

  def new
    @firstName = params[:firstName]
    @lastName = params[:lastName]
    @phoneNumber = params[:phoneNumber]
    @college_Id = params[:college_Id]
    @exam_id = params[:exam_id]
    @start_time = params[:start_time]

    @userObject = self.create_user_object(@firstName, @lastName, @phoneNumber)
    if (@userObject == nil)
      @message = "User had invalid values."
      render json: self.create_failure_response(@message).to_json
      return
    end

    if !User.exists?(firstName: @userObject.firstName, lastName: @userObject.lastName)
      Rails.logger.debug("User does not exist, creating user.")
      @userObject.save
    end

    if @college_Id == nil || !College.exists?(id: @college_Id)
      @message = "College does not exist. Exam not scheduled."
      Rails.logger.debug(@message)
      render json: self.create_failure_response(@message).to_json
      return
    end
    
    if (@exam_id == nil)
      @message = "Exam ID is invalid. Exam not scheduled."
      Rails.logger.debug(@message)
      render json: self.create_failure_response(@message).to_json
      return
    end

    @foundExam = Exam.where(id: @exam_id).first
    if (@foundExam == nil || @foundExam.college_id != @college_Id)
      @message = 'Exam: %{examId} does not exist in College: %{collegeId}. Exam not scheduled.' % { examId: @exam_id, collegeId: @college_Id }
      Rails.logger.debug(@message)
      render json: create_failure_response(@message).to_json
      return
    end

    if (@start_time == nil)
      @message = "Exam Start Time is invalid. Exam not scheduled."
      Rails.logger.debug(@message)
      render json: self.create_failure_response(@message).to_json
      return
    end

    @convertedDatetime = DateTime.parse(@start_time)
    if !@convertedDatetime.between?(@foundExam.start, @foundExam.stop)
      @message = "Requested Exam start time does not fall in between Exam time window. Exam not scheduled."
      Rails.logger.debug(@message)
      render json: self.create_failure_response(@message).to_json
      return
    end

    @userObject.exam_id = @exam_id
    @userObject.save

    @responsePayload = self.create_success_response(@exam_id, @firstName, @lastName, @start_time).to_json
    render json: @responsePayload, status: :created
  end


  # Helper Methods:

  def create_user_object(firstName, lastName, phoneNumber)
    if (firstName == nil || lastName == nil)
       Rails.logger.error("New schedule post encountered an error: user does not have first/last name.")
       return nil
    end

    @phoneNumber = nil
    if phoneNumber.match('\A(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}\z')
      @phoneNumber = phoneNumber
    end

    @user = User.new
    @user.firstName = firstName
    @user.lastName = lastName
    @user.phoneNumber = @phoneNumber

    return @user
  end

  def create_failure_response(message)
    { "status" => "400 Bad Request", "message" => message }
  end

  def create_success_response(exam_id, firstName, lastName, date)
    @responseMessage = 'Exam %{examId} scheduled for %{firstName} %{lastName} on %{date}' % { examId: exam_id, firstName: firstName, lastName: lastName, date: date }
    { "status" => "200", "message" => @responseMessage }
  end

end
