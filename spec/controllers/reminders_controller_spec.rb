# frozen_string_literal: true

require 'rails_helper'

describe RemindersController do
  let(:user) { User.create(email: 'tiago@example.com', password: 123123123, password_confirmation: 123123123) }
  let(:reminder) { Reminder.create(user: user, title: 'a', description: 'b', remind_at: 2.days.from_now) }
  context 'as logged in user' do
    before { sign_in(user) }

    describe '#index' do
      it 'should have access to the reminders#index page' do
        get :index
        expect(response.status).to eq 200
      end
    end

    describe '#edit' do
      it 'should have access to the reminders#edit page' do
        get :edit, params: { id: reminder.id }
        expect(response.status).to eq 200
      end
    end

    describe '#create' do
      context 'request with complete form' do
        it 'should be able to create a reminder' do
          expect {
            post :create, params: { reminder: {
              title: 'b', description: 'a', remind_at: 3.days.from_now }
            }
          }.to change { Reminder.count }.by 1
        end
      end

      context 'request with incomplete form' do
        it 'should not be able to create a reminder' do
          expect {
            post :create, params: { reminder: {
              title: 'b', description: 'a' }
            }
          }.to_not change { Reminder.count }
        end
      end
    end

    describe '#update' do
      it 'should not be able to create a reminder' do
        expect {
          patch :update, params: {
            id: reminder.id, reminder: { title: 'abc' }
          }
        }.to change { reminder.reload.title }
      end
    end

    describe '#delete' do
      let!(:reminder2) { Reminder.create(user: user, title: 'a', description: 'b', remind_at: 2.days.from_now) }

      it 'should delete a reminder' do
        expect {
          delete :destroy, params: { id: reminder2.id }
        }.to change { Reminder.count }.from(1).to(0)
      end
    end
  end

  context 'as logged out user' do
    describe '#index' do
      it 'should have access to the reminders#index page' do
        get :index
        expect(response.status).to eq 302
      end
    end

    describe '#edit' do
      it 'should have access to the reminders#edit page' do
        get :edit, params: { id: reminder.id }
        expect(response.status).to eq 302
      end
    end

    describe '#create' do
      it 'should not be able to create a reminder' do
        expect {
          post :create, params: { reminder: {
            title: 'b', description: 'a', remind_at: 3.days.from_now }
          }
        }.to_not change { Reminder.count }
      end
    end

    describe '#update' do
      it 'should not be able to create a reminder' do
        patch :update, params: { id: reminder.id, reminder: { title: 'abc' } }
        expect(response.status).to eq 302
      end
    end

    describe '#delete' do
      let!(:reminder2) { Reminder.create(user: user, title: 'a', description: 'b', remind_at: 2.days.from_now) }

      it 'should not delete a reminder' do
        expect {
          delete :destroy, params: { id: reminder2.id }
        }.to_not change { Reminder.count }
      end
    end
  end
end
