# typed: ignore
require 'rails_helper'

describe SessionsController, type: :controller do

  describe '#create' do
    let(:email) { 'example@example.com' }
    let(:password) { 'Password1!' }
    let(:wrong_password) { 'Wrong1234' }

    context 'Authenticate' do
      subject { post :create, params: { email: email, password: password } }

      let!(:user) { create(:user, email: email, password: password, password_confirmation: password) }

      it 'saves the user_id to session' do
        subject

        expect(session[:user_id]).to eq(user.id)
      end

      it 'redirects user to the right path' do
        subject

        expect(response).to redirect_to(root_path)
      end

      it 'flashes the right message' do
        subject

        expect(flash[:notice]).to match('Logged in successfully')
      end
    end

    context 'Unauthenticated' do
      context 'missing user' do
        subject { post :create, params: { email: email, password: password }}

        it 'renders the right template' do
          subject

          expect(response).to render_template('new')
        end

        it 'has bad request http status' do
          subject

          expect(response).to have_http_status(:bad_request)
        end

        it 'flashes the right message alert' do
          subject

          expect(flash[:alert]).to match('Invalid email or password')
        end
      end

      context 'when input password is a' do
        before { create(:user, email: email, password: password, password_confirmation: password) }

        it 'wrong password' do
          post :create, params: { email: email, password: wrong_password }
          expect(response).to have_http_status(:bad_request)
        end
      end
    end

    context 'when input has invalid authenticate params like' do
      it 'missing email' do
        post :create, params: { password: password }
        expect(response).to have_http_status(:bad_request)
      end

      it 'missing password' do
        post :create, params: { email: email }
        expect(response).to have_http_status(:bad_request)
      end

      it 'empty email' do
        post :create, params: { email: '', password: password }
        expect(response).to have_http_status(:bad_request)
      end

      it 'empty password' do
        post :create, params: { email: email, password: '' }
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe '#destroy' do
    subject { post :delete, session: { user_id: 1 } }

    it 'sets the session param to nil' do
      subject

      expect(session[:user_id]).to eq(nil)
    end

    it 'redirects to the right path' do
      subject

      expect(response).to redirect_to(root_path)
    end

    it 'flashes the right message' do
      subject

      expect(flash[:notice]).to match('You are logged out')
    end
  end
end
