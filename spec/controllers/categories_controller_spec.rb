require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:category) { FactoryBot.create(:category) }
  let(:uncorrect_category) { FactoryBot.build(:uncorrect_category) }

  describe 'GET #index' do
    it 'renders the :index view' do
      get :index
      expect(response.status).to eq(200)
      expect(response).to render_template('index')
      expect(response.body).to eq ''
    end

  end
  describe 'GET #show' do
    it 'show category' do
      get :show, params: {id: category.id}
      expect(assigns(:category)).to eq(category)
      expect(response).to render_template :show
    end
  end

  describe 'POST create' do
    context 'with valid attributes' do
      it 'creates a new category' do
        expect {
          post :create, params: {category: category.attributes}
        }.to change(Category, :count).by(1) and redirect_to(Category.first)
      end
    end

    context 'with invalid attributes' do   # add redirect with login
      it 'does not save the new category' do
        expect {
          post :create, params: {category: uncorrect_category.attributes}
        }.to_not change(Category, :count)
      end
    end
  end

  # rest of spec omitted ...
  describe 'PUT update' do
    before :each do
      @category = FactoryBot.create(:random_category)
    end

    context 'valid attributes' do
      # it 'located the requested @category' do
      #   put :update, params: {id: @category.id, category: category.attributes}
      #   expect(assigns(:category)).to eq(@category)
      # end

    #   it "changes @contact's attributes" do
    #     put :update, id: @contact,
    #         contact: Factory.attributes_for(:contact, firstname: "Larry", lastname: "Smith")
    #     @contact.reload
    #     @contact.firstname.should eq("Larry")
    #     @contact.lastname.should eq("Smith")
    #   end
    #
    #   it "redirects to the updated contact" do
    #     put :update, id: @contact, contact: Factory.attributes_for(:contact)
    #     response.should redirect_to @contact
    #   end
    # end
    #
    # context "invalid attributes" do
    #   it "locates the requested @contact" do
    #     put :update, id: @contact, contact: Factory.attributes_for(:invalid_contact)
    #     assigns(:contact).should eq(@contact)
    #   end
    #
    #   it "does not change @contact's attributes" do
    #     put :update, id: @contact,
    #         contact: Factory.attributes_for(:contact, firstname: "Larry", lastname: nil)
    #     @contact.reload
    #     @contact.firstname.should_not eq("Larry")
    #     @contact.lastname.should eq("Smith")
    #   end
    #
    #   it "re-renders the edit method" do
    #     put :update, id: @contact, contact: Factory.attributes_for(:invalid_contact)
    #     response.should render_template :edit
    #   end
    end
  end
end
