require 'rails_helper'

RSpec.describe "Articles", type: :request do

  before do
    @fred = User.create(email: 'fred@example.com', password: 'password')
    @john = User.create(email: 'john@example.com', password: 'password')
    @article = Article.create!(title: "Title", body: "This is the body", user: @john)
  end

  describe "GET /articles/:id/edit" do

    context 'with non-signed in user' do
      before { get "/articles/#{@article.id}/edit" }
      it 'redirects to sign in page' do
        expect(response.status).to eq 302
        flash_message = "You need to sign in or sign up before continuing."
        expect(flash[:alert]).to eq flash_message
      end

    end

    context 'with signed in user who is non-owner' do
      before do
        login_as @fred
        get "/articles/#{@article.id}/edit"
      end
      it 'redirects to home page' do
        expect(response.status).to eq 302
        flash_message = "You can only edit or delete your own article"
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'With signed in user as owner, successful edit' do
      before do
        login_as @john
        get "/articles/#{@article.id}/edit"
      end
      it "successfully edits article" do
        expect(response.status).to eq 200
      end
    end
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

  describe 'DELETE /articles/:id' do

    context 'with non-signed in user' do
      before { delete "/articles/#{@article.id}" }
      it 'will redirect to homepage' do
        expect(response.status).to eq 302
        flash_message = "You need to sign in or sign up before continuing."
        expect(flash[:alert]).to eq flash_message
      end
    end

    context 'with non-owner of article' do
      before do
        login_as @fred
        delete "/articles/#{@article.id}"
        it 'will redirect to homepage' do
          expect(response.status).to eq 302
          flash_message = "You can only edit or delete your own article"
          expect(flash[:alert]).to eq flash_message
        end
      end
    end
  end
end