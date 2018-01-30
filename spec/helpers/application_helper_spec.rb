# frozen_string_literal: true

require 'spec_helper'
describe ApplicationHelper, type: :helper do
  describe 'bootstrap class' do
    it 'success' do
      expect(helper.bootstrap_class_for('success')).to have_content('alert-success')
    end
    it 'error' do
      expect(helper.bootstrap_class_for('error')).to have_content('alert-danger')
    end
    it 'alert' do
      expect(helper.bootstrap_class_for('alert')).to have_content('alert-warning')
    end
    it 'notice' do
      expect(helper.bootstrap_class_for('notice')).to have_content('alert-info')
    end
    it 'default' do
      expect(helper.bootstrap_class_for('default')).to have_content('default')
    end
  end
end
