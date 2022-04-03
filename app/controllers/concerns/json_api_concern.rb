module JsonApiConcern
  def render_json(data, status: :ok)
    render json: { data: ActiveModelSerializers::SerializableResource.new(data) }, status:
  end

  def render_error(error, status: :unprocessable_entity)
    render json: { error: }, status:
  end
end
