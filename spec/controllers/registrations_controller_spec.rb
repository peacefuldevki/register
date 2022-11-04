# typed: ignore
require 'rails_helper'

describe RegistrationsController, type: :controller do

  describe '#create' do
    let(:email) { 'example@example.com' }
    let(:password) { 'Password1!' }
    let(:wrong_password) { 'Wrong1234' }

    context 'when it creates the user' do
      subject { post :create, params: { user: { email: email, password: password, password_confirmation: password } } }

      it 'saves the user_id to session' do
        subject

        expect(session[:user_id]).to eq(1)
      end

      it 'redirects user to the right path' do
        subject

        expect(response).to redirect_to(root_path)
      end

      it 'flashes the right message' do
        subject

        expect(flash[:notice]).to match('Your account was successfully created')
      end
    end

    context 'when it fails in creating the user' do
      context 'wrong password confirmation' do
        subject { post :create, params: { user: { email: email, password: password, password_confirmation: '123' } } }

        it 'renders the right template' do
          subject

          expect(response).to render_template('new')
        end

        it 'has bad request http status' do
          subject

          expect(response).to have_http_status(:bad_request)
        end
      end
    end

  end

end
