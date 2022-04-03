require 'swagger_helper'

RSpec.describe 'Api::V1::Stocks', type: :request, swagger_doc: '/v1/api.json' do
  let_it_be(:bearer) { create(:bearer) }
  let_it_be(:stock) { create(:stock, bearer: bearer) }

  path '/stocks' do
    get 'Get stocks list' do
      tags 'Stocks'

      consumes 'application/json'
      produces 'application/json'

      response 200, 'Success' do
        schema api_response(
          type: :array,
          items: {
            type: :object,
            required: %i[id name bearer],
            properties: {
              id: { type: :integer, description: 'Stock id' },
              name: { type: :string, description: 'Stock name' },
              bearer: {
                type: :object,
                required: %i[id name],
                properties: {
                  id: { type: :integer, description: 'Bearer id' },
                  name: { type: :string, description: 'Bearer name' }
                }
              }
            }
          }
        )

        run_test!
      end
    end

    post 'Create stock' do
      tags 'Stocks'

      consumes 'application/json'
      produces 'application/json'

      parameter name: :body, in: :body, schema: {
        type: :object,
        required: %i[stock],
        properties: {
          stock: {
            type: :object,
            required: %i[name bearer_name],
            properties: {
              name: { type: :string, description: 'Stock name' },
              bearer_name: { type: :string, description: 'Bearer name' }
            }
          }
        }
      }

      response 201, 'Created' do
        schema api_response(
          type: :object,
          required: %i[id name bearer],
          properties: {
            id: { type: :integer, description: 'Stock id' },
            name: { type: :string, description: 'Stock name' },
            bearer: {
              type: :object,
              required: %i[id name],
              properties: {
                id: { type: :integer, description: 'Bearer id' },
                name: { type: :string, description: 'Bearer name' }
              }
            }
          }
        )

        let(:body) { { stock: { name: 'qwe', bearer_name: bearer.name } } }

        run_test!
      end

      response 422, 'Unprocessable entity' do
        let(:stock_id) { stock.id }
        let(:body) { { stock: { name: '' } } }
        schema api_error_response

        run_test!
      end
    end
  end

  path '/stocks/{stock_id}' do
    parameter name: :stock_id, in: :path, type: :integer

    patch 'Update stock' do
      tags 'Stocks'

      consumes 'application/json'
      produces 'application/json'

      parameter name: :body, in: :body, schema: {
        type: :object,
        required: %i[stock],
        properties: {
          stock: {
            type: :object,
            required: %i[name],
            properties: {
              name: { type: :string, description: 'Stock name' },
              bearer_name: { type: :string, description: 'Bearer name' }
            }
          }
        }
      }

      response 200, 'Updated' do
        schema api_response(
          type: :object,
          required: %i[id name bearer],
          properties: {
            id: { type: :integer, description: 'Stock id' },
            name: { type: :string, description: 'Stock name' },
            bearer: {
              type: :object,
              required: %i[id name],
              properties: {
                id: { type: :integer, description: 'Bearer id' },
                name: { type: :string, description: 'Bearer name' }
              }
            }
          }
        )

        let(:stock_id) { stock.id }
        let(:body) { { stock: { name: 'qwe', bearer_name: bearer.name } } }

        run_test!
      end

      response 404, 'Not found' do
        let(:stock_id) { stock.id + 1000 }
        schema api_error_response

        run_test!
      end

      response 422, 'Unprocessable entity' do
        let(:stock_id) { stock.id }
        let(:body) { { stock: { name: '' } } }
        schema api_error_response

        run_test!
      end
    end

    delete 'Delete stock' do
      tags 'Stocks'

      consumes 'application/json'
      produces 'application/json'

      response 204, 'Deleted' do
        let(:stock_id) { stock.id }

        run_test!
      end

      response 404, 'Not found' do
        let(:stock_id) { stock.id + 1000 }
        schema api_error_response

        run_test!
      end
    end
  end
end
