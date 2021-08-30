class RoadmapsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]

  def index
    @results = Roadmaps::RoadmapsIndex.new.roadmaps_index
    authorize Feedback
  end
end
