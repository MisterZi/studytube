require 'rails_helper'
require_relative 'support/swagger_helpers'

RSpec.configure do |config|
  config.extend SwaggerHelpers
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    '/v1/api.json' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      servers: [{ url: '/api/v1' }],
      basePath: '/api/v1'
    }
  }

  config.after(:each, type: :request) do |example|
    if response.present? && response.body.present? && response.content_type.include?('application/json')
      example.metadata[:response][:examples] = {
        'application/json' => JSON.parse(response.body, symbolize_names: true)
      }
    end
  end
end
