class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :update_status]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = current_user.tasks.order(:completed, :deadline).all
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    if @task.user != current_user
      redirect_to tasks_url
    end
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task.user = current_user
    
    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: "#{@task.taskname} was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: "#{@task.taskname} was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    taskname = @task.taskname
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "#{taskname} was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def update_status
    @task.completed = !@task.completed
    @task.save
    respond_to do |format|
      if @task.completed 
        format.html { redirect_to tasks_url, notice: @task.taskname + ' has been completed.' }
      else
        format.html { redirect_to tasks_url, notice: "You have restarted #{@task.taskname}." }
      end
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:taskname, :deadline, :importance, :category, :user_id, :description)
    end
end
