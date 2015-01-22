require 'spec_helper'

describe "routes for Videos" do
  it "routes /videos to videos#index" do
    { :get => "/videos" }.should route_to(
      :controller => "videos",
      :action => "index"
      )
  end
  it "routes /videos/:id to videos#show" do
    { :get => "/videos/1" }.should route_to(
      :controller => "videos",
      :action => "show",
      :id => "1"
      )
  end
end

describe "routes for Users" do
  it "routes /users to users#index" do
    { :get => "/users" }.should route_to(
      :controller => "users",
      :action => "index"
      )
  end
  it "routes /users/:id to users#show" do
    { :get => "/users/1" }.should route_to(
      :controller => "users",
      :action => "show",
      :id => "1"
      )
  end
end
