class UsersController < ApplicationController
  def edit
    @userId = params[:user_id].blank? ? nil : params[:user_id]
    @metricId = params[:metric_id].blank? ? nil : params[:metric_id]
    @valueId = params[:value_id].blank? ? nil : params[:value_id]
    @user = @userId.blank? ? nil : JSON.parse(@hoopla_client.get("#{HooplaClient::PUBLIC_API_ENDPOINT}/users/#{@userId}", "list_user").to_json, object_class: OpenStruct)
    @metric = @metricId.blank? ? nil : JSON.parse(@hoopla_client.get("#{HooplaClient::PUBLIC_API_ENDPOINT}/metrics/#{@metricId}", {}).to_json, object_class: OpenStruct)
    @metricValue = (@metricId.blank? || @valueId.blank?) ? nil : JSON.parse(@hoopla_client.get("#{HooplaClient::PUBLIC_API_ENDPOINT}/metrics/#{@metricId}/values/#{@valueId}", {}).to_json, object_class: OpenStruct)
  end

  def update
    @firstName = params[:first_name].blank? ? nil : params[:first_name]
    @lastName = params[:last_name].blank? ? nil : params[:last_name]
    @email = params[:email].blank? ? nil : params[:email]
    @metricValue = params[:metric_value].blank? ? nil : params[:metric_value]
    @metricLink = params[:metric_link].blank? ? nil : params[:metric_link]
    @userId = params[:user_id].blank? ? nil : params[:user_id]
    @metricId = params[:metric_id].blank? ? nil : params[:metric_id]
    @valueId = params[:metric_value_id].blank? ? nil : params[:metric_value_id]

    @hoopla_client.put("#{HooplaClient::PUBLIC_API_ENDPOINT}/metrics/#{@metricId}/values/#{@valueId}", {"owner": {"kind": "user", "href": "#{HooplaClient::PUBLIC_API_ENDPOINT}/users/#{@userId}"}, "value": @metricValue})
    @hoopla_client.put("#{HooplaClient::PUBLIC_API_ENDPOINT}/users/#{@userId}", {"first_name": @firstName, "last_name": @lastName, "email": @email})
    redirect_to "/metrics/#{@metricId}"
  end
end
