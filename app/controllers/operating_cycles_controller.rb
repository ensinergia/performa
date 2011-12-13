class OperatingCyclesController < ApplicationController
  def new
    @operating_cycle = OperatingCycle.new
  end
end
