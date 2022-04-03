module SwaggerHelpers
  def api_response(data = {})
    {
      type: :object,
      required: %i[data],
      data: {
        type: :object,
        properties: {}.merge(data)
      }
    }
  end

  def api_error_response
    {
      type: :object,
      required: %i[error],
      error: { type: :string, description: 'Error message' }
    }
  end
end
