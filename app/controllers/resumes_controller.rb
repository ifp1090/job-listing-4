class ResumesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_is_not_admin 

  def new
    @job = Job.find(params[:job_id])
    @resume = Resume.new
  end

  def create
    @job = Job.find(params[:job_id])
    @resume = Resume.new(resume_params)
    @resume.job = @job
    @resume.user = current_user

    if @resume.save
      current_user.join!(@job)
      flash[:notice] = "成功提交简历，再多投几份简历有助于提高面试机会哦！"
      redirect_to jobs_path(@job)
    else
      render :new
    end
  end

  private

  def resume_params
    params.require(:resume).permit(:content, :attachment)
  end
end
