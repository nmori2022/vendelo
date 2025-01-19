require 'test_helper'
class ProductsControllerTest < ActionDispatch::IntegrationTest


  test 'render a list of products' do
    get products_path
    assert_response :success
    assert_select '.product', 2
  end

  test 'render a detailed product page' do
    get product_path(products(:ps4).id)
    assert_response :success
    assert_select '.title', text: products(:ps4).title  
    assert_select '.price', text: products(:ps4).price.to_s
    assert_select '.description', text: products(:ps4).description
  end

  test 'render a new product form' do
    get new_product_path
    assert_response :success
    assert_select 'form'
  end

  test 'allow to create a new product' do
    post products_path, params: {
      product: {
        title: 'Nintendo 64', 
        description: 'Le faltan los cables',
        price: 45
      }
    }

    assert_redirected_to products_path
    assert_equal flash[:notice], 'Tú producto se ha creado correctamente'
  end
  
  test 'does not allow to create a new product with empty fields' do
    post products_path, params: {
      product: {
        title: '', 
        description: 'Le faltan los cables',
        price: 45
      }
    }

    assert_response :unprocessable_entity
  end

  test 'render a an edit product form' do
    get edit_product_path(products(:ps4).id)
    assert_response :success
    assert_select 'form'
  end

  test 'allow to update a product' do
    patch product_path(products(:ps4).id), params: {
      product: {
        price: 165
      }
    }
    
     assert_redirected_to products_path
     assert_equal flash[:notice], 'Tú producto se ha actualizado correctamente'
  end

  test 'does not allow to update a product with empty fields' do
    patch product_path(products(:ps4).id), params: {
      product: {
        price: nil
      }
    }
    
    assert_response :unprocessable_entity
  end

  test 'can delete products' do
    assert_difference('Product.count', -1) do
      delete product_path(products(:ps4).id)
    end   
    assert_redirected_to products_path
    assert_equal flash[:notice], 'Tú producto se ha eliminado correctamente'
  end
end