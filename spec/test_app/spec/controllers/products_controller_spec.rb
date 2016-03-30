require 'rails_helper'

RSpec.describe ProductsController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # Product. As you add validations to Product, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    FactoryGirl.attributes_for(:product)
  }

  let(:invalid_attributes) {
    {foo: "bar", net_price: "abc", product_title: ""}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ProductsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all products as @products" do
      product = Product.create! valid_attributes
      get :index, {}
      expect(assigns(:products).to_a).to eq([product])
    end
  end

  describe "GET #show" do
    it "assigns the requested product as @product" do
      product = Product.create! valid_attributes
      get :show, {:id => product.to_param}, valid_session
      expect(assigns(:product)).to eq(product)
    end
  end

  describe "GET #new" do
    it "assigns a new product as @product" do
      get :new, {}
      expect(assigns(:product)).to be_a_new(Product)
    end
  end

  describe "GET #edit" do
    it "assigns the requested product as @product" do
      product = Product.create! valid_attributes
      get :edit, {:id => product.to_param}, valid_session
      expect(assigns(:product).to_a).to eq([product])
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Product" do
        expect {
          post :create, {:product => valid_attributes}, valid_session
        }.to change(Product, :count).by(1)
      end

      it "assigns a newly created product as @product" do
        post :create, {:product => valid_attributes}, valid_session
        expect(assigns(:product)).to be_a(Product)
        expect(assigns(:product)).to be_persisted
      end

      it "redirects to the created product" do
        post :create, {:product => valid_attributes}, valid_session
        expect(response).to redirect_to(Product.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved product as @product" do
        post :create, {:product => invalid_attributes}
        expect(assigns(:product)).to be_a_new(Product)
      end

      it "re-renders the 'new' template" do
        post :create, {:product => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    render_views

    context "with valid params" do

      let(:new_attributes) {
        {product_title: "Blah", sku: "123-ABC", net_price: 123.55}
      }

      it "updates the requested product" do
        product = Product.create! valid_attributes
        put :update,:id => product.to_param, :product => new_attributes
        product.reload

        expect(product.product_title).to eql(new_attributes[:product_title])
      end

      it "assigns the requested product as @product" do
        product = Product.create! valid_attributes
        put :update, {:id => product.to_param, :product => valid_attributes}, valid_session
        expect(assigns(:product).to_a).to eq([product])
      end

      it "redirects to the product" do
        product = Product.create! valid_attributes
        put :update, {:id => product.to_param, :product => valid_attributes}, valid_session
        expect(response).to redirect_to(product)
      end
    end

    context "with invalid params" do

      it "assigns the product as @product" do
        product = Product.create! valid_attributes
        put :update, {:id => product.to_param, :product => invalid_attributes}
        expect(assigns(:product)).to eq(product)
      end

      it "re-renders the 'edit' template" do
        product = Product.create! valid_attributes
        put :update, {:id => product.to_param, :product => invalid_attributes}
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested product" do
      product = Product.create! valid_attributes
      expect {
        delete :destroy, {:id => product.to_param}, valid_session
      }.to change(Product, :count).by(-1)
    end

    it "redirects to the products list" do
      product = Product.create! valid_attributes
      delete :destroy, {:id => product.to_param}, valid_session
      expect(response).to redirect_to(products_url)
    end
  end

end
