class MetricsController < ApplicationController

  def index

  end

  def show
    metricId = params[:metric_id].blank? ? nil : params[:metric_id]
    @metric = metricId.blank? ? nil : JSON.parse(@hoopla_client.get("#{HooplaClient::PUBLIC_API_ENDPOINT}/metrics/#{metricId}", {}).to_json, object_class: OpenStruct)
  end
end
