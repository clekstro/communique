require 'spec_helper'

describe MessagesController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get 'edit'
      response.should be_success
    end
  end

  describe "GET 'update'" do
    it "returns http success" do
      get 'update'
      response.should be_success
    end
  end

  describe "GET 'inbox'" do
    it "returns http success" do
      get 'inbox'
      response.should be_success
    end
  end

  describe "GET 'outbox'" do
    it "returns http success" do
      get 'outbox'
      response.should be_success
    end
  end

  describe "GET 'drafts'" do
    it "returns http success" do
      get 'drafts'
      response.should be_success
    end
  end

  describe "GET 'trash'" do
    it "returns http success" do
      get 'trash'
      response.should be_success
    end
  end

  describe "GET 'read'" do
    it "returns http success" do
      get 'read'
      response.should be_success
    end
  end

  describe "GET 'unread'" do
    it "returns http success" do
      get 'unread'
      response.should be_success
    end
  end

end
