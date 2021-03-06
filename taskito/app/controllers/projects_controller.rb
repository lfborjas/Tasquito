class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @projects = current_user.projects.all()
  end
  
  def show
    @project = Project.find(params[:id])
    @tasq = @project.tasqs.new
  end
  
  def new
    @project = Project.new
  end
  
  def create
    
    @project = Project.new(params[:project])
    
  
    
    if @project.save
      @userproject = UserProject.new()
      @userproject.project_id = @project.id
      @userproject.user_id = current_user.id
      @userproject.save()
      
      flash[:notice] = "Successfully created project."
      redirect_to @project
    else
      render :action => 'new'
    end
  end
  
  def edit
    @project = Project.find(params[:id])
  end
  
  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      flash[:notice] = "Successfully updated project."
      redirect_to @project
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    flash[:notice] = "Successfully destroyed project."
    redirect_to projects_url
  end
end
