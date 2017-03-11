class WorkflowStepsController < ApplicationController
  before_action :set_workflow_step, only: [:show, :update, :destroy]

  # GET /workflow_steps
  # GET /workflow_steps.json
  def index
    @workflow_steps = WorkflowStep.all
  end

  # GET /workflow/1/steps [+ param]
  # GET /workflow/1/steps.json [+ param]
  def show
    match_requirements = {}

    if workflow_step_params['workflow_id']
      match_requirements[:workflow_id] = workflow_step_params['workflow_id']
    end

    if workflow_step_params['step_id']
      match_requirements[:step_id] = workflow_step_params['step_id']
    end

    render json: WorkflowStep.where(match_requirements)
  end

  # POST /workflow/1/steps + param
  # POST /workflow/1/steps.json + param
  def create
    @workflow_step = WorkflowStep.new(workflow_step_params)

    if @workflow_step.save
      render status: :created, json: @workflow_step
    else
      render json: @workflow_step.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /workflow/1/steps + param
  # PATCH/PUT /workflow/1/steps.json + param
  def update
    if @workflow_step.update(workflow_step_params)
      render :show, status: :ok, location: @workflow_step
    else
      render json: @workflow_step.errors, status: :unprocessable_entity
    end
  end

  # DELETE /workflow/1/steps + param
  # DELETE /workflow/1/steps.json + param
  def destroy
    @workflow_step.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workflow_step
      @workflow_step = params[:id] ?
        WorkflowStep.find(params[:id]) :
        WorkflowStep.where(
          workflow_id: workflow_step_params['workflow_id'],
          step_id: workflow_step_params['step_id'],
        ).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def workflow_step_params
      params.permit(:workflow_id, :step_id)
    end
end
