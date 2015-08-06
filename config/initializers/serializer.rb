# # Disable for all serializers (except ArraySerializer)
# ActiveModel::Serializer.root = true
#
# # Disable for ArraySerializer
# ActiveModel::ArraySerializer.root = true
#
ActiveModel::Serializer.setup do |config|
  config.embed = :ids
  config.embed_in_root = true
end
