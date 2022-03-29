class NodesController < ApplicationController
  def index
    @nodes = Node.includes(:records).all
  end

  def show
    @node = Node.includes(:records).find(params[:id])

    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: "Records")
      f.yAxis(
        title: { text: "Soil moisture" },
        plotLines: [
          { value: @node.max_moisture, color: 'green', dashStyle: 'shortdash', width: 2, label: { text: "Max. moisture" } },
          { value: @node.min_moisture, color: 'red', dashStyle: 'shortdash', width: 2, label: { text: "Min. moisture" } },
        ],
        min: 250,
        max: 500
      )

      f.xAxis(type: 'datetime', title: { text: "Date" })

      f.series(
        data: @node.records.select(:created_at, :moisture).map do |record|
          [record.created_at.to_i * 1000, record.moisture]
        end
      )

      f.legend(enabled: false)
    end
  end

  def new
  end
end
