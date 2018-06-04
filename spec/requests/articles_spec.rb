require 'rails_helper'

RSpec.describe "Articles", type: :request do

  before do
    @article = Article.create(title: "Title", body: "This is the body")
  end

  describe "GET /articles/:id" do

    context "with existing article" do
      before { get "/articles/#{@article.id}" }
      it "handles existing articles" do
        expect(response.status).to eq 200
      end
    end

    context "with non-existing article" do
      before { get "/articles/xxxx" }
      it "handles non-existing articles" do
        # 302 is a HTTP redirect
        expect(response.status).to eq 302
        flash_message = "The article cannot be found"
        expect(flash[:alert]).to eq flash_message
      end
    end

  end
end