class UsersController < ApplicationController
  def edit
    userId = params[:user_id].blank? ? nil : params[:user_id]
    @user = userId.blank? ? nil : @hoopla_client.get("#{HooplaClient::PUBLIC_API_ENDPOINT}/users/#{userId}", "list_user")
  end
end
