# -*- coding: utf-8 -*-
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'pivotal_report'

describe "PivotalReport" do

  mock_proj_id = "mock_project_id"
  mock_token = "mock_token"

  before do
    @pivo_report = PivotalReport.new(mock_token, mock_proj_id)
    @project = PivotalTracker::Project.new
    @current_iteration = PivotalTracker::Iteration.new
    PivotalTracker::Project.should_receive(:find).with(mock_proj_id).and_return(@project)
  end

  it "projectが正しく取得できること" do
    @pivo_report.project.should be_a(PivotalTracker::Project)
  end
  
  context "Iterationを使う場合" do

    before do
      PivotalTracker::Iteration.should_receive(:current).with(@project).and_return(@current_iteration)
    end

    it "currentのiterationが正しく取得できること" do
      @pivo_report.current_iteration.should be_a(PivotalTracker::Iteration)
    end

    it "currentのstoryが正しく取得できること" do
      @current_iteration.should_receive(:stories).and_return([PivotalTracker::Story.new])
      stories =  @pivo_report.current_stories
      stories.should be_a(Array)
      stories.each do |story|
        story.should be_a(PivotalTracker::Story)
      end
    end
  end
end
