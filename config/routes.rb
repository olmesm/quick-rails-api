Rails.application.routes.draw do

  resources :organizations

  resources :boards do
    resource 'workflows', controller: :board_workflows
  end

  resources :workflows do
    resource 'boards', controller: :board_workflows
    resource 'steps', controller: :workflow_steps
  end

  resources :steps do
    resource 'workflows', controller: :workflow_steps
    resource 'tasks', controller: :step_tasks
  end

  resources :tasks do
    resource 'steps', controller: :step_tasks
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
