class RoadmapsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]

  def index
    @results = Roadmaps::RoadmapsIndex.new.roadmaps_index
    store_last_index_page
    authorize Feedback
  end
end
