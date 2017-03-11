class StepTasksController < ApplicationController
  before_action :set_step_task, only: [:show, :update, :destroy]

  # GET /step_tasks
  # GET /step_tasks.json
  def index
    @step_tasks = StepTask.all
  end

  # GET /step/1/tasks/1 [+ param]
  # GET /step/1/tasks.json [+ param]
  def show
    match_requirements = {}

    if step_task_params['step_id']
      match_requirements[:step_id] = step_task_params['step_id']
    end

    if step_task_params['task_id']
      match_requirements[:task_id] = step_task_params['task_id']
    end

    render json: StepTask.where(match_requirements)
  end

  # POST /step/1/tasks + params
  # POST /step/1/tasks.json + params
  def create
    @step_task = StepTask.new(step_task_params)

    if @step_task.save
      render status: :created, json: @step_task
    else
      render json: @step_task.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /step/1/tasks/1 + params
  # PATCH/PUT /step/1/tasks/1.json + params
  def update
    if @step_task.update(step_task_params)
      render :show, status: :ok, location: @step_task
    else
      render json: @step_task.errors, status: :unprocessable_entity
    end
  end

  # DELETE /step_tasks/1
  # DELETE /step_tasks/1.json
  def destroy
    @step_task.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_step_task
      # @step_task = StepTask.find(params[:id])
      @step_task = params[:id] ?
        StepTask.find(params[:id]) :
        StepTask.where(
          step_id: step_task_params['step_id'],
          task_id: step_task_params['task_id'],
        ).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def step_task_params
      params.permit(:step_id, :task_id)
    end
end
