ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation

  controller do
    def update_resource(resource, params)
      resource.update_without_password(params[0]) if params[0][:password].blank?
      super
    end
  end

  index do
    selectable_column
    column :email
    column :created_at
    actions
  end

  filter :email
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
