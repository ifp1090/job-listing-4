class JobsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  before_filter :validate_search_key, :only => [:search]

  def index
    @jobs = case params[:order]
            when 'by_lower_bound'
              Job.publish.order('wage_lower_bound').paginate(:page => params[:page], :per_page => 15)
            when 'by_upper_bound'
              Job.publish.order('wage_upper_bound').paginate(:page => params[:page], :per_page => 15)
            else
              Job.publish.recent.paginate(:page => params[:page], :per_page => 15)
            end
  end

  def new
    @job = Job.new
  end

  def show
    @job = Job.find(params[:id])

    if @job.is_hidden
      flash[:warning] = "This Job already archieved"
      redirect_to root_path
    end
  end

  def edit
    @job = Job.find(params[:id])
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      redirect_to jobs_path
    else
      render :new
    end
  end

  def update
    @job = Job.find(params[:id])
    if @job.update(job_params)
      redirect_to jobs_path, notice: "Update success"
    else
      render :edit
    end
  end

  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    redirect_to jobs_path, alert: "Job deleted"
  end

  def search
    if @query_string.present?
      search_result = Job.ransack(@search_criteria).result(:distinct => true)
      @jobs = search_result.paginate(:page => params[:page], :per_page => 20 )
      puts @jobs
    else
      @jobs = Job.publish.recent.paginate(:page => params[:page], :per_page => 15)
      puts @jobs
    end
  end

  private

  def validate_search_key
    @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
    @search_criteria = search_criteria(@query_string)
  end

  def search_criteria(query_string)
    { :title_or_description_or_contact_email_or_location_or_company_name_or_category_name_cont => query_string }
  end

  def job_params
    params.require(:job).permit(:title, :description, :wage_upper_bound, :wage_lower_bound, :contact_email)
  end
end
