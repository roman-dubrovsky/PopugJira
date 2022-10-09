class TasksController < ApplicationController
  helper_method :current_task
  before_action :autorize_admin!, only: :shuffle

  def index
    @tasks = tasks_scope.includes(:creator, :owner)
  end

  def show
    @logs = current_task.task_state_logs.includes(:actor, :owner)
  end

  def new
    @task = Task.new
  end

  def create
    result = Task::Create.call(account: current_account, params: task_params)
    if result.success?
      redirect_to tasks_path
    else
      @task = result.task
      render :new
    end
  end

  def complete
    Task::Complete.call(account: current_account, task: current_task)
    redirect_to task_path(current_task)
  end

  def shuffle
    Task::Shuffle.call(account: current_account)
    redirect_to tasks_path
  end

  private

  def current_task
    @_current_task ||= tasks_scope.find(params[:id])
  end

  def tasks_scope
    if current_account.admin?
      Task.all
    else
      current_account.tasks
    end
  end

  def task_params
    params.require(:task).permit(:title)
  end
end