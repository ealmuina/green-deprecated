class NodesController < ApplicationController
  def index
    @nodes = Node.includes(:records).all
  end

  def show
    @node = Node.includes(:records).find(params[:id])
  end

  def new
  end
end
