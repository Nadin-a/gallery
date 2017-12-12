ActiveAdmin.register_page 'Dashboard' do

  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    columns do

      column do
        panel 'Recent commentaries' do
          ul do
            Comment.first(5).map do |comment|
              li comment.content
              span 'Author: ' + comment.user.name
            end
          end
        end
      end

      column do
        panel 'Recent categories' do
          ul do
            Category.first(5).map do |category|
              li link_to(category.name, category_path(category))
            end
          end
        end
      end

    end

    panel 'Recent images' do
      ul do
        Image.first(10).map do |image|
          span link_to(image_tag(image.picture.small_thumb.url), category_image_path(image.category, image))
        end
      end
    end

    events = Ahoy::Event.where('user_id IS NOT ?', nil).order(time: :desc)

    table_for events do
      user = User.find_by(id: params[:user_id])
      column 'user', user
      column (:properties)do |event|
        link_to(event.properties['action_type'],admin_ahoy_event_path(event))
      end
      column 'URL', :name
      column 'Time', :time
    end

  end
end
