# frozen_string_literal: true

Rails.application.routes.draw do
  namespace 'campaigns' do
    get 'ordered_campaigns', to: 'ordered_campaigns'
  end
end
