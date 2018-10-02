ActiveAdmin.register User do
  permit_params :email, :first_name, :last_name, :password,
                :password_confirmation

  controller do
    def update_resource(resource, params)
      resource.update_without_password(params[0]) if params[0][:password].blank?
      super
    end
  end

  index do
    selectable_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :first_name
  filter :last_name
  filter :email
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
