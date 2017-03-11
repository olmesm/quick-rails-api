class BoardWorkflowsController < ApplicationController
  before_action :set_board_workflow, only: [:show, :update, :destroy]

  # GET /board_workflows
  # GET /board_workflows.json
  def index
    @board_workflows = BoardWorkflow.all
  end

  # GET /board_workflows/1
  # GET /board_workflows/1.json
  def show
    match_requirements = {}

    if board_workflow_params['workflow_id']
      match_requirements[:workflow_id] = board_workflow_params['workflow_id']
    end

    if board_workflow_params['board_id']
      match_requirements[:board_id] = board_workflow_params['board_id']
    end

    render json: BoardWorkflow.where(match_requirements)
  end

  # POST /board_workflows
  # POST /board_workflows.json
  def create
    @board_workflow = BoardWorkflow.new(board_workflow_params)

    if @board_workflow.save
      render status: :created, json: @board_workflow
    else
      render json: @board_workflow.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /board_workflows/1
  # PATCH/PUT /board_workflows/1.json
  def update
    if @board_workflow.update(board_workflow_params)
      render :show, status: :ok, location: @board_workflow
    else
      render json: @board_workflow.errors, status: :unprocessable_entity
    end
  end

  # DELETE /board_workflows/1
  # DELETE /board_workflows/1.json
  def destroy
    @board_workflow.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board_workflow
      @board_workflow = params[:id] ?
        BoardWorkflow.find(params[:id]) :
        BoardWorkflow.where(
          board_id: board_workflow_params['board_id'],
          workflow_id: board_workflow_params['workflow_id'],
        ).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def board_workflow_params
      params.permit(:workflow_id, :board_id)
    end
end
