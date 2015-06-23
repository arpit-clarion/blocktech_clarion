require "rails_helper"

RSpec.describe HistoriansController do
  describe "GET index" do
    it "assigns @historians" do
      get :index
      byebug
      historian = Historian.create(:historian)
      expect(historians).to be_success
    end

    it "renders the index template" do
    #   get :index
    #   expect(response).to render_template("index")
    end
  end
end