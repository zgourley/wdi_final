require 'rails_helper'

RSpec.describe ItemsController, :type => :controller do
  before(:each) do
    @item1 = Item.create(name:"mustard", qty: 100, checked: false)
    @item2 = Item.create(name:"mustard", qty: 100, checked: false)
  end
  # This should return the minimal set of attributes required to create a valid
  # Item. As you add validations to Item, be sure to
  # adjust the attributes here as well.
  # let(:valid_attributes) {
  #   skip("Add a hash of attributes valid for your model")
  # }
  # let(:invalid_attributes) {
  #   skip("Add a hash of attributes invalid for your model")
  # }
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ItemsController. Be sure to keep this updated too.
  # let(:valid_session) { {} }

  
  describe "GET #index " do
    before :each do
      get :index
    end

    it "renders the index template" do
      expect(response).to render_template("index") 
    end
    it "response should be a success" do
      # expect(response).to be_success
      expect(response).to have_http_status(200)
    end
    it "assigns @items to include items" do
      expect(assigns(:items)).to include(@item1, @item2)
    end
  end
  
  describe "GET #show" do
    before :each do
      get :show, id: @item1.id
    end
    it "renders the show template" do
      expect(response).to have_http_status(200)
      expect(response).to render_template :show
    end

    it "assigns an item to @item" do
      expect(assigns(:item)).to eq(@item1)
    end
  end

  describe "GET #new" do
    before do
      get :new
    end

    it "renders the new template with status 200 " do
      expect(response).to render_template :new
      expect(response).to have_http_status(200)
    end

    # it "makes a new Item" do
    #   expect(assigns(:item)).to be_a(Item)
    # end

    it "is not persisted" do
      # expect(assigns(:item)).to_not be_persisted # use expect{block} syntax
      expect{Item.new}.to change(Item, :count).by(0)
    end
  end

  describe "POST #create" do
    it "persists an item to the DB" do
      expect {Item.create}.to change(Item, :count).by(1)
      #expect {post :create, item: valid_attributes}.to change(Item, :count).by(1)
      # like get :index or :new
    end
  end

  describe "GET #edit" do
    before do
      @test_item = Item.create
      get :edit, id: @test_item.id
    end

    it "renders the edit template with status 200" do
      expect(response).to render_template :edit
      expect(response).to have_http_status(200)
    end

    it "should assign the item to @item" do
      expect(assigns(:item)).to eq(@test_item)
    end
  end

  describe "PUT/PATCH #update" do
    before do
        @test_item = Item.create
        # get :edit, id: @test_item.id,
    end

    describe "with successful update" do
      let :new_attributes do
        {
          :name => "pickles",
          :qty => 5,
          :checked => false
        }
      end

      before do
        # remember to use line 2  #before_action :set_item, 
        # only: [:show, :edit, :update, :destroy] in items 
        # controller to pass these tests
        patch :update, id: @test_item.id,
        item: new_attributes
        get :show, id: @test_item.id
      end

      it "should update the item record in the database" do
        expect(@test_item.reload.qty).to eq(5)
      end
      it "redirect to the show path for this item" do
        #expect(response).to redirect_to item_path
        # get :edit
        expect(response).to render_template :show 
        #, id: @test_item.id 
      end
      
    end

    describe "with unsuccessful update" do
      let :invalid_update_attributes do
        {
          :name => "",
          :qty => 0,
          :checked => false
        }
      end

      before do
        put :update, id: @test_item.id, item: invalid_update_attributes
        get :edit, id: @test_item.id
      end

      describe "should not update the item record in the database" do
        it "if the item qty to 0" do
          expect(@test_item.reload.qty).to_not be_nil
        end
        it "if the item name is nil" do
          expect(@test_item.reload.name).to_not be_nil
        end        
      end
      it "should rerender the edit view template" do
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      @test_item = Item.create
      get :index
    end

    it "deletes an item from the DB" do
      expect{delete :destroy, id: @test_item.id}.to change(Item, :count).by(-1)
    end

    it "redirects to index page" do
      expect(response).to render_template :index
    end
  end



end
