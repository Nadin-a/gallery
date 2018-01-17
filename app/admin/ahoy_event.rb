# frozen_string_literal: true

ActiveAdmin.register Ahoy::Event do
  permit_params :user, :name, :visit, :time

  controller do
    def index
      respond_to do |format|
        format.html { super }
        format.csv { super }
        format.pdf do
          @events = Ahoy::Event.all
          render pdf: 'index', layout: 'pdf', template: 'admin/events.html.haml'
        end
      end
    end
  end

  csv do
    column(:user) { |event| event.user.name }
    column :url.map(&:name)
    column :properties do |event|
      event.properties['action_type']
    end
    column :time
  end

  index download_links: %i[csv pdf] do
    column :user
    column 'URL', :name
    column :properties do |event|
      link_to(event.properties['action_type'], admin_ahoy_event_path(event))
    end
    column :time
  end

  member_action :pdf do
    Ahoy::Event.find params[:id]
    respond_to do |format|
      format.pdf do
        render_to_string pdf: 'pdf'
      end
    end
  end
end
