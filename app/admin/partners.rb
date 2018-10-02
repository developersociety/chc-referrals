ActiveAdmin.register Partner do
  permit_params :accepting_referrals, :form_identifier, :form_url,
                :max_monthly_referrals, :name

  controller do
    def find_resource
      scoped_collection.where(slug: params[:id]).first!
    end
  end

  index do
    selectable_column
    column :name
    column :accepting_referrals
    column :max_monthly_referrals
    column 'Webhook URL' do |partner|
      host = "#{request.host}:#{request.port}"
      url_helpers = Rails.application.routes.url_helpers
      url_helpers.webhooks_new_response_url(partner.webhook_token, host: host)
    end
    actions
  end

  filter :name
  filter :max_monthly_referrals
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :accepting_referrals
      f.input :max_monthly_referrals
      f.input :form_url
      f.input :form_identifier
    end
    f.actions
  end
end
