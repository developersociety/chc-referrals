ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc{ I18n.t('active_admin.dashboard') }

  content title: proc{ I18n.t('active_admin.dashboard') } do
    columns do
      column do
        panel 'Admin Users' do
          h1 AdminUser.count
        end
      end

      column do
        panel 'Users' do
          h1 User.count
        end
      end
    end

    columns do
      column do
        panel 'Partners' do
          h1 Partner.count
        end
      end

      column do
        panel 'Referrals' do
          h1 Referral.count
        end
      end

      column do
        panel 'Reviews' do
          h1 Review.count
        end
      end
    end
  end
end
