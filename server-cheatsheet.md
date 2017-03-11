# Rails API server Cheatsheet

Rails is still cool. API server up and running in less than 5 minutes.

This is fairly comprehensive. Does not include all thats required, but the gist of it.

Leggo.

## Rails Generator

```bash
rails new flowtactk-server --api -d postgresql -T
cd flowtactk-server
rails g scaffold organization name:string subdomain:string data:json
rails g scaffold workflow organization:belongs_to name:string description:text data:json
rails g scaffold step organization:belongs_to name:string description:text data:json
rails g scaffold task organization:belongs_to name:string description:text data:json

rails g model OrganizationWorkflow organization:belongs_to workflow:belongs_to
rails g model WorkflowStep workflow:belongs_to step:belongs_to
rails g model StepTask step:belongs_to task:belongs_to
rake db:create
rake db:migrate
```

## Add Gems

```
# Uncomment in Gemfile

gem 'jbuilder', '~> 2.5'
...
gem 'rack-cors'
```

Run `bundle`.

## Setup CORS

config/application.rb

```ruby
...
class Application < Rails::Application
  config.api_only = true

  config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins 'http://localhost:8080' # or whatever your localhost is
      resource '*', :headers => :any, :methods => [:get, :post, :patch, :delete, :options]
    end
  end
end
...
```

## Create Relationships

```ruby
class Organization < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :subdomain, presence: true, uniqueness: true, format: { with: /\A[a-z0-9]+\z/ }

  has_many  :workflows, through: :organization_workflows, uniqueness: true

  def has
    return nil unless self['data'] && self.data['has']
    Workflow.select([:id, :name]).find(self.data['has'])
  end
end
```

```ruby
class Workflow < ApplicationRecord
  belongs_to :organization
  validates :name, presence: true
  validates_uniqueness_of :name, scope: :organization_id

  has_many  :organizations, through: :organization_workflows, uniqueness: true

  def belongs_to
    return nil unless self['data'] && self.data['belongs_to']
    Organization.select([:id, :name]).find(self.data['belongs_to'])
  end

  def has
    return nil unless self['data'] && self.data['has']
    Step.select([:id, :name]).find(self.data['has'])
  end
end
```

## Controllers

```ruby
class WorkflowsController < ApplicationController

  ...
  def show
    render json: @workflow, include: [:has, :belongs_to]
  end
  ...

  private

  ...
  # Never trust parameters from the scary internet, only allow the white list through.
  def workflow_params
    load_params = params.require(:workflow).permit(:name, :description, :organization_id)
    load_params[:data] = params[:workflow][:data]
    load_params.permit!
  end

end
```

## Seeding

db/seeds.rb

```ruby
org_a = Organization.create(name: 'Company A', subdomain: 'companya')

step_1 = Step.create(name: 'Step 1', organization_id: org_a.id)

wrk_1 = Workflow.create(name: 'Workflow 1', data: { steps: [ step_1.id ] }, organization_id: org_a.id)
```
