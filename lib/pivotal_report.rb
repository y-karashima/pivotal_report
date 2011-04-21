require 'pivotal-tracker'

class PivotalReport

  def initialize(token, project_id)
    @token, @project_id = token, project_id
  end

  def project
    @project ||= PivotalTracker::Project.find(@project_id)
  end

  def current_iteration
    @current_iteration ||= PivotalTracker::Iteration.current(project)
  end

  def current_stories
    current_iteration.stories
  end

end
