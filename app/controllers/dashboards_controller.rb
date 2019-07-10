class DashboardsController < ApplicationController

  def index
    metrics_path = @hoopla_client.get_relative_url("list_metrics")
    @metrics = JSON.parse(@hoopla_client.get(metrics_path, {}).to_json, object_class: OpenStruct)
    @metrics = Kaminari.paginate_array(@metrics).page(params[:page]).per(10)
  end
end
